object OptionsForm: TOptionsForm
  Left = 274
  Top = 136
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Ayarlar...'
  ClientHeight = 481
  ClientWidth = 448
  Color = clBtnFace
  Font.Charset = TURKISH_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 433
    Height = 433
    ActivePage = TabSheet2
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Genel'
      object GroupBox1: TGroupBox
        Left = 8
        Top = 7
        Width = 409
        Height = 258
        Caption = ' Program se'#231'enekleri '
        TabOrder = 0
        object Label3: TLabel
          Left = 43
          Top = 144
          Width = 106
          Height = 13
          Caption = '&G'#252'ncelleme periyodu: '
          FocusControl = ComboBox3
        end
        object Label7: TLabel
          Left = 224
          Top = 141
          Width = 98
          Height = 22
          Caption = 'Manuel g'#252'ncelleme i'#231'in pencerede '#231'ift t'#305'klat'#305'n'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Visible = False
          WordWrap = True
        end
        object Label16: TLabel
          Left = 40
          Top = 240
          Width = 208
          Height = 13
          Caption = 'Yeni s'#252'r'#252'm'#252' '#351'imdi kontrol etmek istiyorsan'#305'z'
          Visible = False
        end
        object Label17: TLabel
          Left = 290
          Top = 240
          Width = 31
          Height = 13
          Caption = 't'#305'klat'#305'n'
          Visible = False
        end
        object Label18: TLabel
          Left = 252
          Top = 240
          Width = 34
          Height = 13
          Cursor = crHandPoint
          Hint = 'Hava Civa! '#39'nin en son s'#252'r'#252'm'#252'n'#252' kullanin, daima g'#252'ncel kalin!'
          Caption = 'buraya'
          Color = clBtnFace
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          Visible = False
          OnMouseEnter = Label18MouseEnter
          OnMouseLeave = Label18MouseLeave
        end
        object CheckBox1: TCheckBox
          Left = 16
          Top = 24
          Width = 313
          Height = 17
          Caption = '&Windows her a'#231#305'ld'#305#287#305'nda Hava C'#305'va! otomatik olarak ba'#351'las'#305'n'
          TabOrder = 0
        end
        object CheckBox2: TCheckBox
          Left = 16
          Top = 120
          Width = 257
          Height = 17
          Caption = '&Hava durumu bilgilerini belirli aral'#305'klarla g'#252'ncelle'
          TabOrder = 1
          OnClick = CheckBox2Click
        end
        object ComboBox3: TComboBox
          Left = 155
          Top = 142
          Width = 65
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 2
          Text = '5 dk.'
          Items.Strings = (
            '5 dk.'
            '10 dk.'
            '15 dk.'
            '30 dk.'
            '1 saat'
            '2 saat')
        end
        object CheckBox3: TCheckBox
          Left = 16
          Top = 96
          Width = 249
          Height = 17
          Caption = '&Program simgesini sistem tepsisinde g'#246'ster'
          TabOrder = 3
        end
        object CheckBox4: TCheckBox
          Left = 16
          Top = 168
          Width = 177
          Height = 17
          Caption = 'P&encereyi daima en '#252'stte tut'
          TabOrder = 4
        end
        object CheckBox16: TCheckBox
          Left = 16
          Top = 216
          Width = 281
          Height = 17
          Caption = 'Hava &C'#305'va! '#39'n'#305'n yeni s'#252'r'#252'm'#252' '#231#305'kt'#305#287#305'nda bana haber ver'
          TabOrder = 5
        end
        object CheckBox17: TCheckBox
          Left = 16
          Top = 192
          Width = 377
          Height = 17
          Caption = '"&Solma" efektininin olu'#351'turulmas'#305'na izin ver (Fade effect)'
          TabOrder = 6
        end
        object CheckBox18: TCheckBox
          Left = 16
          Top = 48
          Width = 249
          Height = 17
          Caption = '&Masa'#252'st'#252'nde program'#305'n bir k'#305'sayolunu olu'#351'tur'
          TabOrder = 7
        end
        object CheckBox19: TCheckBox
          Left = 16
          Top = 72
          Width = 289
          Height = 17
          Caption = 'H'#305'zl'#305' &Ba'#351'lat b'#246'l'#252'm'#252'nde program'#305'n bir k'#305'sayolunu olu'#351'tur'
          TabOrder = 8
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'G'#246'r'#252'n'#252'm'
      ImageIndex = 1
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 409
        Height = 145
        Caption = ' Arka plan ve Donukluk '
        TabOrder = 0
        object Label5: TLabel
          Left = 24
          Top = 24
          Width = 77
          Height = 13
          Caption = '&Arka plan resmi:'
          FocusControl = ComboBox2
        end
        object ComboBox2: TComboBox
          Left = 112
          Top = 21
          Width = 121
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = '(yok)'
          OnChange = ComboBox2Change
          Items.Strings = (
            '(yok)'
            #199'ok ince cam'
            'Kal'#305'n cam'
            'S'#252'tl'#252' Kahve'
            'Renk belirle...')
        end
        object Panel1: TPanel
          Left = 24
          Top = 48
          Width = 209
          Height = 89
          BevelOuter = bvNone
          TabOrder = 1
          object Bevel1: TBevel
            Left = 88
            Top = 3
            Width = 31
            Height = 24
            Cursor = crHandPoint
          end
          object Label1: TLabel
            Left = 48
            Top = 8
            Width = 28
            Height = 13
            Caption = '&Renk:'
          end
          object Shape1: TShape
            Left = 89
            Top = 4
            Width = 30
            Height = 23
            Cursor = crHandPoint
            Pen.Style = psClear
            OnMouseDown = Shape1MouseDown
          end
          object Label2: TLabel
            Left = 25
            Top = 59
            Width = 51
            Height = 13
            Caption = '&Saydaml'#305'k:'
          end
          object Label6: TLabel
            Left = 168
            Top = 61
            Width = 29
            Height = 11
            Caption = '[0-255]'
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CheckBox5: TCheckBox
            Left = 88
            Top = 32
            Width = 121
            Height = 17
            Caption = '&Cam efekti kullan'
            TabOrder = 0
            OnClick = CheckBox5Click
          end
          object Edit1: TEdit
            Left = 88
            Top = 56
            Width = 57
            Height = 21
            TabOrder = 1
            Text = '20'
          end
          object UpDown1: TUpDown
            Left = 145
            Top = 56
            Width = 16
            Height = 21
            Associate = Edit1
            Max = 255
            Position = 20
            TabOrder = 2
          end
        end
        object CheckBox21: TCheckBox
          Left = 256
          Top = 24
          Width = 97
          Height = 17
          Caption = 'Keskin Yaz'#305' Bi'#231'imi'
          TabOrder = 2
        end
      end
      object GroupBox4: TGroupBox
        Left = 8
        Top = 160
        Width = 409
        Height = 145
        Caption = ' Bilgi Ekran'#305' '
        TabOrder = 1
        object CheckBox6: TCheckBox
          Left = 48
          Top = 64
          Width = 145
          Height = 17
          Caption = '&Bas'#305'n'#231
          TabOrder = 0
        end
        object CheckBox7: TCheckBox
          Left = 48
          Top = 80
          Width = 145
          Height = 17
          Caption = '&G'#252'ndo'#287'umu / G'#252'nbat'#305'm'#305
          TabOrder = 1
        end
        object CheckBox8: TCheckBox
          Left = 48
          Top = 96
          Width = 145
          Height = 17
          Caption = '&Enlem ve Boylam'
          TabOrder = 2
        end
        object CheckBox9: TCheckBox
          Left = 48
          Top = 112
          Width = 145
          Height = 17
          Caption = '&Tarih'
          TabOrder = 3
        end
        object CheckBox10: TCheckBox
          Left = 216
          Top = 48
          Width = 121
          Height = 17
          Caption = '&Hicri tarih'
          TabOrder = 4
        end
        object CheckBox11: TCheckBox
          Left = 216
          Top = 64
          Width = 121
          Height = 17
          Caption = 'R'#252'&zgar'
          TabOrder = 5
        end
        object CheckBox12: TCheckBox
          Left = 216
          Top = 80
          Width = 121
          Height = 17
          Caption = 'G'#246'r'#252#351' &mesafesi'
          TabOrder = 6
        end
        object CheckBox13: TCheckBox
          Left = 216
          Top = 96
          Width = 121
          Height = 17
          Caption = '&Nem oran'#305
          TabOrder = 7
        end
        object CheckBox14: TCheckBox
          Left = 216
          Top = 112
          Width = 121
          Height = 17
          Caption = 'Hissedilen s'#305'ca&kl'#305'k'
          TabOrder = 8
        end
        object CheckBox15: TCheckBox
          Left = 48
          Top = 48
          Width = 97
          Height = 17
          Caption = 'Hava &Durumu'
          TabOrder = 9
        end
        object CheckBox20: TCheckBox
          Left = 24
          Top = 24
          Width = 185
          Height = 17
          Caption = '&Bilgi ekran'#305'nda '#351'unlar'#305' g'#246'ster'
          TabOrder = 10
          OnClick = CheckBox20Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 312
        Width = 409
        Height = 81
        Caption = ' Yazi tipileri '
        TabOrder = 2
        Visible = False
        object Label11: TLabel
          Left = 24
          Top = 24
          Width = 90
          Height = 13
          Caption = 'Sicaklik g'#246'stergesi:'
        end
        object Label13: TLabel
          Left = 56
          Top = 48
          Width = 17
          Height = 13
          Caption = '31'#176
        end
        object Label14: TLabel
          Left = 144
          Top = 24
          Width = 45
          Height = 13
          Caption = 'Sehir adi:'
        end
        object Label15: TLabel
          Left = 144
          Top = 48
          Width = 37
          Height = 13
          Caption = 'Label15'
        end
        object Button8: TButton
          Left = 240
          Top = 24
          Width = 75
          Height = 25
          Caption = 'Button8'
          TabOrder = 0
          OnClick = Button8Click
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #350'ehirler'
      ImageIndex = 2
      object GroupBox5: TGroupBox
        Left = 8
        Top = 8
        Width = 409
        Height = 385
        Caption = ' Yer belirleme '
        TabOrder = 0
        object Label4: TLabel
          Left = 32
          Top = 48
          Width = 76
          Height = 13
          Caption = '&Bir '#351'ehir se'#231'iniz.'
        end
        object Label8: TLabel
          Left = 32
          Top = 120
          Width = 128
          Height = 13
          Caption = #350'&ehir ad'#305' veya Posta kodu:'
        end
        object Label9: TLabel
          Left = 32
          Top = 160
          Width = 80
          Height = 13
          Caption = 'A&rama sonu'#231'lar'#305':'
        end
        object Label10: TLabel
          Left = 120
          Top = 160
          Width = 3
          Height = 13
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RadioButton1: TRadioButton
          Left = 16
          Top = 24
          Width = 377
          Height = 17
          Caption = 
            '&T'#252'rkiye i'#231'inde bir yerle'#351'im biriminin hava durumunu '#246#287'renmek is' +
            'tiyorum.'
          Checked = True
          TabOrder = 0
          TabStop = True
          WordWrap = True
          OnClick = RadioButton1Click
        end
        object RadioButton2: TRadioButton
          Tag = 1
          Left = 16
          Top = 96
          Width = 369
          Height = 17
          Caption = '&D'#252'nya genelinde kapsaml'#305' bir arama yapmak istiyorum.'
          TabOrder = 1
          WordWrap = True
          OnClick = RadioButton2Click
        end
        object ListBox1: TListBox
          Left = 32
          Top = 176
          Width = 249
          Height = 89
          ItemHeight = 13
          TabOrder = 2
          OnClick = ListBox1Click
        end
        object Edit2: TEdit
          Left = 32
          Top = 136
          Width = 201
          Height = 21
          TabOrder = 3
          OnChange = Edit2Change
          OnEnter = Edit2Enter
          OnExit = Edit2Exit
        end
        object ComboBox1: TComboBox
          Left = 32
          Top = 65
          Width = 201
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 4
          OnChange = ComboBox1Change
        end
        object Button3: TButton
          Left = 240
          Top = 64
          Width = 23
          Height = 23
          Hint = 'Favorilerime ekle...'
          Caption = '+'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = Button3Click
        end
        object Button4: TButton
          Left = 288
          Top = 176
          Width = 23
          Height = 23
          Hint = 'Favorilerime ekle...'
          Caption = '+'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          OnClick = Button4Click
        end
        object Button5: TButton
          Left = 240
          Top = 135
          Width = 73
          Height = 23
          Caption = '&Ara'#351't'#305'r'
          TabOrder = 7
          OnClick = Button5Click
        end
        object ListBox2: TListBox
          Left = 32
          Top = 296
          Width = 249
          Height = 73
          ItemHeight = 13
          TabOrder = 8
          OnClick = ListBox2Click
        end
        object Button6: TButton
          Left = 288
          Top = 296
          Width = 75
          Height = 25
          Caption = '&Sil'
          TabOrder = 9
          OnClick = Button6Click
        end
        object Button7: TButton
          Left = 288
          Top = 328
          Width = 75
          Height = 25
          Caption = 'T'#252'm'#252'n'#252' Sil'
          TabOrder = 10
          OnClick = Button7Click
        end
        object RadioButton3: TRadioButton
          Tag = 2
          Left = 16
          Top = 272
          Width = 377
          Height = 17
          Caption = '&Favori '#351'ehirlerim listesinden birini se'#231'mek istiyorum.'
          TabOrder = 11
          OnClick = RadioButton3Click
        end
      end
    end
  end
  object Button1: TButton
    Left = 286
    Top = 448
    Width = 75
    Height = 25
    Caption = '&Kaydet'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 366
    Top = 448
    Width = 75
    Height = 25
    Cancel = True
    Caption = #304'pt&al'
    ModalResult = 2
    TabOrder = 2
  end
  object ColorDialog1: TColorDialog
    Left = 236
    Top = 8
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 24
    MaxFontSize = 26
    Options = [fdTrueTypeOnly, fdLimitSize, fdScalableOnly]
    Left = 272
    Top = 8
  end
end
