{*******************************************************}
{                                                       }
{       ConstDef.pas                                    }
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
{                                                       }
{*******************************************************}

unit ConstDef;

interface

uses Windows, SysUtils, GdipApi, GdipObj, DirectDraw, SysConst;

const
  SC_DRAGMOVE = $F012;

const
  sCurrVersion    = '2.00';
  sUpdateMessage  = 'Hava Cýva! nýn %s sürümü çýkmýþ! Ýndirmek ister misiniz?';
  sBalloonHintMsg = 'Hava Cýva! çalýþýyor! Hemen bulunduðunuz ili seçin ve'#13#10 +
                    'tam beþ günlük Hava durumunu öðrenin. Bunun için ana ' +
                    'pencerede farenin sað tuþuna basmanýz yeterli. Hem dahasý da var...';

const
  SearchURL      = 'http://xoap.weather.com/search/search'; //?where= + City';
  //ForecastURL    = 'http://xml.weather.yahoo.com/forecastrss/'; // + LocationID + "_" & UnitValue + ".xml"';
  //ForecastURL    = 'http://xml.weather.yahoo.com/forecastrss'; { v1.50 }
  ForecastURL    = 'http://yahoowidget.weather.com/weather/local/'; { v1.80 }
  MyHomePage     = 'http://www.shenturk.com/';
  // http://xml.weather.yahoo.com/forecastrss?p=TUXX0014&u=c

var
  { v1.50 }
  OpacityMin: Byte = 0;
  OpacityMax: Byte = 255;
  { v2.00 }
  AppGuid: TGUID;
  AppGuidStr: string;
  DefaultGuid: TGUID = '{705F4B2D-91E4-43EC-AAF7-B596DFF4DFB5}';

const
  OpacityStep  = 18;
  OpacityWait  = 2;

  MinuteMs = 60000;
  HourMs   = MinuteMs * 60;

type
  PARGB = ^TARGB;
  TARGB = record
    B, G, R, A: Byte; // Dikkat, Sirasi onemli.
  end;

  PARGBArray = ^TARGBArray;
  TARGBArray = array[0..MaxInt div SizeOf(TARGB) - 1] of TARGB;

type
  TBackgroundStyle  = (bsNone, bsTinyGlass, bsDarkGlass, bsCoffeeMilk, bsColorized);
  TConnectionStatus = (csConnected, csConnecting, csNotConnected, csException);

const
  sShellLinkName    = '\Hava Cýva!.lnk';

  sConnected        = 'Baðlantý kuruldu';
  sConnecting       = 'Baðlantý kuruluyor...';
  sNotConnected     = 'Baðlantý yok';
  sException        = 'Hata: Ýstisnai durum oluþtu.';

  IniFilePath       = '.\Options.ini';

  sAppearance       = 'Appearance';
  sLocation         = 'Location';
  sGeneral          = 'General';
  sStartup          = 'Startup';
  sDesktop          = 'Desktop';
  sQuickLunch       = 'QuickLunch';
  sAutoUpdate       = 'AutoUpdate';
  sUpdatePeriod     = 'UpdatePeriod';
  sShowTrayIcon     = 'ShowTrayIcon';
  sAlwaysTop        = 'AlwaysTop';
  sLeft             = 'Left';
  sTop              = 'Top';
  sCityName         = 'CityName';
  sCityID           = 'CityID';
  sBackground       = 'Background';
  sBackColor        = 'BackColor';
  sGlassEffect      = 'GlassEffect';
  sGlassOpacity     = 'GlassOpacity';
  sShowPressure     = 'ShowPressure';
  sShowDate         = 'ShowDate';
  sShowHijri        = 'ShowHijri';
  sShowSituation    = 'ShowSituation';
  sShowSunInfo      = 'ShowSunInfo';
  sShowWind         = 'ShowWind';
  sShowHumidity     = 'ShowHumidity';
  sShowVisibility   = 'ShowVisibility';
  sShowChill        = 'ShowChill';
  sShowWeatherText  = 'ShowWeatherText';
  sCheckNewVersion  = 'CheckNewVersion';
  sLastTabSheet     = 'LastTabSheet';
  sFadeEffect       = 'FadeEffect';
  sCitiesTU         = 'CitiesTU';
  sFavorites        = 'Favorites';
  sTempFontName     = 'TempFontName';
  sTempFontColor    = 'TempFontColor';
  sCityFontName     = 'CityFontName';
  sCityFontColor    = 'CityFontColor';
  sInfoTextLeft     = 'InfoTextLeft';
  sInfoTextTop      = 'InfoTextTop';
  sShowInfoText     = 'ShowInfoText';
  sFirstUsage       = 'FirstUsage';
  { v1.50 }
  sMainViewStyle    = 'ViewStyle';
  sHibernateAlert   = 'HibernateAlert';
  sHibernate        = 'Hibernate';

const
  MaxForecast = 5;

type
  TDayState = (dsNone, dsNightTime, dsDayTime);

  TWeatherIcons = record
    Weather: string;
    SoM: Boolean; // Sun or Moon
    Turkish: WideString;
  end;

  { v 1.50 }
  TMainViewStyle = (mvsMini, mvsMidi, mvsMaxi);

const
  MaxWeatherIcons = 50;

  WeatherIcons: array[0..MaxWeatherIcons - 1] of TWeatherIcons = (
    (Weather: 'Thunderstorms'; SoM: False; Turkish: 'Gök gürültülü'),
    (Weather: 'Thunderstorms'; SoM: False; Turkish: 'Gök Gürültülü'),
    (Weather: 'Thunderstorms'; SoM: False; Turkish: 'Gök Gürültülü'),
    (Weather: 'Thunderstorms'; SoM: False; Turkish: 'Gök Gürültülü'),
    (Weather: 'Thunderstorms'; SoM: False; Turkish: 'Gök Gürültülü'),
    (Weather: 'Hail'; SoM: False; Turkish: 'Dolu'),
    (Weather: 'Hail'; SoM: False; Turkish: 'Dolu'),
    (Weather: 'Hail'; SoM: False; Turkish: 'Dolu'),
    (Weather: 'Showers'; SoM: False; Turkish: 'Yaðýþlý'),
    (Weather: 'Showers'; SoM: False; Turkish: 'Yaðýþlý'),
    (Weather: 'Rain'; SoM: False; Turkish: 'Yaðmurlu'),
    (Weather: 'Showers'; SoM: False; Turkish: 'Yaðýþlý'),
    (Weather: 'Rain'; SoM: False; Turkish: 'Yaðmurlu'),
    (Weather: 'Flurries'; SoM: False; Turkish: 'Sert Rüzgarlý'),
    (Weather: 'Snow'; SoM: False; Turkish: 'Kar Yaðýþlý'),
    (Weather: 'Ice'; SoM: False; Turkish: 'Don'),
    (Weather: 'Snow'; SoM: False; Turkish: 'Kar Yaðýþlý'),
    (Weather: 'Thunderstorms'; SoM: False; Turkish: 'Gök Gürültülü'),
    (Weather: 'Hail'; SoM: False; Turkish: 'Don'),
    (Weather: 'Haze'; SoM: True; Turkish: 'Hafif Sisli'),
    (Weather: 'Fog'; SoM: False; Turkish: 'Sisli'),
    (Weather: 'Haze'; SoM: True; Turkish: 'Hafif Sisli'),
    (Weather: 'Haze'; SoM: True; Turkish: 'Hafif Sisli'),
    (Weather: 'Wind'; SoM: False; Turkish: 'Rüzgarlý'),
    (Weather: 'Wind'; SoM: False; Turkish: 'Rüzgarlý'),
    (Weather: 'Ice'; SoM: False; Turkish: 'Don'),
    (Weather: 'Many Clouds'; SoM: False; Turkish: 'Çok Bulutlu'),
    (Weather: 'Many Clouds'; SoM: True; Turkish: 'Çok Bulutlu'),
    (Weather: 'Many Clouds'; SoM: True; Turkish: 'Çok Bulutlu'),
    (Weather: 'Clouds'; SoM: True; Turkish: 'Parçalý Bulutlu'),
    (Weather: 'Clouds'; SoM: True; Turkish: 'Parçalý Bulutlu'),
    (Weather: 'None'; SoM: True; Turkish: 'Açýk'),
    (Weather: 'None'; SoM: True; Turkish: 'Açýk'),
    (Weather: 'Few Clouds'; SoM: True; Turkish: 'Az Bulutlu'),
    (Weather: 'Few Clouds'; SoM: True; Turkish: 'Az Bulutlu'),
    (Weather: 'Thunderstorms'; SoM: False; Turkish: 'Gök Gürültülü'),
    (Weather: 'None'; SoM: True; Turkish: 'Çok Sýcak'),
    (Weather: 'Thunderstorms'; SoM: True; Turkish: 'Gök Gürültülü'),
    (Weather: 'Thunderstorms'; SoM: True; Turkish: 'Gök Gürültülü'),
    (Weather: 'Showers'; SoM: True; Turkish: 'Yaðýþlý'),
    (Weather: 'Rain'; SoM: False; Turkish: 'Yaðmurlu'),
    (Weather: 'Snow'; SoM: False; Turkish: 'Kar Yaðýþlý'),
    (Weather: 'Snow'; SoM: False; Turkish: 'Kar Yaðýþlý'),
    (Weather: 'Snow'; SoM: False; Turkish: 'Kar Yaðýþlý'),
    (Weather: 'Few Clouds'; SoM: True; Turkish: 'Parçalý Bulutlu'),
    (Weather: 'Showers'; SoM: True; Turkish: 'Yaðmurlu'),
    (Weather: 'Snow'; SoM: False; Turkish: 'Kar Yaðýþlý'),
    (Weather: 'Thunderstorms'; SoM: True; Turkish: 'Gök Gürültülü'),
    (Weather: 'Rain'; SoM: True; Turkish: 'Yaðmurlu'),
    (Weather: 'None'; SoM: True; Turkish: 'Bilinmiyor')
  );

  MaxTinyWeatherIcons = 50;
  TinyWeatherIcons: array[0..MaxTinyWeatherIcons - 1] of string = (
			'Thunderstorms',		//  0 : Thunderstorms
			'Thunderstorms',		//  1 : Thunderstorms
			'Thunderstorms',		//  2 : Thunderstorms
			'Thunderstorms',		//  3 : Thunderstorms
			'Thunderstorms',		//  4 : Thunderstorms
			'Hail',					//  5 : Icy Snowy Rain ***
			'Hail',					//  6 : Sleet & Rain ***
			'Hail',					//  7 : Icy Snowy Rain (hail/rain/snow) ***
			'Showers',				//  8 : Icy Drizzle ***
			'Showers',				//  9 : Drizzle
			'Rain',					// 10 : Icy Rain ***
			'Showers',				// 11 : Light Showers ***
			'Rain',					// 12 : Showers ***
			'Flurries',				// 13 : Light Snow Flurries
			'Snow',					// 14 : Med Snow  ***
			'Ice',					// 15 : Friged (Very Cold)  ***
			'Snow',					// 16 : Normal Snow
			'Thunderstorms',		// 17 : Thunderstorms
			'Hail',					// 18 : Sleet ***
			'Haze',					// 19 : Dust ***
			'Fog',					// 20 : Fog
			'Haze',					// 21 : Hazy (do some mini-icon smarts here) ***
			'Haze',					// 22 : Smoke ***
			'Wind',					// 23 : Windy
			'Wind',					// 24 : Windy
			'Ice',					// 25 : Friged/Icy
			'Clouds',				// 26 : Cloudy (no sun/moon)
			'Moon And Clouds',		// 27 : Mostly Cloudy Night
			'Sun And Clouds',		// 28 : Mostly Cloudy Day
			'Moon And Clouds',		// 29 : Partially Cloudy Night
			'Sun And Clouds',		// 30 : Partially Cloudy Day
			'Moon',					// 31 : Clear Night
			'Sun',					// 32 : Clear Day
			'Moon Few Clouds',		// 33 : Tiny bit of clouds at night
			'Sun Few Clouds',		// 34 : Tiny bit of clouds during the day
			'Thunderstorms',		// 35 : Thunderstorms
			'Sun',					// 36 : Hot
			'Sunny Thunderstorms',	// 37 : Sunny Thunderstorms
			'Sunny Thunderstorms',	// 38 : Sunny Thunderstorms
			'Sun And Rain',			// 39 : Sunny Showers
			'Rain',					// 40 : Rain ***
			'Snow',					// 41 : Normal Snow (sunny)
			'Snow',					// 42 : Normal Snow
			'Snow',					// 43 : Blowing/Windy Snow (normal snow) ***
			'Sun Few Clouds',		// 44 : Partially Cloudy Day (N/A) ***
			'Moon And Rain',		// 45 : Night Rain ***
			'Snow',					// 46 : Night Snow ***
			'Thunderstorms',		// 47 : Night Thunder Storm
			'Sun And Rain',			// 48 : Sunny Rain ***
      'Blinmiyor'
		);

    PhaseNamesTurkish: array[0..27] of WideString = (
				'Yeni Ay', 'Yeni Ay',
				'Ýlk Hilâl', 'Ýlk Hilâl', 'Ýlk Hilâl', 'Ýlk Hilâl',
				'Ýlk Dördün', 'Ýlk Dördün', 'Ýlk Dördün',
				'Ýkinci Dördün', 'Ýkinci Dördün', 'Ýkinci Dördün', 'Ýkinci Dördün', 'Ýkinci Dördün',
				'Dolunay', 'Dolunay',
				'Üçüncü Dördün', 'Üçüncü Dördün', 'Üçüncü Dördün', 'Üçüncü Dördün',
				'Son Dördün', 'Son Dördün', 'Son Dördün',
				'Son Hilâl', 'Son Hilâl', 'Son Hilâl', 'Son Hilâl',
				'Yeni Ay');

    PhaseNamesEnglish: array[0..27] of WideString = (
				'New Moon', 'New Moon',
				'Waxing Crescent', 'Waxing Crescent', 'Waxing Crescent', 'Waxing Crescent',
				'First Quarter', 'First Quarter', 'First Quarter',
				'Waxing Gibbous', 'Waxing Gibbous', 'Waxing Gibbous', 'Waxing Gibbous', 'Waxing Gibbous',
				'Full Moon', 'Full Moon',
				'Waning Gibbous', 'Waning Gibbous', 'Waning Gibbous', 'Waning Gibbous',
				'Last Quarter', 'Last Quarter', 'Last Quarter',
				'Waning Crescent', 'Waning Crescent', 'Waning Crescent', 'Waning Crescent',
				'New Moon');

{ EnglishDayToTurkishDay }
function EnglishDayToTurkishDay(const DayName: WideString): WideString;

{ NextEnglishDay }
function NextEnglishDay(const DayName: WideString): WideString;

implementation

const
  MaxDays = 7;
  ShortTurkishDays: array[1..MaxDays] of WideString =
    ('PAZ', 'PZT', 'SAL', 'ÇRÞ', 'PRÞ', 'CUM', 'CMT');
  ShortEnglishDays: array[1..7] of string =
    ('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat');
  LongEnglishDays: array[1..7] of string =
    ('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
    
{ EnglishDayToTurkishDay }
function EnglishDayToTurkishDay(const DayName: WideString): WideString;
var
  I: Integer;
begin
  for I := 1 to MaxDays do
    if SameText(DayName, LongEnglishDays[I]) then Break;
  Result := ShortTurkishDays[I];
end;

{ NextEnglishDay }
function NextEnglishDay(const DayName: WideString): WideString;
var
  I: Integer;
begin
  for I := 1 to MaxDays do
    if SameText(DayName, LongEnglishDays[I]) then Break;
  if I = MaxDays then I := 0;
  Result := ShortEnglishDays[I + 1];
end;

end.
