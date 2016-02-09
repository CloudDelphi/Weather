object HibernateForm: THibernateForm
  Left = 353
  Top = 241
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'K'#305#351' Uykusu i'#231'in uyar'#305
  ClientHeight = 202
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = TURKISH_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    Left = 10
    Top = 7
    Width = 343
    Height = 154
    Caption = ' K'#305#351' Uykusu '
    TabOrder = 0
    object Label1: TStaticText
      Left = 16
      Top = 24
      Width = 313
      Height = 57
      AutoSize = False
      Caption = 
        'Se'#231'ti'#287'iniz pencereyi K'#305#351' Uykusu moduna ge'#231'irmek '#252'zeresiniz. Bu d' +
        'urumda pencereniz yar'#305' saydam bir g'#246'r'#252'n'#252'm halini alarak fare ile' +
        ' yap'#305'lacak t'#252'm olaylara ge'#231'irgen davranacakt'#305'r. Pencerenizi tekr' +
        'ar eski haline getirmek i'#231'in '#351'u ad'#305'mlar'#305' izleyin:'
      TabOrder = 0
    end
    object Label2: TStaticText
      Left = 32
      Top = 88
      Width = 302
      Height = 17
      Caption = '1. Farenizi, K'#305#351' Uykusunda bulunan pencerenin '#252'zerine getirin.'
      TabOrder = 1
    end
    object Label3: TStaticText
      Left = 32
      Top = 104
      Width = 223
      Height = 17
      Caption = '2. Klavyeden CTRL tu'#351'una k'#305'sa bir s'#252're bas'#305'n.'
      TabOrder = 2
    end
    object CheckBox1: TCheckBox
      Left = 96
      Top = 128
      Width = 161
      Height = 17
      Caption = 'Bu uyar'#305'y'#305' bir daha g'#246'sterme'
      TabOrder = 3
    end
  end
  object OkBtn: TButton
    Left = 144
    Top = 168
    Width = 75
    Height = 25
    Caption = '&Kapat'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
end
