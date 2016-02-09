{*******************************************************}
{                                                       }
{       OptnsDlg.pas                                    }
{                                                       }
{                                                       }
{       Author  : A. Nasir Senturk                      }
{       Website : http://www.shenturk.com               }
{       E-Mail  : freedelphi@shenturk.com               }
{       Create  : 07.12.2006                            }
{       Update  : 21.03.2008                            }
{       Update  : 25.05.2013                            }
{       Update  : 25.11.2015                            }
{                                                       }
{*******************************************************}

unit OptnsDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, IniFiles, ExtCtrls;

type
  TOptionsForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    ComboBox2: TComboBox;
    GroupBox4: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    ComboBox3: TComboBox;
    Label3: TLabel;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label5: TLabel;
    ColorDialog1: TColorDialog;
    Panel1: TPanel;
    Label1: TLabel;
    CheckBox5: TCheckBox;
    Shape1: TShape;
    Bevel1: TBevel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label2: TLabel;
    Label6: TLabel;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    Label7: TLabel;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    GroupBox5: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    ListBox1: TListBox;
    Edit2: TEdit;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ComboBox1: TComboBox;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    ListBox2: TListBox;
    Button6: TButton;
    Button7: TButton;
    RadioButton3: TRadioButton;
    FontDialog1: TFontDialog;
    GroupBox2: TGroupBox;
    Button8: TButton;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    CheckBox20: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox5Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Label18MouseEnter(Sender: TObject);
    procedure Label18MouseLeave(Sender: TObject);
    procedure CheckBox20Click(Sender: TObject);
  private
    { Private declarations }
    FCityChanged: Boolean;
    Favorites: TStringList;
    CitiesTU: TStringList;
    CitiesFound: TStringList;
    TempFont: TFont;
    CityFont: TFont;
    OldOpacity: Byte;
    FavListChanged: Boolean;
    procedure Toggle(RadioButton: TRadioButton);
    procedure ToggleInfoText(Value: Boolean);
    procedure AddFavoriteItem(const Item, Value: string);
    procedure UpdateShellLinks;
  public
    { Public declarations }
    procedure LoadOptions;
    procedure SaveOptions;
    property CityChanged: Boolean read FCityChanged;
  end;

var
  OptionsForm: TOptionsForm;
  IniFile: TIniFile;
  
implementation

uses ConstDef, WinInet, ActiveX, ComObj, ShlObj, Main, Internet;

{$R *.dfm}

procedure TOptionsForm.FormCreate(Sender: TObject);
begin
  Favorites := TStringList.Create;
  CitiesTU := TStringList.Create;
  CitiesFound := TStringList.Create;
  TempFont := TFont.Create;
  CityFont := TFont.Create;
  TabSheet3.Caption := WideString(TabSheet3.Caption);
  Toggle(RadioButton1);
  LoadOptions;
end;

procedure TOptionsForm.ComboBox1Change(Sender: TObject);
begin
  FCityChanged := True;
  Button3.Enabled := ComboBox1.ItemIndex > -1;
end;

procedure TOptionsForm.LoadOptions;
begin

  IniFile.ReadSection(sCitiesTU, ComboBox1.Items);
  IniFile.ReadSectionValues(sCitiesTU, CitiesTU);

  IniFile.ReadSection(sFavorites, ListBox2.Items);
  ListBox2.Sorted := True;
  IniFile.ReadSectionValues(sFavorites, Favorites);
  //Favorites.Sort;
  Favorites.Sorted := True;

  ComboBox2.ItemIndex := IniFile.ReadInteger(sAppearance, sBackground, Ord(bsDarkGlass));
  CheckBox1.Checked := IniFile.ReadBool(sGeneral, sStartup, True);
  CheckBox18.Checked := IniFile.ReadBool(sGeneral, sDesktop, True);
  CheckBox19.Checked := IniFile.ReadBool(sGeneral, sQuickLunch, True);
  CheckBox2.Checked := IniFile.ReadBool(sGeneral, sAutoUpdate, True);
  ComboBox3.ItemIndex := IniFile.ReadInteger(sGeneral, sUpdatePeriod, 0);
  ComboBox1.ItemIndex := -1;
  //ComboBox1.ItemIndex := ComboBox1.Items.IndexOf('Istanbul');

  Label3.Enabled := CheckBox2.Checked;
  ComboBox3.Enabled := Label3.Enabled;
  CheckBox3.Checked := IniFile.ReadBool(sGeneral, sShowTrayIcon, True);
  CheckBox4.Checked := IniFile.ReadBool(sGeneral, sAlwaysTop, False);
  CheckBox16.Checked := IniFile.ReadBool(sGeneral, sCheckNewVersion, True);
  CheckBox17.Checked := IniFile.ReadBool(sGeneral, sFadeEffect, True);

  Shape1.Brush.Color := IniFile.ReadInteger(sAppearance, sBackColor, $808080);
  CheckBox5.Checked := IniFile.ReadBool(sAppearance, sGlassEffect, False);
  UpDown1.Position := IniFile.ReadInteger(sAppearance, sGlassOpacity, $F0);

  OldOpacity := UpDown1.Position;

  ComboBox2Change(Self);

  CheckBox6.Checked := IniFile.ReadBool(sAppearance, sShowPressure, True);
  CheckBox7.Checked := IniFile.ReadBool(sAppearance, sShowSunInfo, False);
  CheckBox8.Checked := IniFile.ReadBool(sAppearance, sShowSituation, False);
  CheckBox9.Checked := IniFile.ReadBool(sAppearance, sShowDate, False);

  CheckBox10.Checked := IniFile.ReadBool(sAppearance, sShowHijri, False);
  CheckBox11.Checked := IniFile.ReadBool(sAppearance, sShowWind, False);
  CheckBox12.Checked := IniFile.ReadBool(sAppearance, sShowVisibility, False);
  CheckBox13.Checked := IniFile.ReadBool(sAppearance, sShowHumidity, False);
  CheckBox14.Checked := IniFile.ReadBool(sAppearance, sShowChill, False);
  CheckBox15.Checked := IniFile.ReadBool(sAppearance, sShowWeatherText, True);
  CheckBox20.Checked := IniFile.ReadBool(sAppearance, sShowInfoText, True);
  ToggleInfoText(CheckBox20.Checked);

  TempFont.Name := IniFile.ReadString(sAppearance, sTempFontName, 'Arial');
  FontDialog1.Font.Assign(TempFont);

  CityFont.Name := IniFile.ReadString(sAppearance, sCityFontName, 'Arial');
  //FontDialog1.Font.Assign(TempFont);
  
  PageControl1.ActivePageIndex := IniFile.ReadInteger(sAppearance, sLastTabSheet, 0);

end;

procedure TOptionsForm.SaveOptions;
var
  CityName, CityID: string;
  I: Integer;
begin

  IniFile.WriteBool(sGeneral, sStartup, CheckBox1.Checked);
  IniFile.WriteBool(sGeneral, sDesktop, CheckBox18.Checked);
  IniFile.WriteBool(sGeneral, sQuickLunch, CheckBox19.Checked);
  IniFile.WriteBool(sGeneral, sAutoUpdate, CheckBox2.Checked);
  IniFile.WriteInteger(sGeneral, sUpdatePeriod, ComboBox3.ItemIndex);
  IniFile.WriteInteger(sAppearance, sBackground, ComboBox2.ItemIndex);

  if FCityChanged then begin
    CityName := '';
    CityID := '';
    if (RadioButton1.Checked) and (ComboBox1.ItemIndex <> -1) then
    begin
      CityName := ComboBox1.Items[ComboBox1.ItemIndex];
      CityID := CitiesTU.ValueFromIndex[ComboBox1.ItemIndex];
    end
    else if (RadioButton2.Checked) and (ListBox1.ItemIndex <> -1) then
    begin
      CityName := ListBox1.Items[ListBox1.ItemIndex];
      CityID := CitiesFound.ValueFromIndex[ListBox1.ItemIndex];
    end
    else if (RadioButton3.Checked) and (ListBox2.ItemIndex <> -1) then
    begin
      CityName := ListBox2.Items[ListBox2.ItemIndex];
      CityID := Favorites.ValueFromIndex[ListBox2.ItemIndex];
    end;

    if (CityName <> '') and (CityID <> '') then begin
      IniFile.WriteString(sLocation, sCityName, CityName);
      IniFile.WriteString(sLocation, sCityID, CityID);
    end;

  end;

  IniFile.WriteBool(sGeneral, sShowTrayIcon, CheckBox3.Checked);
  IniFile.WriteBool(sGeneral, sAlwaysTop, CheckBox4.Checked);
  IniFile.WriteBool(sGeneral, sCheckNewVersion, CheckBox16.Checked);
  IniFile.WriteBool(sGeneral, sFadeEffect, CheckBox17.Checked);

  IniFile.WriteInteger(sAppearance, sBackColor, Shape1.Brush.Color);
  IniFile.WriteBool(sAppearance, sGlassEffect, CheckBox5.Checked);
  IniFile.WriteInteger(sAppearance, sGlassOpacity, UpDown1.Position);

  IniFile.WriteBool(sAppearance, sShowPressure, CheckBox6.Checked);
  IniFile.WriteBool(sAppearance, sShowSunInfo, CheckBox7.Checked);
  IniFile.WriteBool(sAppearance, sShowSituation, CheckBox8.Checked);
  IniFile.WriteBool(sAppearance, sShowDate, CheckBox9.Checked);

  IniFile.WriteBool(sAppearance, sShowHijri, CheckBox10.Checked);
  IniFile.WriteBool(sAppearance, sShowWind, CheckBox11.Checked);
  IniFile.WriteBool(sAppearance, sShowVisibility, CheckBox12.Checked);
  IniFile.WriteBool(sAppearance, sShowHumidity, CheckBox13.Checked);
  IniFile.WriteBool(sAppearance, sShowChill, CheckBox14.Checked);
  IniFile.WriteBool(sAppearance, sShowWeatherText, CheckBox15.Checked);

  IniFile.WriteBool(sAppearance, sShowInfoText, CheckBox20.Checked);

  IniFile.WriteInteger(sAppearance, sLastTabSheet, PageControl1.ActivePageIndex);

  if FavListChanged then begin
    IniFile.EraseSection(sFavorites);
    for I := 0 to Favorites.Count - 1 do
    begin
      IniFile.WriteString(sFavorites,
        Favorites.Names[I],
        Favorites.ValueFromIndex[I]);
    end;
  end;
  IniFile.WriteString(sAppearance, sTempFontName, TempFont.Name);
  IniFile.WriteString(sAppearance, sCityFontName, CityFont.Name);

  UpdateShellLinks;
  
end;

procedure TOptionsForm.CheckBox2Click(Sender: TObject);
begin
  Label3.Enabled := CheckBox2.Checked;
  ComboBox3.Enabled := CheckBox2.Checked;
  Label7.Enabled := CheckBox2.Checked;
end;

procedure TOptionsForm.ComboBox2Change(Sender: TObject);
begin
  Panel1.Enabled := ComboBox2.ItemIndex = (ComboBox2.Items.Count - 1);
  Label1.Enabled := Panel1.Enabled;
  Bevel1.Enabled := Panel1.Enabled;
  Shape1.Enabled := Panel1.Enabled;
  CheckBox5.Enabled := Panel1.Enabled;
  CheckBox5Click(Sender);
end;

procedure TOptionsForm.Shape1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ColorDialog1.Color := Shape1.Brush.Color;
  if ColorDialog1.Execute then
  begin
    Shape1.Brush.Color := ColorDialog1.Color;
    //MainForm.UpdateLayered;
  end;
end;

procedure TOptionsForm.CheckBox5Click(Sender: TObject);
begin
  Label2.Enabled := CheckBox5.Enabled and CheckBox5.Checked;
  Edit1.Enabled := CheckBox5.Enabled and CheckBox5.Checked;
  UpDown1.Enabled := CheckBox5.Enabled and CheckBox5.Checked;
  Label6.Enabled := CheckBox5.Enabled and CheckBox5.Checked; 
end;

procedure TOptionsForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  Value: Integer;
begin
  if ModalResult = mrOK then
  begin
    Value := StrToIntDef(Edit1.Text, -1);
    if (Value < UpDown1.Min) or (Value > UpDown1.Max) then
    begin
      MessageDlg(Format('Saydamlýk %d-%d arasýnda olmalýdýr',
        [UpDown1.Min, UpDown1.Max]), mtError, [mbOk], 0);
      CanClose := False;
      Edit1.Text := IntToStr(OldOpacity);
      Edit1.SelectAll;
    end
    else begin
      SaveOptions;
      IniFile.UpdateFile;
    end;
  end;
end;

procedure TOptionsForm.RadioButton1Click(Sender: TObject);
begin
  Toggle(RadioButton1);
  ComboBox1.SetFocus;
end;

procedure TOptionsForm.RadioButton2Click(Sender: TObject);
begin
  Toggle(RadioButton2);
  Edit2.SetFocus;
end;

procedure TOptionsForm.Edit2Enter(Sender: TObject);
begin
  Button5.Default := True;
  Button1.Default := False;
end;

procedure TOptionsForm.Edit2Exit(Sender: TObject);
begin
  Button5.Default := False;
  Button1.Default := True;
end;

procedure TOptionsForm.Edit2Change(Sender: TObject);
begin
  Button5.Enabled := Edit2.Text <> '';
end;

procedure TOptionsForm.Button5Click(Sender: TObject);
var

  ResponseText: WideString;
  SaveCursor: TCursor;
  Cities: TStringList;
  DataCount: Integer;
  Request: TRequest;

  function ParseSearchResult: Integer;
  var
    xmlPage, ElemList, Item, Node: OleVariant;
    Index, Count: Integer;
    Ident, City, Region, Country, Text: WideString;
  begin
    Result := 0;
    xmlPage := CreateOleObject('Microsoft.XMLDOM');
    try
      xmlPage.LoadXml(ResponseText);
      ElemList := xmlPage.documentElement.selectNodes('/response/result/list/item');
      try
        if ElemList.Length > 0 then
        begin
          Count := ElemList.Length;
          Result := Count;
          for Index := 0 to Count - 1 do
          begin
            Item := ElemList.Item[Index];
            Node := Item.selectSingleNode('id');
            Ident := Node.Text;
            if Pos('|', Ident) > 0 then
              Ident := Copy(Ident, 1, Pos('|', Ident) - 1);
            Node := Item.selectSingleNode('city');
            City := Node.Text;
            Text := City;
            Node := Item.selectSingleNode('region');
            Region := Node.Text;
            Node := Item.selectSingleNode('countryname');
            Country := Node.Text;
            if (Region <> '') and (Region <> '*') then
              Text := Text + ', ' + Region;
            if Country <> '' then
              Text := Text + ', ' + Country;
            Text := UTF8Decode(Text);
            Cities.Add(Text);
            CitiesFound.Add(Text + '=' + Ident);
          end;
        end;
      finally
        ElemList := Unassigned;
      end;
    finally
      xmlPage := Unassigned;
    end;
  end;

begin
  ListBox1.Clear;
  //Button4.Enabled := ListBox1.ItemIndex <> -1;
  Button5.Enabled := False;
  SaveCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  Request := TRequest.Create;
  try
    Request.Method := 'POST';
    Request.Host := 'iphone-wu.apple.com';
    Request.URL := '/dgw?imei=' + AppGuidStr + '&apptype=weather&t=4';
    Request.ContentType := 'text/xml';
    Request.UserAgent := 'Apple iPhone v4.2.1 Weather v1.0.0.8C148';
    Request.Content :=
      '<?xml version="1.0" encoding="utf-8"?>' +
      '<request devtype="Apple iPhone v4.2.1" deployver="Apple iPhone v4.2.1" app="YGoiPhoneClient" appver="1.0.0.8C148" api="weather" apiver="1.0.0" acknotification="0000">' +
	    '<query id="3" timestamp="0" type="getlocationid">' +
		  '<phrase>' + UTF8Encode(Edit2.Text) + '</phrase>' +
		  '<language>tr_TR</language>' +
	    '</query>' +
      '</request>';
    Request.SendRequest(FInternet);
    ResponseText := Request.Response.Content;
    //InternetSearch;
  finally
    Request.Free;
    Screen.Cursor := SaveCursor;
    Button5.Enabled := True;
  end;
  if ResponseText <> '' then
  begin
    Cities := TStringList.Create;
    try
      CitiesFound.Clear;
      DataCount := ParseSearchResult;
      if DataCount > 0 then
        Label10.Caption := Format('%d yer bulundu.', [DataCount])
      else Label10.Caption := 'Herhangi bir yer bulunamadý.';
      ListBox1.Items.Assign(Cities);
    finally
      Cities.Free;
    end;
  end;
end;

procedure TOptionsForm.ListBox1Click(Sender: TObject);
begin
  Button4.Enabled := ListBox1.ItemIndex <> -1;
  FCityChanged := True;
end;

procedure TOptionsForm.Button3Click(Sender: TObject);
begin
  with ComboBox1 do
    if ItemIndex <> -1 then
      AddFavoriteItem(Items[ItemIndex], CitiesTU[ItemIndex]);
end;

procedure TOptionsForm.Toggle(RadioButton: TRadioButton);
begin

  Label4.Enabled := RadioButton.Tag = 0;
  ComboBox1.Enabled := RadioButton.Tag = 0;
  Button3.Enabled := (RadioButton.Tag = 0) and (ComboBox1.ItemIndex > -1);

  Label8.Enabled := RadioButton.Tag = 1;
  Edit2.Enabled := RadioButton.Tag = 1;
  Label9.Enabled := RadioButton.Tag = 1;
  Label10.Enabled := RadioButton.Tag = 1;
  ListBox1.Enabled := RadioButton.Tag = 1;
  Button4.Enabled := (RadioButton.Tag = 1) and (ListBox1.ItemIndex > -1);
  Button5.Enabled := (RadioButton.Tag = 1) and (Edit2.Text <> '');

  ListBox2.Enabled := RadioButton.Tag = 2;
  Button6.Enabled := (RadioButton.Tag = 2) and (ListBox2.ItemIndex > -1);
  Button7.Enabled := Button6.Enabled;

end;

procedure TOptionsForm.RadioButton3Click(Sender: TObject);
begin
  Toggle(RadioButton3);
end;

procedure TOptionsForm.Button4Click(Sender: TObject);
begin
  with ListBox1 do
    if ItemIndex <> -1 then
      AddFavoriteItem(Items[ItemIndex], CitiesFound[ItemIndex]);
end;

procedure TOptionsForm.ListBox2Click(Sender: TObject);
begin
  Button6.Enabled := ListBox2.ItemIndex <> -1;
  Button7.Enabled := ListBox2.ItemIndex <> -1;
  FCityChanged := True;
end;

procedure TOptionsForm.FormDestroy(Sender: TObject);
begin
  CitiesFound.Free;
  CitiesTU.Free;
  Favorites.Free;
  TempFont.Free;
  CityFont.Free;
end;

procedure TOptionsForm.Button6Click(Sender: TObject);
var
  Index: Integer;
begin
  if ListBox2.ItemIndex <> -1 then
  begin
    Index := ListBox2.ItemIndex;
    ListBox2.Items.Delete(Index);
    Favorites.Delete(Index);
    FavListChanged := True;
    if Index < ListBox2.Items.Count then ListBox2.ItemIndex := Index
    else ListBox2.ItemIndex := Index - 1;
  end;
end;

procedure TOptionsForm.Button7Click(Sender: TObject);
begin
  ListBox2.Clear;
  Favorites.Clear;
  FavListChanged := True;
end;

procedure TOptionsForm.AddFavoriteItem(const Item, Value: string);
begin
  if ListBox2.Items.IndexOf(Item) < 0 then
  begin
    ListBox2.Items.Add(Item); // Name
    Favorites.Add(Value); // Value
    FavListChanged := True;
  end
  else MessageDlg(Format('"%s" favorilerim listesine zaten eklenmiþ.', [Item]), mtError, [mbOK], 0);
end;

procedure TOptionsForm.Button8Click(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    TempFont.Assign(FontDialog1.Font);
    Label13.Font.Assign(TempFont);
  end;
end;

procedure TOptionsForm.UpdateShellLinks;
var
  DesktopFolder, StartupFolder, QuickLunchFolder: WideString;

  function GetModuleFileNameStr: string;
  begin
    SetLength(Result, MAX_PATH);
    GetModuleFileName( MainInstance, PChar(Result), MAX_PATH );
    Result := PChar(Result);
  end;

  procedure CreateShellLink(const ShellPath: WideString; const FilePath: string;
    IconIndex: Integer = 0);
  var
    psl: IShellLink;
    ppf: IPersistFile;
  begin
    psl := CreateComObject(CLSID_ShellLink) as IShellLink;
    ppf := psl as IPersistFile;
    psl.SetPath(PChar(FilePath));
    psl.SetWorkingDirectory(PChar(ExtractFilePath(FilePath)));
    psl.SetIconLocation(PChar(FilePath), IconIndex);
    ppf.Save(PWideChar(ShellPath), False);
  end;

  function GetSpecialFolderPath(nFolder: Integer): WideString;
  begin
    SetLength(Result, MAX_PATH);
    if SHGetSpecialFolderPathW(Self.Handle, PWideChar(Result), nFolder, False) then
      Result := PWideChar(Result)
    else Result := '';
  end;

  function GetDesktopPath: WideString;
  begin
    Result := GetSpecialFolderPath(CSIDL_DESKTOP);
  end;

  function GetStartupPath: WideString;
  begin
    Result := GetSpecialFolderPath(CSIDL_STARTUP);
  end;

  function GetQuickLunchPath: WideString;
  begin
    Result := GetSpecialFolderPath(CSIDL_APPDATA);
    if Result <> '' then
      Result := Result + '\Microsoft\Internet Explorer\Quick Launch';
  end;

begin

  DesktopFolder := GetDesktopPath;
  StartupFolder := GetStartupPath;
  QuickLunchFolder := GetQuickLunchPath;

  if CheckBox18.Checked then
  begin
    if not FileExists(DesktopFolder + sShellLinkName) then
      CreateShellLink(DesktopFolder + sShellLinkName, GetModuleFileNameStr);
  end
  else if FileExists(DesktopFolder + sShellLinkName) then
    DeleteFile(DesktopFolder + sShellLinkName);

  if CheckBox1.Checked then
  begin
    if not FileExists(StartupFolder + sShellLinkName) then
      CreateShellLink(StartupFolder + sShellLinkName, GetModuleFileNameStr);
  end
  else if FileExists(StartupFolder + sShellLinkName) then
    DeleteFile(StartupFolder + sShellLinkName);

  if CheckBox19.Checked then
  begin
    if not FileExists(QuickLunchFolder + sShellLinkName) then
      CreateShellLink(QuickLunchFolder + sShellLinkName, GetModuleFileNameStr);
  end
  else if FileExists(QuickLunchFolder + sShellLinkName) then
    DeleteFile(QuickLunchFolder + sShellLinkName);

end;

procedure TOptionsForm.Label18MouseEnter(Sender: TObject);
begin
  Label18.Font.Style := [fsUnderline];
end;

procedure TOptionsForm.Label18MouseLeave(Sender: TObject);
begin
  Label18.Font.Style := [];
end;

procedure TOptionsForm.CheckBox20Click(Sender: TObject);
begin
  ToggleInfoText(CheckBox20.Checked);
end;

procedure TOptionsForm.ToggleInfoText(Value: Boolean);
begin
  CheckBox6.Enabled := Value;
  CheckBox7.Enabled := Value;
  CheckBox8.Enabled := Value;
  CheckBox9.Enabled := Value;

  CheckBox10.Enabled := Value;
  CheckBox11.Enabled := Value;
  CheckBox12.Enabled := Value;
  CheckBox13.Enabled := Value;
  CheckBox14.Enabled := Value;
  CheckBox15.Enabled := Value;
end;

initialization
  SetCurrentDir(ExtractFileDir(ParamStr(0))); { v1.50 } { for Run->HavaCiva.exe}
  IniFile := TIniFile.Create(IniFilePath);

finalization
  IniFile.Free;

end.
