object HavaCivaMainForm: THavaCivaMainForm
  Left = 363
  Top = 206
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'HavaCivaMainForm'
  ClientHeight = 248
  ClientWidth = 233
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = ShortPopup
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = RefreshActionExecute
  OnDestroy = FormDestroy
  OnMouseDown = FormMouseDown
  PixelsPerInch = 96
  TextHeight = 13
  object WeatherLbl: TLabel
    Left = 0
    Top = 0
    Width = 174
    Height = 149
    AutoSize = False
    Caption = 'WeatherLbl'
    Color = clSilver
    Enabled = False
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
  end
  object BackgrndLbl: TLabel
    Left = 30
    Top = 47
    Width = 195
    Height = 194
    AutoSize = False
    Caption = 'BackgrndLbl'
    Color = clOlive
    Enabled = False
    ParentColor = False
  end
  object TemperatureLbl: TLabel
    Left = 144
    Top = 56
    Width = 78
    Height = 37
    Alignment = taRightJustify
    AutoSize = False
    Caption = '31'
    Color = clRed
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object CityNameLbl: TLabel
    Left = 163
    Top = 93
    Width = 51
    Height = 16
    Alignment = taRightJustify
    Caption = 'Ystanbul'
    Color = clTeal
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object InfoTextLbl: TLabel
    Left = 36
    Top = 230
    Width = 55
    Height = 13
    Caption = 'InfoTextLbl'
    Enabled = False
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object GridLbl: TLabel
    Left = 36
    Top = 112
    Width = 191
    Height = 113
    Alignment = taCenter
    AutoSize = False
    Caption = 'GridLbl'
    Color = clBackground
    Enabled = False
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Day1Lbl: TLabel
    Left = 36
    Top = 126
    Width = 61
    Height = 34
    Alignment = taCenter
    AutoSize = False
    Caption = 'Day1Lbl'
    Color = clBlue
    Enabled = False
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object Day2Lbl: TLabel
    Left = 98
    Top = 126
    Width = 61
    Height = 34
    Alignment = taCenter
    AutoSize = False
    Caption = 'Day2Lbl'
    Color = clBlue
    Enabled = False
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object Day3Lbl: TLabel
    Left = 160
    Top = 126
    Width = 61
    Height = 34
    Alignment = taCenter
    AutoSize = False
    Caption = 'Day3Lbl'
    Color = clBlue
    Enabled = False
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object Day4Lbl: TLabel
    Left = 36
    Top = 183
    Width = 61
    Height = 34
    Alignment = taCenter
    AutoSize = False
    Caption = 'Day4Lbl'
    Color = clBlue
    Enabled = False
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object Day5Lbl: TLabel
    Left = 98
    Top = 183
    Width = 61
    Height = 34
    Alignment = taCenter
    AutoSize = False
    Caption = 'Day5Lbl'
    Color = clBlue
    Enabled = False
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object MoonLbl: TLabel
    Left = 160
    Top = 183
    Width = 61
    Height = 34
    Alignment = taCenter
    AutoSize = False
    Caption = 'MoonLbl'
    Color = clBlue
    Enabled = False
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Layout = tlCenter
  end
  object ExitBtn: TButton
    Left = 194
    Top = 41
    Width = 18
    Height = 18
    Cursor = crHandPoint
    Action = ExitAction
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object HideBtn: TButton
    Left = 177
    Top = 41
    Width = 18
    Height = 18
    Cursor = crHandPoint
    Action = HideAction
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Visible = False
  end
  object OptionsBtn: TButton
    Left = 118
    Top = 41
    Width = 58
    Height = 18
    Cursor = crHandPoint
    Hint = #214'zelle'#351'tirmek i'#231'in t'#305'klat'#305'n...'
    Action = OptionsAction
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object TrayPopup: TPopupMenu
    AutoHotkeys = maManual
    OnPopup = TrayPopupPopup
    Left = 16
    Top = 128
    object TrayAboutMenu: TMenuItem
      Action = AboutAction
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object TrayAddLocMenu: TMenuItem
      Action = AddLocAction
    end
    object TrayRefreshMenu: TMenuItem
      Action = RefreshAction
    end
    object TrayShowInfoMenu: TMenuItem
      Action = ShowInfoAction
    end
    object TrayOptionsMenu: TMenuItem
      Action = OptionsAction
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object Kk1: TMenuItem
      Action = MiniAction
      AutoCheck = True
    end
    object Orta1: TMenuItem
      Action = MidiAction
      AutoCheck = True
    end
    object Byk1: TMenuItem
      Action = MaxiAction
      AutoCheck = True
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object KUykusu1: TMenuItem
      Action = HibernateAction
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object TrayFavoritesMenu: TMenuItem
      Caption = 'Favori '#350'ehirlerim'
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object TrayShowMenu: TMenuItem
      Action = ShowAction
    end
    object TrayHideMenu: TMenuItem
      Action = HideAction
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object TrayExitMenu: TMenuItem
      Action = ExitAction
    end
  end
  object CheckTimer: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = CheckTimerTimer
    Left = 16
    Top = 40
  end
  object XPManifest1: TXPManifest
    Left = 16
    Top = 168
  end
  object VersionTimer: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = VersionTimerTimer
    Left = 16
    Top = 80
  end
  object LoadedTimer: TTimer
    Enabled = False
    Interval = 250
    OnTimer = LoadedTimerTimer
    Left = 80
    Top = 8
  end
  object ShortPopup: TPopupMenu
    AutoHotkeys = maManual
    OnPopup = ShortPopupPopup
    Left = 16
    Top = 8
    object AboutMenu: TMenuItem
      Action = AboutAction
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object AddLocMenu: TMenuItem
      Action = AddLocAction
    end
    object RefreshMenu: TMenuItem
      Action = RefreshAction
    end
    object ShowInfoMenu: TMenuItem
      Action = ShowInfoAction
    end
    object OptionsMenu: TMenuItem
      Action = OptionsAction
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object MiniAction1: TMenuItem
      Action = MiniAction
      AutoCheck = True
    end
    object MidiAction1: TMenuItem
      Action = MidiAction
      AutoCheck = True
    end
    object MaxiAction1: TMenuItem
      Action = MaxiAction
      AutoCheck = True
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object HibernateAction1: TMenuItem
      Action = HibernateAction
    end
    object KeskinYaziBicimi1: TMenuItem
      Action = AntialiasAction
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object FavoritesMenu: TMenuItem
      Caption = '&Favori '#350'ehirlerim'
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object ExitMainMenu: TMenuItem
      Action = ExitAction
    end
  end
  object MainActionList: TActionList
    Left = 48
    Top = 8
    object ExitAction: TAction
      Caption = '&Kapat'
      Hint = 'Kapat'
      OnExecute = ExitActionExecute
    end
    object ShowInfoAction: TAction
      Caption = '&Bilgi Ekran'#305
      OnExecute = ShowInfoActionExecute
    end
    object OptionsAction: TAction
      Caption = '&Ayarlar...'
      Hint = #214'zellestirmek i'#231'in tiklatin...'
      OnExecute = OptionsActionExecute
    end
    object HideAction: TAction
      Caption = 'Gi&zle'
      Hint = 'Gizle'
      OnExecute = HideActionExecute
    end
    object ShowAction: TAction
      Caption = '&G'#246'ster'
      OnExecute = ShowActionExecute
    end
    object RefreshAction: TAction
      Caption = '&Tazele'
      OnExecute = RefreshActionExecute
    end
    object AboutAction: TAction
      Caption = '&Hava C'#305'va! Hakk'#305'nda...'
      OnExecute = AboutActionExecute
    end
    object AddLocAction: TAction
      Caption = '&Yeni Yer Ekle...'
      OnExecute = AddLocActionExecute
    end
    object MiniAction: TAction
      AutoCheck = True
      Caption = 'K'#252#231#252'k'
      GroupIndex = 1
      OnExecute = MiniActionExecute
    end
    object MidiAction: TAction
      AutoCheck = True
      Caption = 'Orta'
      GroupIndex = 1
      OnExecute = MidiActionExecute
    end
    object MaxiAction: TAction
      AutoCheck = True
      Caption = 'B'#252'y'#252'k'
      GroupIndex = 1
      OnExecute = MaxiActionExecute
    end
    object HibernateAction: TAction
      Caption = 'K'#305#351' Uykusu'
      OnExecute = HibernateActionExecute
    end
    object AntialiasAction: TAction
      Caption = 'Keskin Yaz'#305' Bi'#231'imi'
      OnExecute = AntialiasActionExecute
    end
  end
  object MouseTimer: TTimer
    Enabled = False
    Interval = 200
    OnTimer = MouseTimerTimer
    Left = 112
    Top = 8
  end
end
