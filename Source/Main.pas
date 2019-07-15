{*******************************************************}
{                                                       }
{       Main.pas                                        }
{                                                       }
{                                                       }
{       Author  : A. Nasir Senturk                      }
{       Website : http://www.shenturk.com               }
{       E-Mail  : shenturk@gmail.com                    }
{       Create  : 07.12.2006                            }
{       Update  : 21.03.2008                            }
{       Update  : 25.05.2013                            }
{       Update  : 24.01.2014                            }
{       Update  : 22.12.2014                            }
{       Update  : 25.11.2015                            }
{       Update  : 14.05.2016                            }
{       Update  : 25.03.2019                            }
{                                                       }
{*******************************************************}

unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GdipApi, GdipObj, DirectDraw, StdCtrls, ExtCtrls, Internet, TextUtil,
  ConstDef, VarDates, TrayUtil, Menus, IniFiles, WinInet, XPMan, SyncObjs,
  InfoWind, ActnList, DateUtils, AboutDlg, msxml;

const
  WM_WEATHERDONE   = WM_USER + 10;
  WM_CHECKVERDONE  = WM_USER + 11;
  WM_TRACKERDONE   = WM_USER + 12;

const
  { v1.50 }
  { Jadelax Massage Ranges }
  CM_JADELAXBASE   = WM_USER + 1331;
  CM_RESTOREAPP    = CM_JADELAXBASE + 1;
  CM_EXITAPP       = CM_JADELAXBASE + 2;
  CM_RESTARTAPP    = CM_JADELAXBASE + 3;
  CM_BASE          = CM_JADELAXBASE + 100;

type
  THavaCivaMainForm = class(TForm)
    ExitBtn: TButton;
    HideBtn: TButton;
    WeatherLbl: TLabel;
    BackgrndLbl: TLabel;
    TemperatureLbl: TLabel;
    CityNameLbl: TLabel;
    InfoTextLbl: TLabel;
    GridLbl: TLabel;
    Day1Lbl: TLabel;
    Day2Lbl: TLabel;
    Day3Lbl: TLabel;
    Day4Lbl: TLabel;
    Day5Lbl: TLabel;
    MoonLbl: TLabel;
    TrayPopup: TPopupMenu;
    TrayExitMenu: TMenuItem;
    TrayHideMenu: TMenuItem;
    TrayShowMenu: TMenuItem;
    OptionsBtn: TButton;
    CheckTimer: TTimer;
    XPManifest1: TXPManifest;
    VersionTimer: TTimer;
    LoadedTimer: TTimer;
    ShortPopup: TPopupMenu;
    FavoritesMenu: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    AboutMenu: TMenuItem;
    ShowInfoMenu: TMenuItem;
    N3: TMenuItem;
    ExitMainMenu: TMenuItem;
    RefreshMenu: TMenuItem;
    OptionsMenu: TMenuItem;
    MainActionList: TActionList;
    ExitAction: TAction;
    ShowInfoAction: TAction;
    OptionsAction: TAction;
    HideAction: TAction;
    ShowAction: TAction;
    RefreshAction: TAction;
    AboutAction: TAction;
    N4: TMenuItem;
    TrayOptionsMenu: TMenuItem;
    N5: TMenuItem;
    TrayShowInfoMenu: TMenuItem;
    N6: TMenuItem;
    TrayAboutMenu: TMenuItem;
    TrayRefreshMenu: TMenuItem;
    N7: TMenuItem;
    AddLocAction: TAction;
    AddLocMenu: TMenuItem;
    TrayAddLocMenu: TMenuItem;
    TrayFavoritesMenu: TMenuItem;
    MiniAction: TAction;
    MidiAction: TAction;
    MaxiAction: TAction;
    N8: TMenuItem;
    MiniAction1: TMenuItem;
    MidiAction1: TMenuItem;
    MaxiAction1: TMenuItem;
    HibernateAction: TAction;
    N9: TMenuItem;
    HibernateAction1: TMenuItem;
    MouseTimer: TTimer;
    N10: TMenuItem;
    Kk1: TMenuItem;
    Orta1: TMenuItem;
    Byk1: TMenuItem;
    N11: TMenuItem;
    KUykusu1: TMenuItem;
    KeskinYaziBicimi1: TMenuItem;
    AntialiasAction: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckTimerTimer(Sender: TObject);
    procedure VersionTimerTimer(Sender: TObject);
    procedure LoadedTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ShortPopupPopup(Sender: TObject);
    procedure ExitActionExecute(Sender: TObject);
    procedure ShowInfoActionExecute(Sender: TObject);
    procedure OptionsActionExecute(Sender: TObject);
    procedure HideActionExecute(Sender: TObject);
    procedure ShowActionExecute(Sender: TObject);
    procedure RefreshActionExecute(Sender: TObject);
    procedure AboutActionExecute(Sender: TObject);
    procedure TrayPopupPopup(Sender: TObject);
    procedure AddLocActionExecute(Sender: TObject);
    procedure MiniActionExecute(Sender: TObject);
    procedure MidiActionExecute(Sender: TObject);
    procedure MaxiActionExecute(Sender: TObject);
    procedure HibernateActionExecute(Sender: TObject);
    procedure MouseTimerTimer(Sender: TObject);
    procedure AntialiasActionExecute(Sender: TObject);
  private
    { Private declarations }
    Updating: Boolean;
    Moving: Boolean;
    Opacity: Byte;
    MainBuffer: TGPBitmap;
    DrawCanvas: TGPGraphics;
    OptionsImage,
    CloseImage,
    HideImage,
    TopImage,
    MidImage,
    BaseImage,
    OvTopImage,
    OvMidImage,
    OvBaseImage,
    ReflectionImage: TGPBitmap;
    EarthImage,
    SunImage,
    NoneImage: TGPBitmap;
    GridImage: TGPBitmap;
    DayState: TDayState;
    LocCityStr: string;
    LocCountryStr: string;
    CityID: string;
    SunriseStr: string;
    SunsetStr: string;
    LatitudeStr: string;
    LongitudeStr: string;
    LocalTimeStr: string;
    TimeZoneStr: string;
    WindChillStr: string;
    WindDirectionStr: string;
    WindSpeedStr: string;
    HumidityStr: string;
    VisibilityStr: string;
    PressureStr: string;
    CondTextStr: string;
    CondCodeStr: string;
    CondTempStr: string;
    ForecastDays : array[0..MaxForecast - 1] of string;
    ForecastLows : array[0..MaxForecast - 1] of string;
    ForecastHighs: array[0..MaxForecast - 1] of string;
    ForecastCodes: array[0..MaxForecast - 1] of string;
    ForecastDates: array[0..MaxForecast - 1] of string;
    ForecastTexts: array[0..MaxForecast - 1] of string;
    DateStr: WideString;
    HijriDateStr: WideString;
    UnitValue: string;
    TrayIcon: TTrayIcon;
    AutoUpdate: Boolean;
    UpdatePeriod: Cardinal;
    ShowTrayIcon: Boolean;
    IsStarted: Boolean;
    BackScale: Single;
    Favorites: TStringList;
    CheckVerThread: TInternetThread;
    CheckVerXML: WideString;
    VersionStr: string;
    WeatherXML: WideString;
    WeatherThread: TInternetThread;
    SearchThread: TInternetThread;
    SearchCityStr: string;
    TrackerThread: TInternetThread;
    Distance: TPoint;
    AboutForm: TAboutForm;
    { v 1.50 }
    MainViewStyle: TMainViewStyle;
    function GetBackScale: Double;
    procedure AllocateHandle;
    procedure ReleaseHandle;
  protected
    procedure CMRestoreApp(var Message: TMessage); message CM_RESTOREAPP;
    procedure WMWeatherDone(var Message: TMessage); message WM_WEATHERDONE;
    procedure WMCheckVerDone(var Message: TMessage); message WM_CHECKVERDONE;
    procedure WMTrackerDone(var Message: TMessage); message WM_TRACKERDONE;
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    { v1.50 }
    procedure CMExitApp(var Message: TMessage); message CM_EXITAPP;
    procedure WMQueryEndSession(var Message: TWMQueryEndSession); message WM_QUERYENDSESSION;
    procedure WMEndSession(var Message: TWMEndSession); message WM_ENDSESSION;
  public
    IsActive: Boolean;
    BackgroundStyle: TBackgroundStyle;
    ConnectionStatus: TConnectionStatus;
    BackColor: Cardinal;
    GlassEffect: Boolean;
    GlassOpacity: Byte;
    ShowPressure,
    ShowDate,
    ShowHijri,
    ShowSituation,
    ShowSunInfo,
    ShowWind,
    ShowHumidity,
    ShowVisibility,
    ShowChill,
    ShowWeatherText,
    EnableFadeEffect,
    ShowInfoText,
    StayOnTop,
    FirstUsage,
    Antialias: Boolean;
    InfoTextForm: TInfoTextForm; { v1.50 }
    InfoText: WideString;
    InfoTextHeight: Integer;
    { v1.50 }
    HibernateAlert: Boolean;
    AlertShow: Boolean;
    PrevFormStyle: Cardinal;
    HibernateCheck: Boolean;
    { Public declarations }
    procedure UpdateLayered;
    procedure UpdateMainWindow;
    procedure UpdateBackground;
    procedure DoActivate(Sender: TObject);
    procedure DoDeactivate(Sender: TObject);
    procedure InternetUpdate;
    procedure BeginCityWeather;
    procedure ParseWeatherXML;
    procedure ParseCheckVerXML;
    procedure PaintBackground;
    procedure PaintButtons;
    procedure PaintSunOrMoon;
    procedure PaintEarth;
    procedure PaintSun;
    procedure PaintMoon(Phase: Integer);
    procedure PaintNone;
    procedure PaintWeatherBig;
    procedure PaintCityName;
    procedure PaintTemperature;
    procedure PaintGridImage;
    procedure PaintForecasts;
    procedure PaintForecastsDay(Index: Integer);
    procedure PaintTinyMoon;
    procedure LoadOptions;
    procedure SaveOptions;
    procedure DisableEvents;
    procedure EnableEvents;
    function GetMoonPhase: Integer;
    function GetMoonPhasePercent(const TheDate: TDateTime): Integer;
    function GetConnectionText: WideString;
    function GetInfoText: WideString;
    function GetHijriText: WideString;
    function GetWindText: WideString;
    function GetWindDirectionText: WideString;
    function GetWeatherText: WideString;
    function GetVisibilityText: WideString;
    function GetDateTime: WideString;
    function GetSunText: WideString;
    function GetPressureText: WideString;
    procedure CheckNewVersion;
    procedure FadeInEffect(const Step, Wait, Max: Integer);
    procedure FadeOutEffect(const Step, Wait, Min: Integer);
    procedure HideMainForm;
    procedure ShowMainForm;
    procedure DoShowHint(var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
    procedure PrepareInfoText;
    function GetInfoTextHeight: Integer;
    procedure ChooseFavorite(Sender: TObject);
    procedure RegisterTracker;
    function GetHintText: WideString;
    function GetTrayHintText: WideString;
    function GetSituationText: WideString;
    function GetTemperatureText: WideString;
    procedure ToggleInfoTextForm(Value: Boolean);
    procedure ResetData;
    procedure UpdateActionsState;
    procedure ShowOptionsDialog(const PageIndex: Integer);
    procedure UpdateFormStyle;
    { v1.50 }
    procedure UpdateMainViewStyle;
    procedure SetMiniViewStyle;
    procedure SetMidiViewStyle;
    procedure SetMaxiViewStyle;
    procedure AnimateViewStyleUp;
    procedure AnimateViewStyleDown;
    procedure UpdateMainViewMenuChecks;
    procedure ClearBuffer;
    procedure Hibernate;
    procedure Wakeup;
    procedure CheckHibernateAlert;
  end;

var
  HavaCivaMainForm: THavaCivaMainForm;
  TurkishFS, EnglishFS: TFormatSettings;

implementation

uses
  ActiveX, ComObj, OptnsDlg, ShelApix, HTTPApp, HbrntDlg;

{$R *.dfm}

procedure THavaCivaMainForm.AllocateHandle;
begin
  MainBuffer := TGPBitmap.Create(Width, Height, PixelFormat32bppARGB);
  DrawCanvas := TGPGraphics.Create(MainBuffer);
end;

procedure THavaCivaMainForm.FormCreate(Sender: TObject);
var
  I: Integer;
begin

  Randomize;

  Application.HintHidePause := 15000;

  AllocateHandle; { v1.50 }

  WideGetLocaleMonthDayNames(MakeLCID(
      MakeLangID(LANG_TURKISH, SUBLANG_DEFAULT),
    SORT_DEFAULT));

  GetLocaleFormatSettings(
    MakeLCID(
      MakeLangID(LANG_TURKISH, SUBLANG_DEFAULT),
    SORT_DEFAULT),
    TurkishFS);

  GetLocaleFormatSettings(
    MakeLCID(
      MakeLangID(LANG_ENGLISH, SUBLANG_ENGLISH_US),
    SORT_DEFAULT),
    EnglishFS);

  BackScale := 1.25;
  MainViewStyle := mvsMini;

  GridLbl.Visible := False;
  MoonLbl.Visible := False;

  Application.ShowHint := True;
  Application.OnShowHint := DoShowHint;

  TrayIcon := TTrayIcon.Create(Self);
  TrayIcon.Hint := 'Hava Cýva!';
  TrayIcon.Icon := Application.Icon;
  TrayIcon.PopupMenu := TrayPopup;
  TrayIcon.OnDblClick := ShowActionExecute;//RefreshActionExecute;
  TrayIcon.BalloonTitle := 'Hava Cýva!';
  TrayIcon.BalloonFlags := bfInfo;
  TrayIcon.BalloonHint := sBalloonHintMsg;

  VersionTimer.Enabled := IniFile.ReadBool(sGeneral, sCheckNewVersion, True);

  for I := 0 to MaxForecast - 1 do ForecastDays[I] := '';

  DayState := dsNone;

  Application.OnActivate := HavaCivaMainForm.DoActivate;
  Application.OnDeactivate := HavaCivaMainForm.DoDeactivate;

  if GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_LAYERED = 0 then
    SetWindowLong(Handle, GWL_EXSTYLE,
      GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

  CloseImage := TGPBitmap.Create('.\Contents\Resources\UI\Close.png');
  HideImage := TGPBitmap.Create('.\Contents\Resources\UI\Less.png');
  OptionsImage := TGPBitmap.Create('.\Contents\Resources\UI\Options.png');
  GridImage := TGPBitmap.Create('.\Contents\Resources\UI\Grid.png');

  TopImage := TGPBitmap.Create('.\Contents\Resources\Colorize\Top.png');
  MidImage := TGPBitmap.Create('.\Contents\Resources\Colorize\Mid.png');
  BaseImage := TGPBitmap.Create('.\Contents\Resources\Colorize\Base.png');

  OvTopImage := TGPBitmap.Create('.\Contents\Resources\Colorize\Top Overlay.png');
  OvMidImage := TGPBitmap.Create('.\Contents\Resources\Colorize\Mid Overlay.png');
  OvBaseImage := TGPBitmap.Create('.\Contents\Resources\Colorize\Base Overlay.png');
  ReflectionImage := TGPBitmap.Create('.\Contents\Resources\UI\Reflection.png');

  EarthImage := TGPBitmap.Create('.\Contents\Resources\Big\Earth.png');
  SunImage := TGPBitmap.Create('.\Contents\Resources\Big\Sun.png');
  NoneImage := TGPBitmap.Create('.\Contents\Resources\Big\None.png');

  LoadOptions;

  UpdateMainViewMenuChecks;

  UnitValue := 'C';

  if EnableFadeEffect then Opacity := OpacityMin
  else Opacity := OpacityMax;

  UpdateLayered;

  InternetUpdate;

  TrayIcon.Visible := ShowTrayIcon;

  CheckTimer.Enabled := AutoUpdate;
  CheckTimer.Interval := UpdatePeriod;

  LoadedTimer.Enabled := True;

  Favorites := TStringList.Create;

  InfoTextForm := TInfoTextForm.Create(Self);

  AboutForm := TAboutForm.Create(Self);

end;

procedure THavaCivaMainForm.ReleaseHandle;
begin
  if Assigned(MainBuffer) then FreeAndNil(MainBuffer);
  if Assigned(DrawCanvas) then FreeAndNil(DrawCanvas);
end;

procedure THavaCivaMainForm.UpdateLayered;
begin
  Updating := True;
  try
    ClearBuffer;
    UpdateActionsState;
    PrepareInfoText;
    PaintBackground;
    PaintGridImage;
    PaintForecasts;
    PaintTemperature;
    PaintCityName;
    PaintSunOrMoon;
    PaintWeatherBig;
    PaintButtons;
    UpdateMainWindow;
  finally
    Updating := False;
  end;
end;

procedure THavaCivaMainForm.FormDestroy(Sender: TObject);
begin
  AboutForm.Free;
  InfoTextForm.Free;
  Favorites.Free;
  NoneImage.Free;
  SunImage.Free;
  EarthImage.Free;
  ReflectionImage.Free;
  OvTopImage.Free;
  OvMidImage.Free;
  OvBaseImage.Free;
  TopImage.Free;
  MidImage.Free;
  BaseImage.Free;
  TrackerThread.Free;
  CheckVerThread.Free;
  SearchThread.Free;
  WeatherThread.Free;
  GridImage.Free;
  OptionsImage.Free;
  HideImage.Free;
  CloseImage.Free;
  ReleaseHandle;
  TrayIcon.Free;
  SaveOptions;
end;

procedure THavaCivaMainForm.UpdateMainWindow;
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

procedure THavaCivaMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
begin

  if Assigned(InfoTextForm) then
  begin
    Distance.X := InfoTextForm.Left - Self.Left;
    Distance.Y := InfoTextForm.Top - Self.Top;
  end;

  if not IsActive then
  begin
    IsActive := True;
    UpdateFormStyle;
    UpdateLayered;
  end;

  if Button = mbLeft then
  begin
    Moving := True;
    ReleaseCapture;
    SendMessage( Handle, WM_SYSCOMMAND, SC_DRAGMOVE, 0 );
    GetWindowRect(Handle, R);
    Left := R.Left;
    Top := R.Top;
    Moving := False;
    UpdateLayered;
  end;
  
end;

procedure THavaCivaMainForm.DoActivate(Sender: TObject);
begin

end;

procedure THavaCivaMainForm.DoDeactivate(Sender: TObject);
begin
  IsActive := False;
  UpdateLayered;
end;

procedure THavaCivaMainForm.InternetUpdate;
begin
  BeginCityWeather;
end;

procedure THavaCivaMainForm.PaintBackground;
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
      ScaledHeight := Round(Image.GetHeight * Scale);// + InfoTextHeight);
      DrawCanvas.SetInterpolationMode(InterpolationModeDefault);

      DrawCanvas.DrawImage(Image,
        MakeRect(X, Y, Image.GetWidth, ScaledHeight),
        0, 0, Image.GetWidth, 0.978 * Image.GetHeight, // Neden 0.978?
        UnitPixel,                                // Mecburen. Yoksa scale edince altta cizgi cikiyor.
        Attr);                                    // Neden cigi cikiyor?
                                                  // Bilmem. GDI+ scale edince alta soft bir golge veriyor.
                                                  // Tabiki cizgi cikar. PixelOffsetMode hic ayarlanmamis ki! (25.11.2015)
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

      Image := TopImage;

      DrawCanvas.DrawImage(Image,
        MakeRect(X, Y, Image.GetWidth, Image.GetHeight),  // dest rect
        0, 0, Image.GetWidth, Image.GetHeight,       // source rect
        UnitPixel,
        Attr);

      Y := Y + Image.GetHeight;
      Image := MidImage;
      ScaledHeight := Round(Image.GetHeight * Scale);// + InfoTextHeight);

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

procedure THavaCivaMainForm.PaintSunOrMoon;
var
  Sunrise, Sunset: TDateTime;
  MoonPhase: Integer;
  WeatherCodeInt: Integer;
  FetchedTime: TDateTime;
  Latitude, Longitude, TimeZone: Double;
begin

  if WeatherLbl.Visible then
  begin

    Sunrise := -1;
    Sunset := -1;
    Latitude := StrToFloatDef(LatitudeStr, -1, TurkishFS);
    Longitude := StrToFloatDef(LongitudeStr, -1, TurkishFS);
    TimeZone := StrToFloatDef(TimeZoneStr, -1, TurkishFS);
    GetSunriseSunset(Date, Latitude, Longitude, TimeZone, Sunrise, Sunset);

    if (Sunrise > -1) and (Sunset > -1) then
    begin
      SunriseStr := TimeToStr(Sunrise);
      SunsetStr := TimeToStr(Sunset);
      FetchedTime := StrToTimeDef(LocalTimeStr, -1, TurkishFS);
      if (FetchedTime >= Sunrise) and (FetchedTime < Sunset) then
        DayState := dsDayTime
      else
        DayState := dsNightTime;
    end
      else DayState := dsNone;

    MoonPhase := GetMoonPhase;
    if MoonPhase < 0 then MoonPhase := 0;

    WeatherCodeInt := StrToIntDef(CondCodeStr, -1);

    if WeatherCodeInt = 3200 then WeatherCodeInt := 32;

    if (WeatherCodeInt >= 0) and (WeatherCodeInt < MaxWeatherIcons) then
    begin
      if WeatherIcons[WeatherCodeInt].SoM then
      begin
        case DayState of
          dsDayTime   : PaintSun;
          dsNightTime : PaintMoon(MoonPhase);
        else PaintEarth;
        end;
      end
      else PaintNone;
    end
    else PaintEarth;

  end;

end;

procedure THavaCivaMainForm.PaintWeatherBig;
var
  Image: TGPBitmap;
  ImageName: string;
  WeatherCodeInt: Integer;
begin

  if WeatherLbl.Visible then
  begin
    WeatherCodeInt := StrToIntDef(CondCodeStr, -1);
    if (WeatherCodeInt >= 0) and (WeatherCodeInt < MaxWeatherIcons) then
      ImageName := '.\Contents\Resources\Big\' + WeatherIcons[WeatherCodeInt].Weather + '.png'
    else ImageName := '.\Contents\Resources\Big\None.png';

    Image := TGPBitmap.Create(ImageName);
    try
      DrawCanvas.DrawImage(Image, WeatherLbl.Left, WeatherLbl.Top,
        Image.GetWidth, Image.GetHeight);
    finally
      Image.Free;
    end;
    
  end;
end;

procedure THavaCivaMainForm.PaintCityName;
var
  oRect, R: TGPRectF;
  WideText: WideString;
begin
  if CityNameLbl.Visible then
  begin

    WideText := GetConnectionText;

    CityNameLbl.Caption := WideText;

    GdiPlusMeasureString(DrawCanvas, WideText, oRect, CityNameLbl.Font,
      StringAlignmentFar, Antialias);

    CityNameLbl.ClientWidth := Round(oRect.Width) + 1;
    CityNameLbl.ClientHeight := Round(oRect.Height) + 1;
    CityNameLbl.Left := BackgrndLbl.Left + BackgrndLbl.ClientWidth -
      CityNameLbl.ClientWidth - 16;

    R := MakeRectF(CityNameLbl.BoundsRect);
    GdiPlusDrawText(DrawCanvas, WideText, R, CityNameLbl.Font,
      StringAlignmentFar, aclWhite, Antialias);

  end;
end;

procedure THavaCivaMainForm.PaintTemperature;
var
  oRect, R: TGPRectF;
  WideText: WideString;
begin
  if TemperatureLbl.Visible then
  begin

    WideText := GetTemperatureText;

    if WideText <> '' then
    begin

      TemperatureLbl.Caption := WideText;

      GdiPlusMeasureString(DrawCanvas, WideText, oRect,
        TemperatureLbl.Font, StringAlignmentFar, Antialias);

      TemperatureLbl.ClientWidth := Round(oRect.Width) + 1;
      TemperatureLbl.ClientHeight := Round(oRect.Height) + 1;
      TemperatureLbl.Left := BackgrndLbl.Left + BackgrndLbl.ClientWidth -
        TemperatureLbl.ClientWidth - 4;

      R := MakeRectF(TemperatureLbl.BoundsRect);
      GdiPlusDrawText(DrawCanvas, WideText, R, TemperatureLbl.Font,
        StringAlignmentFar, aclWhite, Antialias);

    end;
  end;
end;

procedure THavaCivaMainForm.PaintGridImage;
var
  H: Cardinal;
begin
  { Updated v1.50 }
  if GridLbl.Visible then
  begin
    case MainViewStyle of
      mvsMini: H := GridImage.GetHeight;
      mvsMidi: H := GridImage.GetHeight div 2;
    else H := 0;
    end;
    DrawCanvas.DrawImage(GridImage,
      MakeRect(GridLbl.Left, GridLbl.Top, GridImage.GetWidth, GridImage.GetHeight), // dest rect
      0, H, GridImage.GetWidth, GridImage.GetHeight, // source rect
      UnitPixel);
  end;
end;

procedure THavaCivaMainForm.PaintForecasts;
begin
  PaintForecastsDay(0);
  PaintForecastsDay(1);
  PaintForecastsDay(2);
  PaintForecastsDay(3);
  PaintForecastsDay(4);
  PaintTinyMoon;
end;

procedure THavaCivaMainForm.PaintForecastsDay(Index: Integer);
var
  ForecastLabel: TLabel;
  oRect, R: TGPRectF;
  Image: TGPBitmap;
  WideText: WideString;
  TempFont: TFont;
begin

  ForecastLabel := nil;

  case Index of
    0: ForecastLabel := Day1Lbl;
    1: ForecastLabel := Day2Lbl;
    2: ForecastLabel := Day3Lbl;
    3: ForecastLabel := Day4Lbl;
    4: ForecastLabel := Day5Lbl;
  end;

  if (ForecastLabel <> nil) and (ForecastLabel.Visible) then
  begin

    if ForecastDays[Index] <> '' then
    begin
      WideText := UpperCase(ForecastDays[Index]);
      GdiPlusMeasureString(DrawCanvas, WideText, oRect, ForecastLabel.Font,
        StringAlignmentCenter, Antialias);

      R := MakeRectF(ForecastLabel.BoundsRect);
      R.Y := R.Y - 14;
      GdiPlusDrawText(DrawCanvas, WideText, R, ForecastLabel.Font,
        StringAlignmentCenter, aclWhite, Antialias);
    end;

    TempFont := TFont.Create;
    try

      TempFont.Name := CityNameLbl.Font.Name;
      TempFont.Size := 10;
      TempFont.Style := [fsBold];

      if ForecastHighs[Index] <> '' then
      begin

        if ForecastHighs[Index] = 'N/A' then WideText := '--'
        else WideText := ForecastHighs[Index] + #0176;

        GdiPlusMeasureString(DrawCanvas, WideText, oRect, TempFont,
          StringAlignmentCenter, Antialias);

        R := MakeRectF(ForecastLabel.BoundsRect);
        OffsetRectF(R, -14.0, 26.0);
        GdiPlusDrawText(DrawCanvas, WideText, R, TempFont,
          StringAlignmentCenter, aclWhite, Antialias);

      end;

      if ForecastLows[Index] <> '' then
      begin

        TempFont.Size := 9;

        WideText := ForecastLows[Index] + #0176;

        GdiPlusMeasureString(DrawCanvas, WideText, oRect, TempFont,
          StringAlignmentCenter, Antialias);

        R := MakeRectF(ForecastLabel.BoundsRect);
        OffsetRectF(R, 14.0, 26.0);
        GdiPlusDrawText(DrawCanvas, WideText, R, TempFont,
          StringAlignmentCenter, MakeColor(200, 255, 255, 255), Antialias);
      end;

    finally
      TempFont.Free;
    end;

    if ForecastCodes[Index] <> '' then
    begin

      if not ForecastLabel.ShowHint then ForecastLabel.ShowHint := True;
      //ForecastLabel.Hint := WeatherIcons[StrToIntDef(ForecastCodes[Index], 49)].Turkish;
      ForecastLabel.Hint := ForecastTexts[Index];

      Image := TGPBitmap.Create('.\Contents\Resources\Tiny\' +
        TinyWeatherIcons[StrToIntDef(ForecastCodes[Index], 0)] + '.png');
      try
        DrawCanvas.DrawImage(Image, ForecastLabel.Left, ForecastLabel.Top,
          Image.GetWidth, Image.GetHeight);
      finally
        Image.Free;
      end;
    end;

  end;

end;

procedure THavaCivaMainForm.PaintTinyMoon;
var
  oRect, R: TGPRectF;
  Image: TGPBitmap;
  WideText: WideString;
  MoonPhase: Integer;
  TempFont: TFont;
begin

  if MoonLbl.Visible then
  begin

    if SunriseStr <> '' then
    begin

      WideText := 'AY';

      MoonPhase := GetMoonPhase();
      if MoonPhase < 0 then MoonPhase := 0;

      MoonLbl.Hint := PhaseNamesTurkish[MoonPhase];

      Image := TGPBitmap.Create('.\Contents\Resources\Tiny\Moons\' +
        IntToStr(MoonPhase) + '.png');
      try
        DrawCanvas.DrawImage(Image, MoonLbl.Left, MoonLbl.Top,
          Image.GetWidth, Image.GetHeight);
      finally
        Image.Free;
      end;

      GdiPlusMeasureString(DrawCanvas, WideText, oRect, MoonLbl.Font,
        StringAlignmentCenter, Antialias);

      R := MakeRectF(MoonLbl.BoundsRect);
      R.Y := R.Y - 14;
      GdiPlusDrawText(DrawCanvas, WideText, R, MoonLbl.Font,
        StringAlignmentCenter, aclWhite, Antialias);

      TempFont := TFont.Create;
      try

        TempFont.Name := CityNameLbl.Font.Name;
        TempFont.Size := 10;
        TempFont.Style := [fsBold];

        MoonPhase := GetMoonPhasePercent(SysUtils.Now);
        
        WideText := '%' + IntToStr(MoonPhase);

        GdiPlusMeasureString(DrawCanvas, WideText, oRect, TempFont,
          StringAlignmentCenter, Antialias);

        R := MakeRectF(MoonLbl.BoundsRect);
        OffsetRectF(R, 0.0, 26.0);
        GdiPlusDrawText(DrawCanvas, WideText, R, TempFont,
          StringAlignmentCenter, aclWhite, Antialias);

      finally
        TempFont.Free;
      end;

    end;

  end;

end;

function THavaCivaMainForm.GetMoonPhase: Integer;
begin
  Result := Round(GetMoonPhasePercent(SysUtils.Date) * 0.279);
end;

procedure THavaCivaMainForm.WMWeatherDone(var Message: TMessage);
begin
  WeatherXML := WeatherThread.Response.Content;
  { WeatherThread.Response.ContentStream.SaveToFile('forecast.xml'); }
  if Assigned(WeatherThread) then FreeAndNil(WeatherThread);
  if Message.LParam = 0 then
  begin
    if (not IsStarted) and (EnableFadeEffect) then
    begin
      while BackScale < GetBackScale do
      begin
        BackScale := BackScale + 0.25;
        UpdateBackground;
        Sleep(0);
      end;
    end else BackScale := GetBackScale;
    UpdateMainViewStyle;
    IsStarted := True;
    ConnectionStatus := csConnected;
    ResetData;
    ParseWeatherXML;
    DateStr := GetDateTime;
    HijriDateStr := GetHijriText;
  end
  else
    ConnectionStatus := csNotConnected;
  UpdateLayered;
  InfoTextForm.UpdateLayered;
  if ShowInfoText and Self.Visible then
    InfoTextForm.ShowForm;
  TrayIcon.Hint := GetTrayHintText;

  RegisterTracker;
  
end;

procedure THavaCivaMainForm.LoadOptions;
begin
  { v2.50 }
  AppGuidStr := IniFile.ReadString(sGeneral, sAppGuid, '');
  if AppGuidStr = '' then
  begin
    if CreateGUID(AppGuid) <> 0 then { Error? }
      AppGuid := DefaultGuid;
    AppGuidStr := GUIDToString(AppGuid);
    if Pos('{', AppGuidStr) = 1 then
      Delete(AppGuidStr, 1, 1);
    if Pos('}', AppGuidStr) = Length(AppGuidStr) then
      Delete(AppGuidStr, Length(AppGuidStr), 1);
  end;
  Left := IniFile.ReadInteger(sAppearance, sLeft, 300);
  Top := IniFile.ReadInteger(sAppearance, sTop, 300);
  LocCityStr := IniFile.ReadString(sLocation, sCityName, 'Istanbul');
  SearchCityStr := IniFile.ReadString(sLocation, sCityFullName, 'Istanbul, Turkey');
  CityID := IniFile.ReadString(sLocation, sCityID, 'TUXX0014');
  BackgroundStyle := TBackgroundStyle(IniFile.ReadInteger(sAppearance, sBackground,
    Ord(bsDarkGlass)));
  AutoUpdate := IniFile.ReadBool(sGeneral, sAutoUpdate, True);
  EnableFadeEffect := IniFile.ReadBool(sGeneral, sFadeEffect, True);
  case IniFile.ReadInteger(sGeneral, sUpdatePeriod, 2) of
    1: UpdatePeriod := 10 * MinuteMs;
    2: UpdatePeriod := 15 * MinuteMs;
    3: UpdatePeriod := 30 * MinuteMs;
    4: UpdatePeriod := HourMs;
    5: UpdatePeriod := 2 * HourMs;
  else
    UpdatePeriod := 5 * MinuteMs;
  end;
  CheckTimer.Interval := UpdatePeriod;
  ShowTrayIcon := IniFile.ReadBool(sGeneral, sShowTrayIcon, True);

  TrayIcon.Visible := ShowTrayIcon;
  HideBtn.Visible := TrayIcon.Visible;

  GlassEffect := IniFile.ReadBool(sAppearance, sGlassEffect, False);
  GlassOpacity := IniFile.ReadInteger(sAppearance, sGlassOpacity, 150);
  BackColor := IniFile.ReadInteger(sAppearance, sBackColor, $808080);

  ShowPressure := IniFile.ReadBool(sAppearance, sShowPressure, True);
  ShowSunInfo := IniFile.ReadBool(sAppearance, sShowSunInfo, False);
  ShowSituation := IniFile.ReadBool(sAppearance, sShowSituation, False);
  ShowDate := IniFile.ReadBool(sAppearance, sShowDate, False);

  ShowHijri := IniFile.ReadBool(sAppearance, sShowHijri, False);
  ShowWind := IniFile.ReadBool(sAppearance, sShowWind, False);
  ShowVisibility := IniFile.ReadBool(sAppearance, sShowVisibility, False);
  ShowHumidity := IniFile.ReadBool(sAppearance, sShowHumidity, False);
  ShowChill := IniFile.ReadBool(sAppearance, sShowChill, False);
  ShowWeatherText := IniFile.ReadBool(sAppearance, sShowWeatherText, True);
  ShowInfoText := IniFile.ReadBool(sAppearance, sShowInfoText, True);

  FirstUsage := IniFile.ReadBool(sGeneral, sFirstUsage, True);
  Antialias := IniFile.ReadBool(sAppearance, sAntialias, True);

  TemperatureLbl.Font.Name := IniFile.ReadString(sAppearance, sTempFontName, 'Arial');
  CityNameLbl.Font.Name := IniFile.ReadString(sAppearance, sCityFontName, 'Arial');

  ShowInfoAction.Checked := ShowInfoText;

  AntialiasAction.Checked := not Antialias;

  StayOnTop := IniFile.ReadBool(sGeneral, sAlwaysTop, False);

  // Note:	It is not advisable to change FormStyle at runtime.
  
  if StayOnTop then
    SetWindowPos(Self.Handle, HWND_TOP or HWND_TOPMOST, 0, 0, 0, 0,
      SWP_NOMOVE or SWP_NOSIZE or SWP_FRAMECHANGED)
  else
    SetWindowPos(Self.Handle, HWND_NOTOPMOST, 0, 0, 0, 0,
      SWP_NOMOVE or SWP_NOSIZE or SWP_FRAMECHANGED);
  if Assigned(InfoTextForm) then
    InfoTextForm.UpdateFormStyle;

  { v1.50 }
  MainViewStyle := TMainViewStyle(IniFile.ReadInteger(sAppearance,
    sMainViewStyle, Ord(mvsMaxi)));
  HibernateCheck := IniFile.ReadBool(sAppearance, sHibernate, False);
end;

procedure THavaCivaMainForm.SaveOptions;
begin
  IniFile.WriteInteger(sAppearance, sMainViewStyle, Integer(MainViewStyle));
  IniFile.WriteInteger(sAppearance, sLeft, Left);
  IniFile.WriteInteger(sAppearance, sTop, Top);
  IniFile.WriteString(sLocation, sCityName, LocCityStr);
  IniFile.WriteString(sLocation, sCityFullName, SearchCityStr);
  IniFile.WriteString(sLocation, sCityID, CityID);
  IniFile.WriteInteger(sAppearance, sInfoTextLeft, InfoTextForm.Left);
  IniFile.WriteInteger(sAppearance, sInfoTextTop, InfoTextForm.Top);
  IniFile.WriteBool(sAppearance, sShowInfoText, ShowInfoText);
  IniFile.WriteBool(sAppearance, sHibernate, HibernateAction.Checked);
  if FirstUsage then IniFile.WriteBool(sGeneral, sFirstUsage, False);
  IniFile.WriteBool(sAppearance, sAntialias, not AntialiasAction.Checked);
  { v2.50 }
  IniFile.WriteString(sGeneral, sAppGuid, AppGuidStr);
  IniFile.UpdateFile;
end;

function THavaCivaMainForm.GetConnectionText: WideString;
begin
  case ConnectionStatus of
    csConnecting   : Result := sConnecting;
    csSearching    : Result := sSearching;
    csNotConnected : Result := sNotConnected;
    csException    : Result := sException;
  else
    Result := LocCityStr;
  end;
end;

procedure THavaCivaMainForm.CheckTimerTimer(Sender: TObject);
begin
  if ConnectionStatus <> csConnecting then
    InternetUpdate;
end;

procedure THavaCivaMainForm.DisableEvents;
begin
  CheckTimer.Enabled := False;
end;

procedure THavaCivaMainForm.EnableEvents;
begin
  CheckTimer.Enabled := AutoUpdate;
end;

function THavaCivaMainForm.GetInfoText: WideString;

  procedure AddWideText(const Item, FormatStr: WideString);
  begin
    if Item <> '' then
      Result := Result + WideFormat(FormatStr, [Item]);
  end;

begin
  Result := '';
  if ShowWeatherText then
    AddWideText(GetWeatherText, '%s'#13#10);
  if ShowChill then
    AddWideText(WindChillStr, 'Hissedilen sýcaklýk: %s'#0176#13#10);
  if ShowWind then
    AddWideText(GetWindText, '%s'#13#10);
  if ShowHumidity then
    AddWideText(HumidityStr, 'Nem oraný: %%%s'#13#10);
  if ShowSunInfo then
    AddWideText(GetSunText, '%s'#13#10);
  if ShowSituation then
    AddWideText(GetSituationText, '%s'#13#10);
  if ShowVisibility then
    AddWideText(GetVisibilityText, 'Görüþ mesafesi: %s'#13#10);
  if ShowPressure then
    AddWideText(GetPressureText, 'Basýnç: %s'#13#10);
  if ShowDate then
    AddWideText(DateStr, '%s'#13#10);
  if ShowHijri then
    AddWideText(HijriDateStr, '%s'#13#10);

  if (Result <> '') and (Length(Result) > 1) and
     (Result[Length(Result)] = #10) then
    Delete(Result, Length(Result) - 1, 2);

end;

function THavaCivaMainForm.GetHijriText: WideString;
var
  stg, sth: TSystemTime;
begin
  Result := '';
  if ConnectionStatus <> csConnected then Exit;
  GetLocalTime(stg);
  if GregorianTimeToHijriTime(stg, sth) = S_OK then
    Result := WideFormatHijriDate(sth);
end;

function THavaCivaMainForm.GetWindText: WideString;
begin
  if WindDirectionStr <> '' then
    Result := WideFormat('Rüzgar: %s', [WindDirectionStr])
  else
    Result := 'Rüzgar: Yok';
end;

function THavaCivaMainForm.GetWindDirectionText: WideString;
var
  DirectionNum: Integer;
begin
  Result := '';
  DirectionNum := StrToIntDef(WindDirectionStr, -1);
  if DirectionNum < 0 then Exit;
  case DirectionNum of
       0..23: Result := 'Kuzey';
      24..68: Result := 'Kuzey Doðu';
     69..113: Result := 'Doðu';
    114..158: Result := 'Güney Doðu';
    159..203: Result := 'Güney';
    204..248: Result := 'Güney Batý';
    249..293: Result := 'Batý';
    294..338: Result := 'Kuzey Batý';
  else
    Result := 'Kuzey';
  end;
end;

function THavaCivaMainForm.GetWeatherText: WideString;
{
var
  CondCodeInt: Integer;
}
begin
  Result := CondTextStr;
  {
  if CondCodeStr <> '' then
  begin
    CondCodeInt := StrToIntDef(CondCodeStr, 3200);
    if CondCodeInt = 3200 then CondCodeInt := 49;
    Result := WeatherIcons[CondCodeInt].Turkish;
  end;
  }
end;

function THavaCivaMainForm.GetVisibilityText: WideString;
var
  Visibility: Single;
begin
  Visibility := StrToFloatDef(VisibilityStr, -1.0, EnglishFS);
  if Visibility < 0 then
    Result := ''
  else if Visibility >= 320 then
    Result := 'Sýnýrsýz'
  else
    Result := FormatFloat('0.00 km', Visibility);
end;

procedure THavaCivaMainForm.VersionTimerTimer(Sender: TObject);
begin
  CheckNewVersion;
end;

procedure THavaCivaMainForm.CheckNewVersion;
begin

  if Assigned(CheckVerThread) then
    if not CheckVerThread.Terminated then Exit;

  VersionTimer.Enabled := False;

  if Assigned(CheckVerThread) then FreeAndNil(CheckVerThread);
  CheckVerThread := TInternetThread.Create(Self.Handle, WM_CHECKVERDONE);
  with CheckVerThread do
  begin
    Request.Open('GET', MyHomePage + Format('havaciva.xml?v=%s&r=%d',
      [sCurrVersion, Random(MaxInt)]));
    Resume;
  end;
end;

procedure THavaCivaMainForm.LoadedTimerTimer(Sender: TObject);
begin
  LoadedTimer.Enabled := False;
  ShowMainForm;
  if FirstUsage then TrayIcon.ShowBalloonHint;
  { v1.50 }
  if HibernateCheck then HibernateActionExecute(Self);
end;

procedure THavaCivaMainForm.FadeInEffect(const Step, Wait, Max: Integer);
begin
  if not EnableFadeEffect then Exit;
  while Opacity < Max do
  begin
    if Opacity + Step >= Max then
    begin
      Opacity := Max;
      UpdateMainWindow;
      Break;
    end;
    Opacity := Opacity + Step;
    UpdateMainWindow;
    Sleep(Wait);
  end;
end;

procedure THavaCivaMainForm.FadeOutEffect(const Step, Wait, Min: Integer);
begin
  if not EnableFadeEffect then Exit;
  while Opacity > Min do
  begin
    if Opacity - Step <= Min then
    begin
      Opacity := Min;
      UpdateMainWindow;
      Break;
    end;
    Opacity := Opacity - Step;
    UpdateMainWindow;
    Sleep(Wait);
  end;
end;

procedure THavaCivaMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  InfoTextForm.HideForm;
  HideMainForm;
end;

procedure THavaCivaMainForm.HideMainForm;
begin
  if EnableFadeEffect then
    FadeOutEffect(OpacityStep, OpacityWait, OpacityMin);
  Self.Hide;
end;

procedure THavaCivaMainForm.ShowMainForm;
begin
  Self.Show;
  if EnableFadeEffect then
    FadeInEffect(OpacityStep, OpacityWait, OpacityMax);
end;

procedure THavaCivaMainForm.DoShowHint(var HintStr: string;
  var CanShow: Boolean; var HintInfo: THintInfo);
begin
  if HintInfo.HintControl = WeatherLbl then
    HintInfo.HintStr := GetInfoText;
end;

procedure THavaCivaMainForm.PrepareInfoText;
begin
  InfoText := GetInfoText;
  InfoTextHeight := GetInfoTextHeight;
end;

function THavaCivaMainForm.GetInfoTextHeight: Integer;
var
  R: TGPRectF;
begin
  GdiPlusMeasureString(DrawCanvas, InfoText, R, InfoTextLbl.Font,
    StringAlignmentCenter);
  Result := Round(R.Height);
end;

procedure THavaCivaMainForm.UpdateBackground;
begin
  Updating := True;
  try
    ClearBuffer;
    PaintBackground;
    PaintEarth;
    UpdateMainWindow;
  finally
    Updating := False;
  end;
end;

procedure THavaCivaMainForm.PaintButtons;
begin

  if IsActive then
  begin
    if ExitBtn.Visible then
      DrawCanvas.DrawImage(CloseImage, ExitBtn.Left, ExitBtn.Top,
        CloseImage.GetWidth, CloseImage.GetHeight);
    if HideBtn.Visible then
      DrawCanvas.DrawImage(HideImage, HideBtn.Left, HideBtn.Top,
        HideImage.GetWidth, HideImage.GetHeight);
    if OptionsBtn.Visible then
      DrawCanvas.DrawImage(OptionsImage, OptionsBtn.Left, OptionsBtn.Top,
        OptionsImage.GetWidth, OptionsImage.GetHeight);
  end;
end;

function THavaCivaMainForm.GetDateTime: WideString;
begin
  if ConnectionStatus <> csConnected then Result := ''
  else
    Result := WideFormatDate(SysUtils.Now(), TurkishFS);
end;

function THavaCivaMainForm.GetSunText: WideString;
begin
  Result := '';
  if (SunriseStr <> '') and (SunsetStr <> '') then
    Result := WideFormat('GD: %s, GB: %s',
      [FormatDateTime(ShortTimeFormat, StrToTime(SunriseStr)),
      FormatDateTime(ShortTimeFormat, StrToTime(SunsetStr))]);
end;

procedure THavaCivaMainForm.PaintEarth;
begin
  if WeatherLbl.Visible then
  begin
    DrawCanvas.DrawImage(EarthImage, WeatherLbl.Left, WeatherLbl.Top,
      EarthImage.GetWidth, EarthImage.GetHeight);
  end;
end;

procedure THavaCivaMainForm.ShortPopupPopup(Sender: TObject);
var
  Item: TMenuItem;
  Index: Integer;
begin
  FavoritesMenu.Clear;
  IniFile.ReadSectionValues(sFavorites, Favorites);
  if Favorites.Count > 0 then
  begin
    Favorites.Sort;
    for Index := 0 to Favorites.Count - 1 do
    begin
      Item := TMenuItem.Create(Self);
      Item.Caption := Favorites.Names[Index];
      Item.OnClick := ChooseFavorite;
      FavoritesMenu.Add(Item);
    end;
  end
  else begin
    Item := TMenuItem.Create(Self);
    Item.Caption := 'Favori Listesi Boþ';
    Item.Enabled := False;
    FavoritesMenu.Add(Item);
  end;
end;

procedure THavaCivaMainForm.ChooseFavorite(Sender: TObject);
var
  Item: TMenuItem;
  ACityID: string;
begin
  if ConnectionStatus = csConnecting then Exit;
  Item := Sender as TMenuItem;
  ACityID := IniFile.ReadString(sFavorites, Item.Caption, '');
  if ACityID <> '' then
  begin
    CityID := ACityID;
    SearchCityStr := Item.Caption;
    InternetUpdate;
  end;
end;

procedure THavaCivaMainForm.WMCheckVerDone(var Message: TMessage);
begin
  CheckVerXML := CheckVerThread.Response.Content;
  if Assigned(CheckVerThread) then FreeAndNil(CheckVerThread);
  if Message.LParam = 0 then
  begin
    ParseCheckVerXML;
    if (VersionStr <> '') and (CompareText(sCurrVersion, VersionStr) < 0) then
      if Windows.MessageBox(Self.Handle,
        PChar(Format(sUpdateMessage, [VersionStr])), 'Yeni Sürüm için Uyarý',
        MB_YESNO or MB_ICONINFORMATION) = IDYES then
          ShellExecute(Self.Handle, 'open', MyHomePage, nil, nil, SW_SHOWNORMAL);
  end;
end;

procedure THavaCivaMainForm.ParseCheckVerXML;
var
  xmlPage, Elem: OleVariant;
begin

  if CheckVerXML = '' then Exit;

  xmlPage := CreateOleObject('Microsoft.XMLDOM');
  try
    if not VarIsClear(xmlPage) then
    begin
      if xmlPage.LoadXml(CheckVerXML) then
        begin
        // /data/version
        Elem := xmlPage.documentElement.selectSingleNode('/data/version');
        try
          if not VarIsClear(Elem) then
            VersionStr := Elem.Text;
        finally
          Elem := Unassigned;
        end;
      end;
    end;
  finally
    xmlPage := Unassigned;
  end;

end;

procedure THavaCivaMainForm.RegisterTracker;
const
  RefererHost = 'http://www.shenturk.com/';
var
  RefererUrl, Parameter: AnsiString;
begin

  if Assigned(TrackerThread) then Exit;

  Parameter := HTTPEncode(System.UTF8Encode(LocCityStr));
  RefererUrl := RefererHost;

  TrackerThread := TInternetThread.Create(Self.Handle, WM_TRACKERDONE);
  try
    with TrackerThread.Request do
    begin
      Host := 'whos.amung.us';
      URL := '/swidget/havaciva.gif';
      if Length(Parameter) > 0 then
        RefererUrl := RefererUrl + '?ref=' + Parameter;
      Referer := RefererUrl;
    end;
    TrackerThread.Resume;
  except
    FreeAndNil(TrackerThread);
  end;

end;

procedure THavaCivaMainForm.WMTrackerDone(var Message: TMessage);
begin
  if Assigned(TrackerThread) then FreeAndNil(TrackerThread);
end;

function THavaCivaMainForm.GetHintText: WideString;
begin
  Result := GetWeatherText + #13#10 + CondTempStr + #0176;
end;

procedure THavaCivaMainForm.PaintSun;
begin
  if WeatherLbl.Visible then
  begin
    DrawCanvas.DrawImage(SunImage, WeatherLbl.Left, WeatherLbl.Top,
      SunImage.GetWidth, SunImage.GetHeight);
  end;
end;

procedure THavaCivaMainForm.PaintMoon(Phase: Integer);
var
  Image: TGPBitmap;
  ImageName: string;
begin

  if Phase < 0 then Exit;

  if WeatherLbl.Visible then
  begin
    ImageName := '.\Contents\Resources\Moons\' + IntToStr(Phase) + '.png';
    Image := TGPBitmap.Create(ImageName);
    try
      DrawCanvas.DrawImage(Image, WeatherLbl.Left, WeatherLbl.Top,
        Image.GetWidth, Image.GetHeight);
    finally
      Image.Free;
    end;
  end;

end;

procedure THavaCivaMainForm.PaintNone;
begin
  if WeatherLbl.Visible then
  begin
    DrawCanvas.DrawImage(NoneImage, WeatherLbl.Left, WeatherLbl.Top,
      NoneImage.GetWidth, NoneImage.GetHeight);
  end;
end;

function THavaCivaMainForm.GetPressureText: WideString;
begin
  Result := '';
  if PressureStr <> '' then
    Result := WideFormat('%s mb', [PressureStr]);
end;

function THavaCivaMainForm.GetTrayHintText: WideString;
const
  sHavaCiva: WideString = 'Hava Cýva!';
  
  procedure AddWideText(const Item, FormatStr: WideString);
  begin
    if Item <> '' then
      Result := Result + WideFormat(FormatStr, [Item]) + ', ';
  end;

begin
  if ConnectionStatus = csConnected then
  begin
    AddWideText(LocCityStr, '%s');
    AddWideText(GetWeatherText, '%s');
    AddWideText(GetTemperatureText, '%s');
    if (Result <> '') and (Length(Result) > 1) and
       (Result[Length(Result) - 1] = ',') then
      Delete(Result, Length(Result) - 1, 2);
    if Result <> '' then
      Result := sHavaCiva + ' - ' + Result
    else
      Result := sHavaCiva;
  end
  else
    Result := 'Hava Cýva! - ' + GetConnectionText;
end;

function THavaCivaMainForm.GetSituationText: WideString;
begin
  Result := '';
  if (LatitudeStr <> '') and (LongitudeStr <> '') then
    Result := WideFormat('E: %s'#0176', B: %s'#0176, [LatitudeStr, LongitudeStr] );
end;

function THavaCivaMainForm.GetTemperatureText: WideString;
begin
  if CondTempStr <> '' then
    Result := CondTempStr + #0176
  else
    Result := '';
end;

procedure THavaCivaMainForm.ToggleInfoTextForm(Value: Boolean);
begin
  ShowInfoAction.Checked := Value;
  ShowInfoText := Value;
  if ShowInfoText then InfoTextForm.ShowForm
  else InfoTextForm.HideForm;
  IniFile.WriteBool(sAppearance, sShowInfoText, ShowInfoText);
  IniFile.UpdateFile;
end;

procedure THavaCivaMainForm.ParseWeatherXML;
var
  xmlPage: IXMLDOMDocument;
  Node: IXMLDOMNode;
  Elem: IXMLDOMElement;
  ElemList: IXMLDOMNodeList;
  I, Len: Integer;
  Text: WideString;
begin

  if WeatherXML = '' then Exit;

  xmlPage := CreateOleObject('Microsoft.XMLDOM') as IXMLDOMDocument;
  try

    if Assigned(xmlPage) then
    begin

      if xmlPage.LoadXML(WeatherXML) then
      begin

        { xmlPage.save('weather.xml'); }

        // error
        Node := xmlPage.documentElement.selectSingleNode('/weatherdata/weather/@errormessage');
        if Assigned(Node) then
        begin
          Exit;
        end;

        // location, lat, long
        Node := xmlPage.documentElement.selectSingleNode('/weatherdata/weather');
        if Assigned(Node) then
        begin
          Elem := Node as IXMLDOMElement;
          Text := Elem.getAttribute('weatherlocationname');
          if Pos(',', Text) > 0 then Text := Copy(Text, 1, Pos(',', Text) - 1);  
          LocCityStr := UTF8Decode(Text);
          LocCountryStr := '';
          Text := Elem.getAttribute('lat');
          LatitudeStr := Text;
          Text := Elem.getAttribute('long');
          LongitudeStr := Text;
          Text := Elem.getAttribute('timezone');
          TimeZoneStr := Text;
        end;

        // sunrise, sunset
        SunriseStr := '00:00';
        SunsetStr := '00:00';

        // time, temp, text, code
        Node := xmlPage.documentElement.selectSingleNode('/weatherdata/weather/current');
        if Assigned(Node) then
        begin
          Elem := Node as IXMLDOMElement;
          Text := Elem.getAttribute('observationtime');
          LocalTimeStr := Text;
          Text := Elem.getAttribute('temperature');
          CondTempStr := Text;
          Text := Elem.getAttribute('skytext');
          CondTextStr := UTF8Decode(Text);
          Text := Elem.getAttribute('skycode');
          CondCodeStr := Text;
          PressureStr := '0';
          Text := Elem.getAttribute('humidity');
          HumidityStr := Text;
          VisibilityStr := '0';
          Text := Elem.getAttribute('feelslike');
          WindChillStr := Text;
          Text := Elem.getAttribute('windspeed');
          WindSpeedStr := Text;
          Text := Elem.getAttribute('winddisplay');
          WindDirectionStr := UTF8Decode(Text);
        end;

        // days
        ElemList := xmlPage.documentElement.selectNodes('/weatherdata/weather/forecast');
        try
          if Assigned(ElemList) and (ElemList.Length > 1) then
          begin
            Len := ElemList.Length;
            if Len > MaxForecast then Len := MaxForecast;
            Node := ElemList.Item[0];
            Elem := Node as IXMLDOMElement;
            ForecastLows[0] := Elem.getAttribute('low');
            ForecastHighs[0] := Elem.getAttribute('high');
            ForecastCodes[0] := Elem.getAttribute('skycodeday');
            ForecastTexts[0] := UTF8Decode(Elem.getAttribute('skytextday'));
            ForecastDays[0] := UTF8Decode(Elem.getAttribute('shortday'));
            for I := 1 to Len - 1 do
            begin
              Node := ElemList.Item[I];
              Elem := Node as IXMLDOMElement;
              ForecastLows[I] := Elem.getAttribute('low');
              ForecastHighs[I] := Elem.getAttribute('high');
              ForecastCodes[I] := Elem.getAttribute('skycodeday');
              ForecastTexts[I] := UTF8Decode(Elem.getAttribute('skytextday'));
              ForecastDays[I] := UTF8Decode(Elem.getAttribute('shortday'));
            end;
          end;
        finally
          ElemList := nil;
        end;
      end; // end of "if xmlPage.LoadXML(WeatherXML) then"
    end; // end of "if not VarIsClear(xmlPage) then"
  finally
    xmlPage := nil;
  end;
end;

procedure THavaCivaMainForm.ResetData;
var
  I: Integer;
begin
  SunriseStr := '';
  SunsetStr := '';
  LatitudeStr := '';
  LongitudeStr := '';
  LocalTimeStr := '';
  TimeZoneStr := '';
  WindChillStr := '';
  WindDirectionStr := '';
  WindSpeedStr := '';
  LocCityStr := '';
  LocCountryStr := '';
  HumidityStr := '';
  VisibilityStr := '';
  PressureStr := '';
  CondTextStr := '';
  CondCodeStr := '';
  CondTempStr := '';
  for I := 0 to MaxForecast - 1 do
  begin
    ForecastDays[I] := '';
    ForecastLows[I] := '';
    ForecastHighs[I] := '';
    ForecastCodes[I] := '';
    ForecastDates[I] := '';
    ForecastTexts[I] := '';
  end;
  SearchCityStr := '';
end;

procedure THavaCivaMainForm.WMMove(var Message: TWMMove);
begin
  inherited;
  if Assigned(InfoTextForm) then
  begin
    InfoTextForm.Left := Self.Left + Distance.X;
    InfoTextForm.Top := Self.Top + Distance.Y;
  end;
end;

procedure THavaCivaMainForm.ExitActionExecute(Sender: TObject);
begin
  Close;
end;

procedure THavaCivaMainForm.ShowInfoActionExecute(Sender: TObject);
begin
  ShowInfoAction.Checked := not ShowInfoAction.Checked;
  ToggleInfoTextForm(ShowInfoAction.Checked);
end;

procedure THavaCivaMainForm.OptionsActionExecute(Sender: TObject);
begin
  ShowOptionsDialog(-1);
end;

procedure THavaCivaMainForm.HideActionExecute(Sender: TObject);
begin
  HideMainForm;
  InfoTextForm.HideForm;
end;

procedure THavaCivaMainForm.ShowActionExecute(Sender: TObject);
begin
  SetForeGroundWindow( Self.Handle);
  ShowMainForm;
  if ShowInfoText then InfoTextForm.ShowForm;
end;

procedure THavaCivaMainForm.RefreshActionExecute(Sender: TObject);
begin
  if ConnectionStatus <> csConnecting then
  begin
    DisableEvents;
    InternetUpdate;
    EnableEvents;
  end;
end;

procedure THavaCivaMainForm.AboutActionExecute(Sender: TObject);
begin
  AboutForm.ShowForm;
end;

procedure THavaCivaMainForm.TrayPopupPopup(Sender: TObject);
var
  Item: TMenuItem;
  Index: Integer;
begin
  TrayFavoritesMenu.Clear;
  IniFile.ReadSectionValues(sFavorites, Favorites);
  if Favorites.Count > 0 then
  begin
    Favorites.Sort;
    for Index := 0 to Favorites.Count - 1 do
    begin
      Item := TMenuItem.Create(Self);
      Item.Caption := Favorites.Names[Index];
      Item.OnClick := ChooseFavorite;
      TrayFavoritesMenu.Add(Item);
    end;
  end
  else begin
    Item := TMenuItem.Create(Self);
    Item.Caption := 'Favori Listesi Boþ';
    Item.Enabled := False;
    TrayFavoritesMenu.Add(Item);
  end;
end;

procedure THavaCivaMainForm.AddLocActionExecute(Sender: TObject);
begin
  ShowOptionsDialog(2);
end;

procedure THavaCivaMainForm.UpdateActionsState;
begin

  HideBtn.Enabled := IsActive and (ConnectionStatus <> csConnecting);
  ExitBtn.Enabled := IsActive and (ConnectionStatus <> csConnecting);
  OptionsBtn.Enabled := IsActive and (ConnectionStatus <> csConnecting);

  HideBtn.Visible := TrayIcon.Visible and (ConnectionStatus <> csConnecting);
  ExitBtn.Visible := IsActive and (ConnectionStatus <> csConnecting);
  OptionsBtn.Visible := IsActive and (ConnectionStatus <> csConnecting);

  OptionsAction.Enabled := ConnectionStatus <> csConnecting;
  HideAction.Enabled := TrayIcon.Visible and (ConnectionStatus <> csConnecting);
  ExitAction.Enabled := ConnectionStatus <> csConnecting;

  RefreshAction.Enabled := ConnectionStatus <> csConnecting;
  AddLocAction.Enabled := ConnectionStatus <> csConnecting;
  
end;

procedure THavaCivaMainForm.ShowOptionsDialog(const PageIndex: Integer);
var
  OptionsForm: TOptionsForm;
begin
  DisableEvents;
  SaveOptions;
  OptionsForm := TOptionsForm.Create(Self);
  try
    if (PageIndex >= 0) and (PageIndex < OptionsForm.PageControl1.PageCount) then
      OptionsForm.PageControl1.ActivePageIndex := PageIndex;
    if OptionsForm.ShowModal = mrOk then
    //OptionsForm.ShowModal;
    begin
      LoadOptions;
      if OptionsForm.CityChanged then InternetUpdate
      else UpdateLayered;
      InfoTextForm.UpdateLayered;
      if ShowInfoText then InfoTextForm.ShowForm
      else InfoTextForm.HideForm;
    end
    else begin
      //LoadOptions;
      UpdateLayered;
    end;
  finally
    OptionsForm.Free;
    EnableEvents;
  end;
end;

function THavaCivaMainForm.GetMoonPhasePercent(const TheDate: TDateTime): Integer;
const
  Synodic  = 29.53058867;
  MsPerDay = 24 * 60 * 60 * 1000;
var
  BaseDate: TDateTime;
  Phase: Double;
  Diff: Int64;
begin
  // Source: http://aa.usno.navy.mil/data/docs/MoonPhase.html
  // Istanbul'da Yeni Ay olustugu tarih ve saat (y,m,d,h,m): 2006, 6, 25, 18, 05
  // Orjinal data 2 saat geridedir (16:05). Istanbul +2 saat ileride!
  BaseDate := DateUtils.EncodeDateTime(2006, 6, 25, 18, 05, 0, 0);
  Diff := MilliSecondsBetween(TheDate, BaseDate);
  Phase := Diff / (Synodic * MsPerDay);
  Phase := Phase * 100;
  while Phase > 100 do Phase := Phase - 100;
  if Phase < 0 then Phase := 50;
  if Phase = 0 then Phase := 100;
  Result := Trunc(Phase);
end;

procedure THavaCivaMainForm.UpdateFormStyle;
begin
  if StayOnTop then
    SetWindowPos(Self.Handle, HWND_TOPMOST, 0, 0, 0, 0,
      SWP_NOMOVE or SWP_NOSIZE or SWP_FRAMECHANGED)
  else
    SetWindowPos(Self.Handle, HWND_NOTOPMOST, 0, 0, 0, 0,
      SWP_NOMOVE or SWP_NOSIZE or SWP_FRAMECHANGED);
end;

function THavaCivaMainForm.GetBackScale: Double;
begin
  case MainViewStyle of
    mvsMini: Result := 1.25;
    mvsMidi: Result := 2.50;
  else Result := 4.00;
  end;
end;

procedure THavaCivaMainForm.UpdateMainViewStyle;
begin
  case MainViewStyle of
    mvsMini: SetMiniViewStyle;
    mvsMidi: SetMidiViewStyle;
  else SetMaxiViewStyle;
  end;
end;

procedure THavaCivaMainForm.SetMaxiViewStyle;
begin
  GridLbl.Visible := True;
  Day1Lbl.Visible := True;
  Day2Lbl.Visible := True;
  Day3Lbl.Visible := True;
  Day4Lbl.Visible := True;
  Day5Lbl.Visible := True;
  MoonLbl.Visible := True;
end;

procedure THavaCivaMainForm.SetMidiViewStyle;
begin
  GridLbl.Visible := True;
  Day1Lbl.Visible := True;
  Day2Lbl.Visible := True;
  Day3Lbl.Visible := True;
  Day4Lbl.Visible := False;
  Day5Lbl.Visible := False;
  MoonLbl.Visible := False;
end;

procedure THavaCivaMainForm.SetMiniViewStyle;
begin
  GridLbl.Visible := False;
  Day1Lbl.Visible := False;
  Day2Lbl.Visible := False;
  Day3Lbl.Visible := False;
  Day4Lbl.Visible := False;
  Day5Lbl.Visible := False;
  MoonLbl.Visible := False;
end;

procedure THavaCivaMainForm.MiniActionExecute(Sender: TObject);
begin
  MainViewStyle := mvsMini;
  UpdateMainViewStyle;
  AnimateViewStyleUp;
  Self.UpdateLayered;
end;

procedure THavaCivaMainForm.MidiActionExecute(Sender: TObject);
begin
  if MainViewStyle = mvsMini then { Previous Style }
  begin
    MainViewStyle := mvsMidi;
    AnimateViewStyleDown;
    UpdateMainViewStyle;
    Self.UpdateLayered;
  end
  else if MainViewStyle = mvsMaxi then
  begin
    MainViewStyle := mvsMidi;
    UpdateMainViewStyle;
    AnimateViewStyleUp;
    Self.UpdateLayered;
  end;
end;

procedure THavaCivaMainForm.MaxiActionExecute(Sender: TObject);
begin
  MainViewStyle := mvsMaxi;
  AnimateViewStyleDown;
  UpdateMainViewStyle;
  Self.UpdateLayered;
end;

procedure THavaCivaMainForm.AnimateViewStyleDown;
begin
  while BackScale < GetBackScale do
  begin
    BackScale := BackScale + 0.25;
    Self.UpdateLayered;
  end;
end;

procedure THavaCivaMainForm.AnimateViewStyleUp;
begin
  while BackScale > GetBackScale do
  begin
    BackScale := BackScale - 0.25;
    Self.UpdateLayered;
  end;
end;

procedure THavaCivaMainForm.UpdateMainViewMenuChecks;
begin
  MiniAction.Checked := MainViewStyle = mvsMini;
  MidiAction.Checked := MainViewStyle = mvsMidi;
  MaxiAction.Checked := MainViewStyle = mvsMaxi;
end;

procedure THavaCivaMainForm.CMExitApp(var Message: TMessage);
begin
  ExitActionExecute(Self);
end;

procedure THavaCivaMainForm.ClearBuffer;
begin
  {
    Alpha (ilk byte) $00 olunca hersey siliniyor. Reallocate etmeye
    gerek kalmadi. Ogreniyoruz iste yavas yavas. (Ey DSL! v1.10)
  }
  DrawCanvas.Clear($00000000);
end;

procedure THavaCivaMainForm.HibernateActionExecute(Sender: TObject);
begin
  if AlertShow then Exit;
  HibernateAction.Checked := not HibernateAction.Checked;
  if HibernateAction.Checked then
  begin
    PrevFormStyle := GetWindowLong(Self.Handle, GWL_EXSTYLE);
    if PrevFormStyle and WS_EX_TRANSPARENT = 0 then
    begin
      CheckHibernateAlert;
      Hibernate;
      SetWindowLong(Self.Handle, GWL_EXSTYLE, PrevFormStyle or WS_EX_TRANSPARENT);
      MouseTimer.Enabled := True;
    end;
  end
  else if PrevFormStyle <> 0 then
  begin
    MouseTimer.Enabled := False;
    Wakeup;
    SetWindowLong(Self.Handle, GWL_EXSTYLE, PrevFormStyle);
  end;
  InfoTextForm.HibernateActionExecute(Self);
end;

procedure THavaCivaMainForm.Hibernate;
begin
  OpacityMax := 255 div 2;
  if EnableFadeEffect then
    FadeOutEffect(OpacityStep, OpacityWait, OpacityMax)
  else begin
    Opacity := OpacityMax;
    UpdateMainWindow;
  end;
end;

procedure THavaCivaMainForm.Wakeup;
begin
  OpacityMax := 255;
  if EnableFadeEffect then
    FadeInEffect(OpacityStep, OpacityWait, OpacityMax)
  else begin
    Opacity := OpacityMax;
    UpdateMainWindow;
  end;
end;

procedure THavaCivaMainForm.CheckHibernateAlert;
var
  HibernateForm: THibernateForm;
begin
  HibernateAlert := IniFile.ReadBool(sGeneral, sHibernateAlert, True);
  if (not HibernateAlert) or (AlertShow) then Exit;
  HibernateForm := THibernateForm.Create(Self);
  try
    AlertShow := True;
    HibernateForm.ShowModal;
  finally
    AlertShow := False;
    HibernateForm.Free;
  end;
end;

procedure THavaCivaMainForm.MouseTimerTimer(Sender: TObject);
var
  P: TPoint;
begin
  GetCursorPos(P);
  if PtInRect(Self.BoundsRect, P) then
  begin
    if (GetKeyState(VK_CONTROL) and $8000) <> 0 then
      HibernateActionExecute(Sender);
  end;
end;

procedure THavaCivaMainForm.CMRestoreApp(var Message: TMessage);
begin
  Application.Restore;
  if not Self.Visible then
  begin
    ShowMainForm;
    if ShowInfoText then InfoTextForm.ShowForm;
  end;
end;

procedure THavaCivaMainForm.WMEndSession(var Message: TWMEndSession);
begin
  InfoTextForm.HideForm;
  HideMainForm;
  Self.SaveOptions;
  IniFile.UpdateFile;
  inherited;
end;

procedure THavaCivaMainForm.WMQueryEndSession(
  var Message: TWMQueryEndSession);
begin
  Message.Result := Integer(True);
end;

procedure THavaCivaMainForm.BeginCityWeather;
var
  FormattedURL, NewCityID: string;
begin

  if Assigned(WeatherThread) then
  begin
    if not WeatherThread.Terminated then Exit;
  end;

  ConnectionStatus := csConnecting;
  UpdateLayered;
  if Assigned(WeatherThread) then FreeAndNil(WeatherThread);

  { v3.00 }
  WeatherThread := TInternetThread.Create(Self.Handle, WM_WEATHERDONE);
  with WeatherThread do
  begin
    NewCityID := CityID;
    if Pos('|', NewCityID) > 0 then NewCityID := Copy(NewCityID, 1, Pos('|', NewCityID) - 1);
    if (Pos('wc:', NewCityID) = 0) and (Pos('fr:', NewCityID) = 0) then NewCityID := 'wc:' + NewCityID;
    FormattedURL := Format(ForecastURL, [NewCityID, UnitValue, 'tr-TR']); //en-US
    Request.Open('GET', FormattedURL);
    Resume;
  end;

end;

procedure THavaCivaMainForm.AntialiasActionExecute(Sender: TObject);
begin
  AntialiasAction.Checked := not AntialiasAction.Checked;
  Antialias := not AntialiasAction.Checked;
  UpdateLayered;
  if Assigned(InfoTextForm) then
    InfoTextForm.UpdateLayered;
end;

end.
