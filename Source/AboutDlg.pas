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
{       Update  : 25.05.2013                            }
{       Update  : 24.01.2014                            }
{       Update  : 25.11.2015                            }
{       Update  : 14.05.2016                            }
{                                                       }
{*******************************************************}

unit AboutDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GdipApi, GdipObj, DirectDraw, TextUtil;

type
  TAboutForm = class(TForm)
    BackgrndLbl: TLabel;
    CloseBtn: TButton;
    HeaderTextLbl: TLabel;
    LogoImageLbl: TLabel;
    ProductNameLbl: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CloseBtnClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }
    Opacity: Byte;
    MainBuffer: TGPBitmap;
    DrawCanvas: TGPGraphics;

    CloseImage,
    TopImage,
    MidImage,
    BaseImage,
    OvTopImage,
    OvMidImage,
    OvBaseImage,
    ReflectionImage,
    LogoImage: TGPBitmap;

    BackScale: Single;
    procedure AllocateHandle;
    procedure ReleaseHandle;
  public
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
    procedure PaintHeaderText;
    procedure PaintLogoImage;
    procedure PaintProductName;
    procedure PaintLabel(ALabel: TLabel; const WideText: WideString;
      Align: StringAlignment; Color: Cardinal);
    procedure DrawImageTo(Graphics: TGPGraphics; X, Y, W, H: Single;
      Image: TGPBitmap; Alpha: Byte = $FF);
  end;

var
  AboutForm: TAboutForm;

implementation

uses Main, ConstDef, ShelApix;

{$R *.dfm}

{ TAboutForm }

procedure TAboutForm.AllocateHandle;
begin
  MainBuffer := TGPBitmap.Create(Width, Height, PixelFormat32bppARGB);
  DrawCanvas := TGPGraphics.Create(MainBuffer);
end;

procedure TAboutForm.FadeInEffect(const Step, Wait, Max: Integer);
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

procedure TAboutForm.FadeOutEffect(const Step, Wait, Min: Integer);
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

procedure TAboutForm.HideForm;
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

procedure TAboutForm.PaintBackground;
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
    //DrawCanvas.DrawImage(Image, X, Y, Image.GetWidth, Image.GetHeight);
    DrawCanvas.DrawImage(Image, X, Y, BackGrndLbl.Width, Image.GetHeight);
    {
    DrawCanvas.DrawImage(ReflectionImage, X + 7, Y + 3,
      ReflectionImage.GetWidth, ReflectionImage.GetHeight);
    }

    DrawCanvas.DrawImage(ReflectionImage, X + 10, Y + 3,
      BackGrndLbl.Width - 21, ReflectionImage.GetHeight);

    Y := Y + Image.GetHeight;
    Image := OvMidImage;

    Attr := TGPImageAttributes.Create;
    try
      //Attr.SetWrapMode(WrapModeTile);
      ScaledHeight := Round(Image.GetHeight * Scale);
      DrawCanvas.SetInterpolationMode(InterpolationModeDefault);
      DrawCanvas.DrawImage(Image,
        MakeRect(X, Y, BackGrndLbl.Width, ScaledHeight),
        0, 0, Image.GetWidth, 0.978 * Image.GetHeight, // Neden 0.978?
        UnitPixel,                                // Mecburen. Yoksa scale edince altta cizgi cikiyor.
        Attr);                                    // Neden cizgi cikiyor?
                                                  // Tabiki cizgi cikar. PixelOffsetMode hic ayarlanmamis ki! (25.11.2015)

      Y := Y + ScaledHeight;
      Image := OvBaseImage;
      //DrawCanvas.DrawImage(Image, X, Y, Image.GetWidth, Image.GetHeight);
      DrawCanvas.DrawImage(Image, X, Y, BackGrndLbl.Width, Image.GetHeight);

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
        MakeRect(X, Y, BackGrndLbl.Width, Image.GetHeight),  // dest rect
        0, 0, Image.GetWidth, Image.GetHeight,       // source rect
        UnitPixel,
        Attr);

      Y := Y + Image.GetHeight;
      Image := MidImage;
      ScaledHeight := Round(Image.GetHeight * Scale);

      DrawCanvas.DrawImage(Image,
        MakeRect(X, Y, BackGrndLbl.Width, ScaledHeight),//Image.GetWidth, ScaledHeight),  // dest rect
        0, 0, Image.GetWidth, Image.GetHeight,       // source rect
        UnitPixel,
        Attr);

      Y := Y + ScaledHeight;
      Image := BaseImage;

      DrawCanvas.DrawImage(Image,
        MakeRect(X, Y, BackGrndLbl.Width, Image.GetHeight),  // dest rect
        0, 0, Image.GetWidth, Image.GetHeight,       // source rect
        UnitPixel,
        Attr);

      PaintColorizedOverlay;

    finally
      Attr.Free;
    end;

  end;

begin

  AColor := RGB(128, 0, 128);
  AOpacity := 255;
  Scale := BackScale;
  PaintColorized(AColor, AOpacity);

end;

procedure TAboutForm.PaintButtons;
begin
  if CloseBtn.Enabled then begin
    if CloseBtn.Visible then
      DrawCanvas.DrawImage(CloseImage, CloseBtn.Left, CloseBtn.Top,
        CloseImage.GetWidth, CloseImage.GetHeight);
  end;
end;

procedure TAboutForm.PaintHeaderText;
var
  oRect, R: TGPRectF;
  WideText: WideString;
begin
  if HeaderTextLbl.Visible then
  begin

    WideText := 'Hava Cýva! Hakkýnda...';

    if WideText <> '' then
    begin
      GdiPlusMeasureString(DrawCanvas, WideText, oRect, HeaderTextLbl.Font,
        StringAlignmentCenter, HavaCivaMainForm.Antialias);

      HeaderTextLbl.ClientWidth := Round(oRect.Width) + 1;
      HeaderTextLbl.ClientHeight := Round(oRect.Height) + 1;

      R := MakeRectF(HeaderTextLbl.BoundsRect);

      OffsetRectF(R, -1.0, -1.0);
      GdiPlusDrawText(DrawCanvas, WideText, R, HeaderTextLbl.Font,
        StringAlignmentCenter, aclWhite, HavaCivaMainForm.Antialias);

    end;
  end;
end;

procedure TAboutForm.ReleaseHandle;
begin
  if Assigned(MainBuffer) then FreeAndNil(MainBuffer);
  if Assigned(DrawCanvas) then FreeAndNil(DrawCanvas);
end;

procedure TAboutForm.ShowForm;
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

procedure TAboutForm.UpdateBackground;
begin
  try
    ReleaseHandle;
    AllocateHandle;
    PaintBackground;
    UpdateMainWindow;
  finally

  end;
end;

procedure TAboutForm.UpdateLayered;
begin
  try

    ReleaseHandle;
    AllocateHandle;

    PaintBackground;
    PaintButtons;
    PaintHeaderText;
    PaintLogoImage;
    PaintProductName;
    
    UpdateMainWindow;

  finally

  end;
end;

procedure TAboutForm.UpdateMainWindow;
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

procedure TAboutForm.FormCreate(Sender: TObject);
begin

  BackScale := 4.50;

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

  LogoImage := TGPBitmap.Create('.\Contents\Resources\Moons\4.png');

  if HavaCivaMainForm.EnableFadeEffect then Opacity := OpacityMin
  else Opacity := OpacityMax;

  UpdateLayered;

end;

procedure TAboutForm.FormDestroy(Sender: TObject);
begin
  LogoImage.Free;
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

procedure TAboutForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //Close;
  HideForm;
end;

procedure TAboutForm.DrawImageTo(Graphics: TGPGraphics; X, Y, W, H: Single;
  Image: TGPBitmap; Alpha: Byte);
const
  CMatrix: ColorMatrix = (
    (1.0, 0.0, 0.0, 0.0, 0.0),
    (0.0, 1.0, 0.0, 0.0, 0.0),
    (0.0, 0.0, 1.0, 0.0, 0.0),
    (0.0, 0.0, 0.0, 1.0, 0.0),
    (0.0, 0.0, 0.0, 0.0, 1.0)
  );
var
  Attr: TGPImageAttributes;
  Matrix: ColorMatrix;
begin

  Matrix := CMatrix;

  Matrix[3, 3] := (Alpha / 255);

  Attr := TGPImageAttributes.Create;
  try
    Attr.SetWrapMode(WrapModeTile);
    Attr.SetColorMatrix(Matrix, ColorMatrixFlagsDefault, ColorAdjustTypeBitmap);

    Graphics.DrawImage(Image,
      MakeRect(X, Y, W, H),  // dest rect
      0, 0, Image.GetWidth, Image.GetHeight, // source rect
      UnitPixel,
      Attr);

  finally
    Attr.Free;
  end;

end;

procedure TAboutForm.CloseBtnClick(Sender: TObject);
begin
  HideForm;
end;

procedure TAboutForm.PaintLogoImage;
begin
  if LogoImageLbl.Visible then
  begin
    DrawImageTo(DrawCanvas, LogoImageLbl.Left, LogoImageLbl.Top,
      LogoImage.GetWidth, LogoImage.GetHeight, LogoImage, 155);
  end;
end;

procedure TAboutForm.PaintProductName;
var
  WideText: WideString;
begin
  WideText := 'Hava Cýva!';
  PaintLabel(ProductNameLbl, WideText, StringAlignmentNear, aclWhite);
  WideText := 'Sürüm ' + sCurrVersion + #13#10'A.Nâsýr Þentürk 2006-2019';
  PaintLabel(Label1, WideText, StringAlignmentNear, aclWhite);
  WideText := '"Bundan sonra TV''de hava durumunu'#13#10'kaçýrmak serbest!" - Tuðçe';
  PaintLabel(Label4, WideText, StringAlignmentNear, aclWhite);
  WideText := 'http://www.shenturk.com';
  PaintLabel(Label2, WideText, StringAlignmentNear, $FFFFFF80);

  {
  WideText := 'Ýletiþim: freedelphi@hotmail.com';
  PaintLabel(Label4, WideText, StringAlignmentNear, aclWhite);
  }
  WideText := 'Hava Cýva! "Açýk Kaynak Kodu" projesi çerçevesinde eðitim'#13#10 +
    'amacýyla üretilmiþtir. Hava durumu bilgileri Foreca servisinden'#13#10 +
    'alýnmaktadýr. Bu programda kullanýlan resim dosyalarý'#13#10 +
    'Yahoo! Inc.''e aittir. Ekran dizayný Arlo Rose'' dan esinlenerek'#13#10 +
    'tasarlanmýþtýr.';
  PaintLabel(Label3, WideText, StringAlignmentNear, aclWhite);
end;

procedure TAboutForm.PaintLabel(ALabel: TLabel; const WideText: WideString;
  Align: StringAlignment; Color: Cardinal);
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
      GdiPlusDrawText(DrawCanvas, WideText, R, ALabel.Font, Align, Color, HavaCivaMainForm.Antialias);
    end;
  end;
end;

procedure TAboutForm.Label2Click(Sender: TObject);
begin
  ShellExecute(Self.Handle, 'open', MyHomePage + 'projects.html#havaciva',
    nil, nil, SW_SHOWNORMAL);
end;

end.
