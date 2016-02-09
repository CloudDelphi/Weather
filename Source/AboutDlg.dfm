object AboutForm: TAboutForm
  Left = 391
  Top = 260
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'About...'
  ClientHeight = 249
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = TURKISH_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseDown = FormMouseDown
  PixelsPerInch = 96
  TextHeight = 13
  object BackgrndLbl: TLabel
    Left = 4
    Top = 8
    Width = 321
    Height = 233
    AutoSize = False
    Caption = 'BackgrndLbl'
    Color = clTeal
    Enabled = False
    ParentColor = False
  end
  object HeaderTextLbl: TLabel
    Left = 24
    Top = 17
    Width = 109
    Height = 22
    Caption = 'HeaderTextLbl'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Trebuchet MS'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LogoImageLbl: TLabel
    Left = 0
    Top = 32
    Width = 73
    Height = 13
    AutoSize = False
    Caption = 'LogoImageLbl'
    Enabled = False
  end
  object ProductNameLbl: TLabel
    Left = 120
    Top = 48
    Width = 203
    Height = 34
    Caption = 'ProductNameLbl'#169
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Impact'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 120
    Top = 83
    Width = 32
    Height = 16
    Caption = 'Label1'
    Enabled = False
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Trebuchet MS'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 120
    Top = 137
    Width = 32
    Height = 16
    Cursor = crHandPoint
    Caption = 'Label1'
    Color = 49407
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Trebuchet MS'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    OnClick = Label2Click
  end
  object Label3: TLabel
    Left = 24
    Top = 157
    Width = 26
    Height = 11
    Caption = 'Label3'
    Enabled = False
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 125
    Top = 111
    Width = 28
    Height = 15
    Caption = 'Label4'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Trebuchet MS'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object CloseBtn: TButton
    Left = 289
    Top = 16
    Width = 18
    Height = 18
    Cursor = crHandPoint
    Hint = 'Kapat'
    Cancel = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = CloseBtnClick
  end
end
