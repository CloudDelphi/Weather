unit VarDates;

interface

uses Windows, ActiveX, SysUtils, GdipApi, GdipObj, DirectDraw, SysConst, DateUtils;

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

procedure WideGetLocaleMonthDayNames(DefaultLCID: Integer);

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

const
  oleaut32 = 'oleaut32.dll';

{ VarDateFromUdate }
function VarDateFromUdate; external oleaut32 name 'VarDateFromUdate';
{ VarUdateFromDate }
function VarUdateFromDate; external oleaut32 name 'VarUdateFromDate';

end.
