{*******************************************************}
{                                                       }
{       HavaCiva.dpr                                    }
{                                                       }
{                                                       }
{       Author  : A. Nasir Senturk                      }
{       Website : http://www.shenturk.com               }
{       E-Mail  : freedelphi@shenturk.com               }
{       Create  : 07.12.2006                            }
{       Update  : 21.03.2008                            }
{                                                       }
{*******************************************************}

program HavaCiva;

uses
  Windows,
  Forms,
  SysUtils,
  Main in 'Main.pas' {HavaCivaMainForm},
  TextUtil in 'TextUtil.pas',
  ConstDef in 'ConstDef.pas',
  TrayUtil in 'TrayUtil.pas',
  ShelApix in 'ShelApix.pas',
  OptnsDlg in 'OptnsDlg.pas' {OptionsForm},
  InfoWind in 'InfoWind.pas' {InfoTextForm},
  AboutDlg in 'AboutDlg.pas' {AboutForm},
  HbrntDlg in 'HbrntDlg.pas' {HibernateForm};

{$R *.res}
{.$R Resource.res}

var
  g_hMutex: THANDLE;
  g_hWndFound: HWND = INVALID_HANDLE_VALUE;
  g_szClassName: string = 'THavaCivaMainForm';
const
  { v1.50 }
  { g_strMutexName = 'globalUniqueMutexHandle_havaciva150'; }
  { v1.60 }
  g_strMutexName = 'globalUniqueMutexHandle_havaciva160';

function EnumFindProc(hWnd: THANDLE; lpszModule: PChar): BOOL stdcall;
var
  strClass,
  strModule: array[0..MAX_PATH] of Char;
  hInstance: HINST;
begin
  Result := True;
  FillChar( strClass, SizeOf(strClass), 0 );
  GetClassName( hWnd, strClass, MAX_PATH );
  if lstrcmp( strClass, PChar(g_szClassName) ) = 0 then
  begin
    FillChar( strModule, SizeOf(strModule), 0 );
    hInstance := GetWindowLong( hWnd, GWL_HINSTANCE );
    GetModuleFileName( hInstance, strModule, MAX_PATH );
    if lstrcmp( strModule, lpszModule ) = 0 then
    begin
      g_hWndFound := hWnd;
      Result := False;
    end;
  end;
end;

function CheckPrevInstance: BOOL;
var
  strModule: array[0..MAX_PATH] of Char;
  dwLastError: DWORD;
begin
  g_hMutex := CreateMutex( nil, False, g_strMutexName );
  dwLastError := GetLastError;
  FillChar( strModule, SizeOf(strModule), 0 );
  GetModuleFileName( MainInstance, strModule, MAX_PATH );
  OemToAnsi( strModule, strModule );
  EnumWindows( @EnumFindProc, Integer(@strModule) );
  Result := ( dwLastError = ERROR_ALREADY_EXISTS ) and
            ( g_hWndFound <> INVALID_HANDLE_VALUE );
end;

begin

  if not CheckWin32Version(5, 1) then // 5.1 = WindowsXP
  begin
    MessageBox(0, 'Üzgünüm! Bu program ancak Windows XP veya üzeri iþletim ' +
      'sistemlerinde çalýþabilmektedir.',
      'Hata', MB_OK or MB_ICONERROR);
    Exit;
  end;

  g_szClassName := THavaCivaMainForm.ClassName;
  if not CheckPrevInstance then
  begin
    Application.Initialize;
    SetWindowLong(Application.Handle, GWL_EXSTYLE,
      GetWindowLong(Application.Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
    Application.CreateForm(THavaCivaMainForm, HavaCivaMainForm);
  Application.Run;
  end
  else begin
    { v1.50 }
    if FindCmdLineSwitch('exit', ['/', '-'], True) then
      SendMessage( g_hWndFound, CM_EXITAPP, 0, 0 )
    else begin
      PostMessage( g_hWndFound, CM_RESTOREAPP, 0, 0 );
      SetForeGroundWindow( g_hWndFound );
    end;
  end;

  WaitForSingleObject( g_hMutex, 0 );
  if g_hMutex <> 0 then CloseHandle( g_hMutex );

end.
