{*******************************************************}
{                                                       }
{       InfoWind.pas                                    }
{                                                       }
{                                                       }
{       Author  : A. Nasir Senturk                      }
{       Website : http://www.shenturk.com               }
{       E-Mail  : freedelphi@shenturk.com               }
{       Create  : 07.12.2006                            }
{       Update  : 21.03.2008                            }
{                                                       }
{*******************************************************}

unit InfoWind;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GdipApi, GdipObj, DirectDraw, StdCtrls, ConstDef, ExtCtrls, TextUtil,
  VarDates;

type
  TInfoTextForm = class(TForm)
    BackgrndLbl: TLabel;
    CloseBtn: TButton;
    InfoTextLbl: TLabel;
    HeaderTextLbl: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
    Opacity: Byte;
    MainBuffer: TGPBitmap;
    DrawCanvas: TGPGraphics;
    IsActive: Boolean;

    CloseImage,
    TopImage,
    MidImage,
    BaseImage,
    OvTopImage,
    OvMidImage,
    OvBaseImage,
    ReflectionImage: TGPBitmap;

    BackScale: Single;

    procedure AllocateHandle;
    procedure ReleaseHandle;
  public
    BackColor: Cardinal;
    GlassEffect: Boolean;
    GlassOpacity: Byte;

    BackgroundStyle: TBackgroundStyle;

    InfoText: WideString;
    InfoTextHeight: Integer;
    EnableFadeEffect: Boolean;
    { v1.50 }
    PrevFormStyle: Cardinal;
    { Public declarations }
    procedure UpdateLayered;
    procedure UpdateMainWindow;
    procedure UpdateBackground;
    procedure PaintBackground;
    procedure PaintButtons;
    procedure HideForm;
    procedure ShowForm;
    procedure FadeInEffect(const Step, Wait, Max: Integer);
    procedure FadeOutEffect(const Step, Wait, Min: Integer);
    procedure PaintInfoText;
    procedure PaintHeaderText;
    procedure GetPropFromOwner;
    procedure UpdateFormStyle;
    procedure PaintLabel(ALabel: TLabel; const WideText: WideString;
      Align: StringAlignment; Color: Cardinal);
    { v1.50 }
    procedure ClearBuffer;
    procedure Hibernate;
    procedure Wakeup;
    procedure HibernateActionExecute(Sender: TObject);
  end;

var
  InfoTextForm: TInfoTextForm;

implementation

uses Main, ActiveX, ComObj, OptnsDlg;

{$R *.dfm}

procedure TInfoTextForm.AllocateHandle;
begin
  MainBuffer := TGPBitmap.Create(Width, Height, PixelFormat32bppARGB);
  DrawCanvas := TGPGraphics.Create(MainBuffer);
end;

procedure TInfoTextForm.FormCreate(Sender: TObject);
begin

  AllocateHandle; { v1.50 }
  
  BackScale := 1.00;

  GetPropFromOwner;

  if GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_LAYERED = 0 then
    SetWindowLong(Handle, GWL_EXSTYLE,
      GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

  CloseImage := TGPBitmap.Create('.\Contents\Resources\UI\Close.png');

  TopImage := TGPBitmap.Create('.\Contents\Resources\Colorize\Top.png');
  MidImage := TGPBitmap.Create('.\Contents\Resources\Colorize\Mid.png');
  BaseImage := TGPBitmap.Create('.\Contents\Resources\Colorize\Base.png');

  OvTopImage := TGPBitmap.Create('.\Contents\Resources\Colorize\Top Overlay.png');
  OvMidImage := TGPBitmap.Create('.\Contents\Resources\Colorize\Mid Overlay.png');
  OvBaseImage := TGPBitmap.Create('.\Contents\Resources\Colorize\Base Overlay.png');
  ReflectionImage := TGPBitmap.Create('.\Contents\Resources\UI\Reflection.png');

  if EnableFadeEffect then Opacity := OpacityMin
  else Opacity := OpacityMax;

  Left := IniFile.ReadInteger(sAppearance, sInfoTextLeft, 331);
  Top := IniFile.ReadInteger(sAppearance, sInfoTextTop, 331);

  UpdateLayered;

  UpdateFormStyle;

end;

procedure TInfoTextForm.FormDestroy(Sender: TObject);
begin
  ReflectionImage.Free;
  OvTopImage.Free;
  OvMidImage.Free;
  OvBaseImage.Free;
  TopImage.Free;
  MidImage.Free;
  BaseImage.Free;
  CloseImage.Free;
  ReleaseHandle;
end;

procedure TInfoTextForm.PaintBackground;
var
  AColor: Cardinal;
  AOpacity: Integer;
  Scale: Single;

  procedure PaintColorizedOverlay;
  var
    Image: TGPBitmap;
    X, Y: Single;
    Attr: TGPImageAttributes;
    ScaledHeight: Cardinal;
  begin
    X := BackgrndLbl.Left;
    Y := BackgrndLbl.Top;
    Image := OvTopImage;
    DrawCanvas.DrawImage(Image, X, Y, Image.GetWidth, Image.GetHeight);

    DrawCanvas.DrawImage(ReflectionImage, X + 7, Y + 3,
      ReflectionImage.GetWidth, ReflectionImage.GetHeight);

    Y := Y + Image.GetHeight;
    Image := OvMidImage;

    Attr := TGPImageAttributes.Create;
    try
      Attr.SetWrapMode(WrapModeTile);
      ScaledHeight := Round(Image.GetHeight * Scale + InfoTextHeight - 14);
      DrawCanvas.SetInterpolationMode(InterpolationModeDefault);

      DrawCanvas.DrawImage(Image,
        MakeRect(X, Y, Image.GetWidth, ScaledHeight),
        0, 0, Image.GetWidth, 0.978 * Image.GetHeight, // Neden 0.978?
        UnitPixel,                                // Mecburen. Yoksa scale edince altta cizgi cikiyor.
        Attr);                                    // Neden cigi cikiyor?
                                                  // Bilmem. GDI+ scale edince alta soft bir golge veriyor.
      Y := Y + ScaledHeight;
      Image := OvBaseImage;
      DrawCanvas.DrawImage(Image, X, Y, Image.GetWidth, Image.GetHeight);

    finally
      Attr.Free;
    end;

  end;

  procedure PaintColorized(Color: Cardinal; Alpha: Byte);
  const
    CMatrix: ColorMatrix = (
      (1.0, 0.0, 0.0, 0.0, 1.0),
      (0.0, 1.0, 0.0, 0.0, 0.0),
      (0.0, 0.0, 1.0, 0.0, 0.0),
      (0.0, 0.0, 0.0, 1.0, 0.0),
      (0.0, 0.0, 0.0, 0.0, 1.0)
    );
  var
    Image: TGPBitmap;
    X, Y: Single;
    Attr: TGPImageAttributes;
    Matrix: ColorMatrix;
    ScaledHeight: Cardinal;
    Brush: TGPSolidBrush;
  begin

    Matrix := CMatrix;

    Matrix[3, 3] := (Alpha / 255);
    Matrix[0, 0] := 2 * (GetRValue(Color) / 255);
    Matrix[1, 1] := 2 * (GetGValue(Color) / 255);
    Matrix[2, 2] := 2 * (GetBValue(Color) / 255);

    Attr := TGPImageAttributes.Create;
    try
      Attr.SetWrapMode(WrapModeTile);
      Attr.SetColorMatrix(Matrix, ColorMatrixFlagsDefault, ColorAdjustTypeBitmap);

      X := BackgrndLbl.Left;
      Y := BackgrndLbl.Top;

      Brush := TGPSolidBrush.Create(aclBlue);
      try
        //DrawCanvas.FillRectangle(Brush, MakeRect(0, 0, Self.Width, Self.Height));
      finally
        Brush.Free;
      end;

      Image := TopImage;

      DrawCanvas.DrawImage(Image,
        MakeRect(X, Y, Image.GetWidth, Image.GetHeight),  // dest rect
        0, 0, Image.GetWidth, Image.GetHeight,       // source rect
        UnitPixel,
        Attr);

      Y := Y + Image.GetHeight;
      Image := MidImage;
      ScaledHeight := Round(Image.GetHeight * Scale + InfoTextHeight - 14);
      
      DrawCanvas.DrawImage(Image,
        MakeRect(X, Y, Image.GetWidth, ScaledHeight),  // dest rect
        0, 0, Image.GetWidth, Image.GetHeight,       // source rect
        UnitPixel,
        Attr);

      Y := Y + ScaledHeight;
      Image := BaseImage;

      DrawCanvas.DrawImage(Image,
        MakeRect(X, Y, Image.GetWidth, Image.GetHeight),  // dest rect
        0, 0, Image.GetWidth, Image.GetHeight,       // source rect
        UnitPixel,
        Attr);

      PaintColorizedOverlay;

    finally
      Attr.Free;
    end;

  end;

begin

  if BackgroundStyle <> bsNone then
  begin
    case BackgroundStyle of
      bsTinyGlass:
        begin
          AColor := clBlack;
          AOpacity := 0;
        end;
      bsDarkGlass:
        begin
          AColor := clBlack;
          AOpacity := 120;
        end;
      bsCoffeeMilk:
        begin
          AColor := RGB(128, 64, 0);
          AOpacity := 255;
        end;
      else begin
        AColor := BackColor;
        if GlassEffect then AOpacity := GlassOpacity
        else AOpacity := $FF;
      end;
    end;

    Scale := BackScale;
    PaintColorized(AColor, AOpacity);

  end;

end;

procedure TInfoTextForm.PaintButtons;
begin

  CloseBtn.Enabled := IsActive and (HavaCivaMainForm.ConnectionStatus <> csConnecting);
  CloseBtn.Visible := HavaCivaMainForm.ConnectionStatus <> csConnecting;

  if CloseBtn.Enabled then begin
    if CloseBtn.Visible then
      DrawCanvas.DrawImage(CloseImage, CloseBtn.Left, CloseBtn.Top,
        CloseImage.GetWidth, CloseImage.GetHeight);
  end;
  
end;

procedure TInfoTextForm.ReleaseHandle;
begin
  if Assigned(MainBuffer) then FreeAndNil(MainBuffer);
  if Assigned(DrawCanvas) then FreeAndNil(DrawCanvas);
end;

procedure TInfoTextForm.UpdateBackground;
begin
  try
    {
    ReleaseHandle;
    AllocateHandle;
    }
    ClearBuffer; { v1.50 }
    PaintBackground;
    UpdateMainWindow;
  finally

  end;
end;

procedure TInfoTextForm.UpdateLayered;
begin
  try

    {
    ReleaseHandle;
    AllocateHandle;
    }
    ClearBuffer; { v1.50 }
    
    GetPropFromOwner;
    
    PaintBackground;
    PaintInfoText;
    PaintButtons;
    PaintHeaderText;
    
    UpdateMainWindow;

  finally

  end;
end;

procedure TInfoTextForm.UpdateMainWindow;
var
  ScrDC, MemDC: HDC;
  BitmapHandle, PrevBitmap: HBITMAP;
  BlendFunc: _BLENDFUNCTION;
  Size: TSize;
  P, S: TPoint;
begin

  ScrDC := CreateCompatibleDC(0);
  MemDC := CreateCompatibleDC(ScrDC);

  MainBuffer.GetHBITMAP(0, BitmapHandle);
  PrevBitmap := SelectObject(MemDC, BitmapHandle);
  Size.cx := Width;
  Size.cy := Height;
  P := Point(Left, Top);
  S := Point(0, 0);

  with BlendFunc do
  begin
    BlendOp := AC_SRC_OVER;
    BlendFlags := 0;
    SourceConstantAlpha := Opacity;
    AlphaFormat := AC_SRC_ALPHA;
  end;

  UpdateLayeredWindow(Handle, ScrDC, @P, @Size, MemDC, @S, 0,
    @BlendFunc, ULW_ALPHA);

  SelectObject(MemDC, PrevBitmap);
  DeleteObject(BitmapHandle);

  DeleteDC(MemDC);
  DeleteDC(ScrDC);

end;

procedure TInfoTextForm.CloseBtnClick(Sender: TObject);
begin
  HavaCivaMainForm.ToggleInfoTextForm(False);
end;

procedure TInfoTextForm.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
begin

  if not IsActive then
  begin
    IsActive := True;
    UpdateFormStyle;
    UpdateLayered;
  end;

  if Button = mbLeft then
  begin
    ReleaseCapture;
    SendMessage( Handle, WM_SYSCOMMAND, SC_DRAGMOVE, 0 );
    GetWindowRect(Handle, R);
    Left := R.Left;
    Top := R.Top;
    UpdateLayered;
  end;

end;

procedure TInfoTextForm.FadeInEffect(const Step, Wait, Max: Integer);
begin
  if not HavaCivaMainForm.EnableFadeEffect then Exit;
  while Opacity < Max do
  begin
    if Opacity + Step >= Max then
    begin
      //Application.ProcessMessages;
      Opacity := Max;
      UpdateMainWindow;
      Break;
    end;
    Opacity := Opacity + Step;
    UpdateMainWindow;
    Sleep(Wait);
  end;
end;

procedure TInfoTextForm.FadeOutEffect(const Step, Wait, Min: Integer);
begin
  if not HavaCivaMainForm.EnableFadeEffect then Exit;
  while Opacity > Min do
  begin
    if Opacity - Step <= Min then
    begin
      //Application.ProcessMessages;
      Opacity := Min;
      UpdateMainWindow;
      Break;
    end;
    Opacity := Opacity - Step;
    UpdateMainWindow;
    Sleep(Wait);
  end;
end;

procedure TInfoTextForm.HideForm;
begin
  if not Self.Visible then Exit;
  if HavaCivaMainForm.EnableFadeEffect then
    FadeOutEffect(OpacityStep, OpacityWait, OpacityMin)
  else begin
    Opacity := OpacityMin;
    UpdateMainWindow;
  end;
  Self.Hide;
end;

procedure TInfoTextForm.ShowForm;
begin
  if Self.Visible then Exit;
  Self.Show;
  if HavaCivaMainForm.EnableFadeEffect then
    FadeInEffect(OpacityStep, OpacityWait, OpacityMax)
  else begin
    Opacity := OpacityMax;
    UpdateMainWindow;
  end;
end;

procedure TInfoTextForm.PaintInfoText;
begin
  PaintLabel(InfoTextLbl, InfoText, StringAlignmentCenter, aclWhite);
end;

procedure TInfoTextForm.GetPropFromOwner;
begin
  BackColor := HavaCivaMainForm.BackColor;
  GlassOpacity := HavaCivaMainForm.GlassOpacity;
  GlassEffect := HavaCivaMainForm.GlassEffect;
  BackgroundStyle := HavaCivaMainForm.BackgroundStyle;
  EnableFadeEffect := HavaCivaMainForm.EnableFadeEffect;
  InfoText := HavaCivaMainForm.GetInfoText;
  InfoTextHeight := HavaCivaMainForm.GetInfoTextHeight;
end;

procedure TInfoTextForm.PaintHeaderText;
var
  WideText: WideString;
begin
  WideText := 'Hava Cýva! Bilgi';
  PaintLabel(HeaderTextLbl, WideText, StringAlignmentNear, aclWhite);
end;

procedure TInfoTextForm.UpdateFormStyle;
begin
  if HavaCivaMainForm.StayOnTop then
    SetWindowPos(Self.Handle, HWND_TOPMOST, 0, 0, 0, 0,
      SWP_NOMOVE or SWP_NOSIZE or SWP_FRAMECHANGED)
  else
    SetWindowPos(Self.Handle, HWND_NOTOPMOST, 0, 0, 0, 0,
      SWP_NOMOVE or SWP_NOSIZE or SWP_FRAMECHANGED);
end;

procedure TInfoTextForm.FormDeactivate(Sender: TObject);
begin
  IsActive := False;
  UpdateLayered;
end;

procedure TInfoTextForm.PaintLabel(ALabel: TLabel;
  const WideText: WideString; Align: StringAlignment; Color: Cardinal);
var
  BR, R: TGPRectF;
begin
  if Assigned(ALabel) and ALabel.Visible then
  begin
    if WideText <> '' then
    begin
      GdiPlusMeasureString(DrawCanvas, WideText, BR, ALabel.Font, Align);
      if ALabel.AutoSize then
        ALabel.ClientWidth := Round(BR.Width) + 1;
      ALabel.ClientHeight := Round(BR.Height) + 1;
      R := MakeRectF(ALabel.BoundsRect);
      OffsetRectF(R, -1.0, -1.0);
      GdiPlusDrawText(DrawCanvas, WideText, R, ALabel.Font, Align, Color);
    end;
  end;
end;

procedure TInfoTextForm.ClearBuffer;
begin
  {
    Alpha (ilk byte) $00 olunca hersey siliniyor. Reallocate etmeye
    gerek kalmadi. Ogreniyoruz iste yavas yavas. (Ey DSL! v1.10)
  }
  DrawCanvas.Clear($00000000);
end;

procedure TInfoTextForm.HibernateActionExecute(Sender: TObject);
begin
  with HavaCivaMainForm do
  begin
    if HibernateAction.Checked then
    begin
      Self.PrevFormStyle := GetWindowLong(Self.Handle, GWL_EXSTYLE);
      if Self.PrevFormStyle and WS_EX_TRANSPARENT = 0 then
      begin
        Self.Hibernate;
        SetWindowLong(Self.Handle, GWL_EXSTYLE, Self.PrevFormStyle or WS_EX_TRANSPARENT);
      end;
    end
    else if Self.PrevFormStyle <> 0 then begin
      Self.Wakeup;
      SetWindowLong(Self.Handle, GWL_EXSTYLE, Self.PrevFormStyle);
    end;
  end;
end;

procedure TInfoTextForm.Hibernate;
begin
  if EnableFadeEffect then
    FadeOutEffect(OpacityStep, OpacityWait, OpacityMax)
  else begin
    Opacity := OpacityMax;
    UpdateMainWindow;
  end;
end;

procedure TInfoTextForm.Wakeup;
begin
  if EnableFadeEffect then
    FadeInEffect(OpacityStep, OpacityWait, OpacityMax)
  else begin
    Opacity := OpacityMax;
    UpdateMainWindow;
  end;
end;

end.
