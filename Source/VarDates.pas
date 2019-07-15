unit VarDates;

interface

uses Windows, ActiveX, SysUtils, GdipApi, GdipObj, DirectDraw, SysConst, DateUtils, Math;

const
  VAR_VALIDDATE          = $0004;
  VAR_CALENDAR_HIJRI     = $0008;
  VARIANT_CALENDAR_HIJRI = VAR_CALENDAR_HIJRI;

type
  UDATE = record
    st: _SYSTEMTIME;
    wDayOfYear: ShortInt;
  end;
  PUDATE = ^UDATE;

  _DATE = Double;

const
  TurkishDayNames: array[0..6] of WideString = (
    'Pazar', 'Pazartesi', 'Salý', 'Çarþamba',
    'Perþembe', 'Cuma', 'Cumartesi' );

  HijriMonthNames: array[1..12] of WideString = (
    'Muharrem', 'Safer', 'Rebîü''l-evvel', 'Rebîü''l-âhir',
    'Cemâziye''l-evvel', 'Cemâziye''l-âhir', 'Recep', 'Þaban',
    'Ramazân', 'Þevval', 'Zil-ka''de', 'Zil-hicce' );


  TurkishMonthNames: array[1..12] of WideString = (
    'Ocak', 'Þubat', 'Mart', 'Nisan',
    'Mayýs', 'Haziran', 'Temmuz', 'Aðustos',
    'Eylül', 'Ekim', 'Kasým', 'Aralýk' );

  DefShortMonthNames: array[1..12] of string = (SShortMonthNameJan,
    SShortMonthNameFeb, SShortMonthNameMar, SShortMonthNameApr,
    SShortMonthNameMay, SShortMonthNameJun, SShortMonthNameJul,
    SShortMonthNameAug, SShortMonthNameSep, SShortMonthNameOct,
    SShortMonthNameNov, SShortMonthNameDec);

  DefShortDayNames: array[0..6] of string = (SShortDayNameSun,
    SShortDayNameMon, SShortDayNameTue, SShortDayNameWed,
    SShortDayNameThu, SShortDayNameFri, SShortDayNameSat);

  { VarDateFromUdate }
  function VarDateFromUdate(
    pudateIn: PUDATE;
    dwFlags: DWORD;
    out pdateOut: TOleDate): HRESULT stdcall;

  { VarUdateFromDate }
  function VarUdateFromDate(
    dateIns: TOleDate;
    dwFlags: DWORD;
    out pudateOut: UDATE): HRESULT stdcall;

{ GregorianTimeToHijriTime }
function GregorianTimeToHijriTime(const stg: _SYSTEMTIME; var sth: _SYSTEMTIME): HRESULT;

{ HijriTimeToGregorianTime }
function HijriTimeToGregorianTime(const sth: _SYSTEMTIME; var stg: _SYSTEMTIME): HRESULT;

{ SystemDateToVarDate }
function SystemDateToVarDate(const st: _SYSTEMTIME): Double;

{ VarDateToSystemDate }
function VarDateToSystemDate(const dDate: Double; var st: _SYSTEMTIME): HRESULT;

{ WideFormatHijriDate }
function WideFormatHijriDate(const stDate: _SYSTEMTIME): WideString;

{ WideFormatDate }
function WideFormatDate(const DateTime: TDateTime;
  const FormatSettings: TFormatSettings): WideString;

{ DateTimeToHijriDateTime }
function DateTimeToHijriDateTime(const DateTime: TDateTime): TDateTime;

{ ShortMonthStrToInt }
function ShortMonthStrToInt(const MonthName: string): Integer;

{ ShortDayStrToInt }
function ShortDayStrToInt(const DayName: string): Integer;

{ MakeLangID }
function MakeLangID(usPrimaryLanguage, usSubLanguage: ShortInt): Word;

{ MakeLCID }
function MakeLCID(vLanguageID, vSortID: Word): DWORD;

{ WideGetLocaleMonthDayNames }
procedure WideGetLocaleMonthDayNames(DefaultLCID: Integer);

{ GetSunriseSunset }
procedure GetSunriseSunset(Date: TDateTime; Latitude, Longitude, TimeZone: Double; var Sunrise, Sunset: TDateTime);

var
  WideLongMonthNames: array[1..12] of WideString;
  WideLongDayNames: array[1..7] of WideString;

implementation

{ GregorianTimeToHijriTime }
function GregorianTimeToHijriTime(const stg: _SYSTEMTIME; var sth: _SYSTEMTIME): HRESULT;
var
  uDateg, uDateh: UDATE;
  pdateOut: TOleDate;
begin
  System.Move( stg, uDateg.st, SizeOf( _SYSTEMTIME ) );
  Result := VarDateFromUdate( @uDateg, VAR_VALIDDATE, pdateOut );
  if Result = S_OK then
  begin
    Result := VarUdateFromDate( pdateOut, VAR_VALIDDATE or VAR_CALENDAR_HIJRI, uDateh );
    if Result = S_OK then
      System.Move( uDateh.st, sth, SizeOf( _SYSTEMTIME ) );
  end;
end;

{ HijriTimeToGregorianTime }
function HijriTimeToGregorianTime(const sth: _SYSTEMTIME; var stg: _SYSTEMTIME): HRESULT;
var
  uDateg, uDateh: UDATE;
  pdateOut: TOleDate;
begin
  System.Move( sth, uDateh.st, SizeOf( _SYSTEMTIME ) );
  Result := VarDateFromUdate( @uDateh, VAR_VALIDDATE or VAR_CALENDAR_HIJRI, pdateOut );
  if Result = S_OK then
  begin
    Result := VarUdateFromDate( pdateOut, VAR_VALIDDATE, uDateg );
    if Result = S_OK then
      System.Move( uDateg.st, stg, SizeOf( _SYSTEMTIME ) );
  end;
end;

{ SystemDateToVarDate }
function SystemDateToVarDate(const st: _SYSTEMTIME): Double;
var
  puDate: UDATE;
begin
  System.Move( st, puDate.st, SizeOf( _SYSTEMTIME ) );
  VarDateFromUdate( @puDate, VAR_VALIDDATE, Result );
end;

{ VarDateToSystemDate }
function VarDateToSystemDate(const dDate: Double; var st: _SYSTEMTIME): HRESULT;
var
  puDate: UDATE;
begin
  Result := VarUdateFromDate( dDate, VAR_VALIDDATE, puDate );
  System.Move( puDate.st, st, SizeOf( _SYSTEMTIME ) );
end;

{ WideFormatHijriDate }
function WideFormatHijriDate(const stDate: _SYSTEMTIME): WideString;
begin
  {
  Result := WideFormat( '%d %s %d %s',
    [stDate.wDay, HijriMonthNames[stDate.wMonth],
    stDate.wYear, TurkishDayNames[stDate.wDayOfWeek]] );
  }
  Result := WideFormat( '%d %s %d',
    [stDate.wDay, HijriMonthNames[stDate.wMonth],
    stDate.wYear] );
  {
  Result := WideFormat( '%d %s %d',
    [stDate.wDay, wstrHijriMonthNames[stDate.wMonth], stDate.wYear] );
  }
end;

{ DateTimeToHijriDateTime }
function DateTimeToHijriDateTime(const DateTime: TDateTime): TDateTime;
var
  SystemTime, HijriSystemTime: TSystemTime;
begin
  DateTimeToSystemTime(DateTime, SystemTime);
  GregorianTimeToHijriTime(SystemTime, HijriSystemTime);
  Result := SystemTimeToDateTime(HijriSystemTime);
end;

{ ShortMonthStrToInt }
function ShortMonthStrToInt(const MonthName: string): Integer;
var
  Index: Integer;
begin
  Result := -1;
  for Index := 1 to 12 do begin
    if SameText(MonthName, DefShortMonthNames[Index]) then begin
      Result := Index;
      Break;
    end;
  end;
end;

{ ShortDayStrToInt }
function ShortDayStrToInt(const DayName: string): Integer;
var
  Index: Integer;
begin
  Result := -1;
  for Index := Low(DefShortDayNames) to High(DefShortDayNames) do
    if SameText(DayName, DefShortDayNames[Index]) then
    begin
      Result := Index;
      Break;
    end;
end;

{ MakeLangID }
function MakeLangID(usPrimaryLanguage, usSubLanguage: ShortInt): Word;
begin
  Result := (usSubLanguage shl 10) or usPrimaryLanguage;
end;

{ MakeLCID }
function MakeLCID(vLanguageID, vSortID: Word): DWORD;
begin
  Result := (vSortID shl 16) or vLanguageID;
end;

{ WideFormatDate }
function WideFormatDate(const DateTime: TDateTime;
  const FormatSettings: TFormatSettings): WideString;
begin
  // FormatSettings.LongMonthNames tipi WideString olsaydi olurdu.
  Result := WideFormat('%d %s %d %s', [DayOf(DateTime),
    WideLongMonthNames[MonthOf(DateTime)],
    YearOf(DateTime), WideLongDayNames[DayOfWeek(DateTime)]],
    FormatSettings);
end;

function GetLocaleStr(Locale, LocaleType: Integer; const Default: WideString): WideString;
var
  L: Integer;
  Buffer: array[0..255] of WideChar;
begin
  L := GetLocaleInfoW(Locale, LocaleType, Buffer, SizeOf(Buffer));
  if L > 0 then SetString(Result, Buffer, L - 1) else Result := Default;
end;

{ WideGetLocaleMonthDayNames }
{
procedure WideGetLocaleMonthDayNames(DefaultLCID: Integer;
  var FormatSettings: TFormatSettings);
}
procedure WideGetLocaleMonthDayNames(DefaultLCID: Integer);
var
  I, Day: Integer;

  function LocalGetLocaleStr(LocaleType: Integer): WideString;
  begin
    Result := GetLocaleStr(DefaultLCID, LocaleType, '');
  end;

begin
  for I := 1 to 12 do
  begin
    WideLongMonthNames[I] := LocalGetLocaleStr(LOCALE_SMONTHNAME1 + I - 1);
  end;
  for I := 1 to 7 do
  begin
    Day := (I + 5) mod 7;
    WideLongDayNames[I] := LocalGetLocaleStr(LOCALE_SDAYNAME1 + Day);
  end;
  {
  for I := 1 to 12 do
  begin
    FormatSettings.ShortMonthNames[I] := LocalGetLocaleStr(LOCALE_SABBREVMONTHNAME1 + I - 1);
    FormatSettings.LongMonthNames[I] := LocalGetLocaleStr(LOCALE_SMONTHNAME1 + I - 1);
  end;

  for I := 1 to 7 do
  begin
    Day := (I + 5) mod 7;
    FormatSettings.ShortDayNames[I] := LocalGetLocaleStr(LOCALE_SABBREVDAYNAME1 + Day);
    FormatSettings.LongDayNames[I] := LocalGetLocaleStr(LOCALE_SDAYNAME1 + Day);
  end;
  }
end;

function MOD_(n, d: Double): Double;
begin
  Result := n - d*Round(n/d);
end;

function RADIANS(Degrees: Double): Double;
begin
  Result := DegToRad(Degrees);
end;

function DEGREES(Grad: Double): Double;
begin
  Result := RadToDeg(Grad);
end;

function ATAN2(Y, X: Double): Double;
begin
  Result := ArcTan2(Y, X);
end;

function ASIN(X: Double): Double;
begin
  Result := ArcSin(X);
end;

function ACOS(X: Double): Double;
begin
  Result := ArcCos(X);
end;

procedure GetSunriseSunset(Date: TDateTime; Latitude, Longitude, TimeZone: Double; var Sunrise, Sunset: TDateTime);
var
  D2: TDateTime; // Date
  B3, // Lat
  B4, // Long
  B5: Double; // Time zone
  E2, F2, G2, I2, J2, K2, L2, M2, P2, Q2, R2, T2, U2, V2, W2, X2, Y2, Z2: Double;
begin
  D2 := Date;
  B3 := Latitude;
  B4 := Longitude;
  B5 := TimeZone;
  E2 := 0.1 / 24;
  F2 := D2+2415018.5+E2-B5/24;
  G2 := (F2-2451545)/36525;
  I2 := MOD_(280.46646+G2*(36000.76983 + G2*0.0003032),360);
  J2 := 357.52911+G2*(35999.05029 - 0.0001537*G2);
  K2 := 0.016708634-G2*(0.000042037+0.0000001267*G2);
  L2 := SIN(RADIANS(J2))*(1.914602-G2*(0.004817+0.000014*G2))+SIN(RADIANS(2*J2))*(0.019993-0.000101*G2)+SIN(RADIANS(3*J2))*0.000289;
  M2 := I2+L2;
  P2 := M2-0.00569-0.00478*SIN(RADIANS(125.04-1934.136*G2));
  Q2 := 23+(26+((21.448-G2*(46.815+G2*(0.00059-G2*0.001813))))/60)/60;
  R2 := Q2+0.00256*COS(RADIANS(125.04-1934.136*G2));
  T2 := DEGREES(ASIN(SIN(RADIANS(R2))*SIN(RADIANS(P2))));
  U2 := TAN(RADIANS(R2/2))*TAN(RADIANS(R2/2));
  V2 := 4*DEGREES(U2*SIN(2*RADIANS(I2))-2*K2*SIN(RADIANS(J2))+4*K2*U2*SIN(RADIANS(J2))*COS(2*RADIANS(I2))-0.5*U2*U2*SIN(4*RADIANS(I2))-1.25*K2*K2*SIN(2*RADIANS(J2)));
  W2 := DEGREES(ACOS(COS(RADIANS(90.833))/(COS(RADIANS(B3))*COS(RADIANS(T2)))-TAN(RADIANS(B3))*TAN(RADIANS(T2))));
  X2 := (720-4*B4-V2+B5*60)/1440;
  Y2 := X2-W2*4/1440;
  Z2 := X2+W2*4/1440;
  Sunrise := Y2;
  Sunset := Z2;
end;

const
  oleaut32 = 'oleaut32.dll';

{ VarDateFromUdate }
function VarDateFromUdate; external oleaut32 name 'VarDateFromUdate';
{ VarUdateFromDate }
function VarUdateFromDate; external oleaut32 name 'VarUdateFromDate';

end.
