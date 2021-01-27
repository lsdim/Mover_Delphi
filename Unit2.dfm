object Form2: TForm2
  Left = 482
  Top = 103
  Caption = #1052#1072#1081#1089#1090#1077#1088' '#1085#1072#1083#1072#1096#1090#1091#1074#1072#1085#1100
  ClientHeight = 482
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    475
    482)
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 294
    Top = 454
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = BitBtn1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 393
    Top = 454
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    TabOrder = 1
    Kind = bkCancel
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 1
    Width = 474
    Height = 447
    ActivePage = TabSheet2
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = #1053#1072#1083#1072#1096#1090#1091#1074#1072#1085#1085#1103
      DesignSize = (
        466
        419)
      object Bevel5: TBevel
        Left = 4
        Top = 0
        Width = 359
        Height = 201
        Anchors = [akLeft, akTop, akRight]
        Shape = bsFrame
      end
      object Label2: TLabel
        Left = 8
        Top = 3
        Width = 132
        Height = 13
        Caption = #1055#1072#1087#1082#1072', '#1097#1086' '#1087#1077#1088#1077#1074#1110#1088#1103#1108#1090#1100#1089#1103':'
      end
      object Label3: TLabel
        Left = 8
        Top = 46
        Width = 49
        Height = 13
        Caption = #1054#1087#1077#1088#1072#1094#1110#1103':'
      end
      object SpeedButton1: TSpeedButton
        Left = 334
        Top = 174
        Width = 23
        Height = 22
        Anchors = [akTop, akRight]
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = SpeedButton1Click
        ExplicitLeft = 336
      end
      object Label5: TLabel
        Left = 163
        Top = 173
        Width = 13
        Height = 24
        Hint = '<name> - '#1085#1072#1079#1074#1072' '#1073#1077#1079' '#1088#1086#1079#1096#1080#1088#1077#1085#1085#1103', <ext> - '#1088#1086#1079#1096#1080#1088#1077#1085#1085#1103' '#1092#1072#1081#1083#1091
        Caption = '>'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel2: TBevel
        Left = 7
        Top = 85
        Width = 352
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ExplicitWidth = 354
      end
      object Bevel6: TBevel
        Left = 367
        Top = 131
        Width = 98
        Height = 20
        Anchors = [akTop, akRight]
        Shape = bsFrame
      end
      object Bevel8: TBevel
        Left = 367
        Top = 345
        Width = 98
        Height = 74
        Anchors = [akTop, akRight]
        Shape = bsFrame
      end
      object ComboBox1: TComboBox
        Left = 8
        Top = 19
        Width = 351
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        TabOrder = 0
        Text = '0'
      end
      object ComboBox2: TComboBox
        Left = 8
        Top = 62
        Width = 351
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DropDownCount = 9
        ItemHeight = 13
        TabOrder = 1
        Text = '0 - '#1085#1110#1095#1086#1075#1086' '#1085#1077' '#1088#1086#1073#1080#1090#1080
        OnChange = ComboBox2Change
        Items.Strings = (
          '0 - '#1085#1110#1095#1086#1075#1086' '#1085#1077' '#1088#1086#1073#1080#1090#1080
          '1 - '#1082#1086#1087#1110#1102#1074#1072#1090#1080
          '2 - '#1087#1077#1088#1077#1084#1110#1089#1090#1080#1090#1080
          '3 - '#1074#1080#1076#1072#1083#1080#1090#1080
          '4 - '#1079#1072#1087#1091#1089#1090#1080#1090#1080' '#1092#1072#1081#1083
          '5 - '#1074#1080#1082#1086#1085#1072#1090#1080' '#1082#1086#1084#1072#1085#1076#1085#1080#1081' '#1088#1103#1076#1086#1082
          '6 - '#1087#1086#1082#1072#1079#1072#1090#1080' '#1087#1086#1074#1110#1076#1086#1084#1083#1077#1085#1085#1103' '
          '7 - '#1087#1077#1088#1077#1081#1084#1077#1085#1091#1074#1072#1090#1080
          '8 - '#1074#1080#1076#1072#1083#1080#1090#1080#1090' '#1074#1089#1110' '#1082#1088#1110#1084' '#1074#1082#1072#1079#1072#1085#1080#1093)
      end
      object LabeledEdit1: TLabeledEdit
        Left = 8
        Top = 131
        Width = 351
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = #1052#1072#1089#1082#1072':'
        TabOrder = 2
      end
      object LabeledEdit2: TLabeledEdit
        Left = 8
        Top = 175
        Width = 151
        Height = 21
        Hint = '<*> - '#1087#1086#1074#1085#1072' '#1085#1072#1079#1074#1072' '#1092#1072#1081#1083#1091' <*.> - '#1083#1080#1096#1077' '#1110#1084#39#1103' <.*> - '#1083#1080#1096#1077' '#1088#1086#1079#1088#1080#1088#1077#1085#1085#1103
        Anchors = [akLeft, akTop, akRight]
        EditLabel.Width = 29
        EditLabel.Height = 13
        EditLabel.Caption = #1064#1083#1103#1093':'
        TabOrder = 3
      end
      object GroupBox1: TGroupBox
        Left = 4
        Top = 201
        Width = 359
        Height = 217
        Anchors = [akTop]
        Caption = #1056#1086#1079#1082#1083#1072#1076' '#1074#1080#1082#1086#1085#1103#1085#1085#1103':'
        TabOrder = 4
        DesignSize = (
          359
          217)
        object Label1: TLabel
          Left = 221
          Top = 74
          Width = 9
          Height = 13
          Caption = #1079':'
        end
        object Label4: TLabel
          Left = 218
          Top = 111
          Width = 15
          Height = 13
          Caption = #1087#1086':'
        end
        object Bevel1: TBevel
          Left = 167
          Top = 6
          Width = 9
          Height = 209
          Anchors = [akTop]
          Shape = bsRightLine
        end
        object ComboBox3: TComboBox
          Left = 8
          Top = 20
          Width = 145
          Height = 21
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = #1047#1072#1074#1078#1076#1080
          OnChange = ComboBox3Change
          Items.Strings = (
            #1047#1072#1074#1078#1076#1080
            #1054#1082#1088#1077#1084#1110' '#1076#1085#1110)
        end
        object CheckBox1: TCheckBox
          Left = 16
          Top = 48
          Width = 97
          Height = 17
          Caption = #1055#1086#1085#1077#1076#1110#1083#1086#1082
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object CheckBox2: TCheckBox
          Left = 16
          Top = 72
          Width = 97
          Height = 17
          Caption = #1042#1110#1074#1090#1086#1088#1086#1082
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object CheckBox3: TCheckBox
          Left = 16
          Top = 96
          Width = 97
          Height = 17
          Caption = #1057#1077#1088#1077#1076#1072
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object CheckBox4: TCheckBox
          Left = 16
          Top = 120
          Width = 97
          Height = 17
          Caption = #1063#1077#1090#1074#1077#1088
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object CheckBox5: TCheckBox
          Left = 16
          Top = 144
          Width = 97
          Height = 17
          Caption = #1055#39#1103#1090#1085#1080#1094#1103
          Checked = True
          State = cbChecked
          TabOrder = 5
        end
        object CheckBox6: TCheckBox
          Left = 16
          Top = 168
          Width = 97
          Height = 17
          Caption = #1057#1091#1073#1086#1090#1072
          Checked = True
          State = cbChecked
          TabOrder = 6
        end
        object CheckBox7: TCheckBox
          Left = 16
          Top = 192
          Width = 97
          Height = 17
          Caption = #1053#1077#1076#1110#1083#1103
          Checked = True
          State = cbChecked
          TabOrder = 7
        end
        object Tim1: TDateTimePicker
          Left = 239
          Top = 66
          Width = 81
          Height = 21
          Date = 41603.333333333340000000
          Format = 'HH:mm'
          Time = 41603.333333333340000000
          Kind = dtkTime
          TabOrder = 8
          OnChange = Tim1Change
        end
        object Tim2: TDateTimePicker
          Left = 239
          Top = 103
          Width = 81
          Height = 21
          Date = 41603.333333333340000000
          Format = 'HH:mm'
          Time = 41603.333333333340000000
          Kind = dtkTime
          TabOrder = 9
          OnChange = Tim2Change
        end
        object ComboBox4: TComboBox
          Left = 200
          Top = 20
          Width = 145
          Height = 21
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 10
          Text = #1047#1072#1074#1078#1076#1080
          OnChange = ComboBox4Change
          Items.Strings = (
            #1047#1072#1074#1078#1076#1080
            #1054#1076#1080#1085' '#1088#1072#1079
            #1055#1088#1086#1090#1103#1075#1086#1084' '#1087#1077#1088#1110#1086#1076#1091)
        end
      end
      object LabeledEdit3: TLabeledEdit
        Left = 177
        Top = 174
        Width = 151
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        EditLabel.Width = 62
        EditLabel.Height = 13
        EditLabel.Caption = #1053#1086#1074#1072' '#1085#1072#1079#1074#1072':'
        TabOrder = 5
      end
      object CheckBox8: TCheckBox
        Left = 10
        Top = 87
        Width = 198
        Height = 17
        Caption = #1042#1080#1082#1086#1088#1080#1089#1090#1086#1074#1091#1074#1072#1090#1080' '#1087#1077#1088#1077#1076#1072#1095#1091' '#1087#1086' TCP'
        Enabled = False
        TabOrder = 6
        OnClick = CheckBox8Click
      end
      object RadioGroup1: TRadioGroup
        Left = 367
        Top = 56
        Width = 98
        Height = 64
        Anchors = [akTop, akRight]
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1080':'
        ItemIndex = 0
        Items.Strings = (
          #1030#1079' '#1079#1072#1084#1110#1085#1086#1102
          #1041#1077#1079' '#1079#1072#1084#1110#1085#1080)
        TabOrder = 7
      end
      object GroupBox2: TGroupBox
        Left = 367
        Top = 157
        Width = 98
        Height = 44
        Anchors = [akTop, akRight]
        Caption = 'IP '#1072#1076#1088#1077#1089#1072':'
        TabOrder = 8
        DesignSize = (
          98
          44)
        object ip1: TJvIPAddress
          Left = 3
          Top = 17
          Width = 91
          Height = 21
          AddressValues.Address = 0
          AddressValues.Value1 = 0
          AddressValues.Value2 = 0
          AddressValues.Value3 = 0
          AddressValues.Value4 = 0
          Anchors = [akTop, akRight]
          ParentColor = False
          TabOrder = 0
          Text = '0.0.0.0'
        end
      end
      object RG2: TRadioGroup
        Left = 367
        Top = -1
        Width = 98
        Height = 56
        Anchors = [akTop, akRight]
        Caption = #1055#1110#1076#1082#1072#1090#1072#1083#1086#1075#1080':'
        ItemIndex = 0
        Items.Strings = (
          #1053#1045' '#1074#1082#1083#1102#1095#1072#1090#1080
          #1042#1082#1083#1102#1095#1072#1090#1080)
        TabOrder = 9
      end
      object chFTP: TCheckBox
        Left = 236
        Top = 87
        Width = 89
        Height = 17
        Caption = 'FTP'
        Enabled = False
        TabOrder = 10
        OnClick = chFTPClick
      end
      object GroupBox3: TGroupBox
        Left = 369
        Top = 201
        Width = 98
        Height = 138
        Anchors = [akTop, akRight]
        Caption = 'FTP Host:'
        TabOrder = 11
        DesignSize = (
          98
          138)
        object ePass: TLabeledEdit
          Left = 3
          Top = 103
          Width = 91
          Height = 21
          Anchors = [akTop, akRight]
          EditLabel.Width = 49
          EditLabel.Height = 13
          EditLabel.Caption = 'Password:'
          Enabled = False
          TabOrder = 2
        end
        object eUser: TLabeledEdit
          Left = 3
          Top = 66
          Width = 91
          Height = 21
          Anchors = [akTop, akRight]
          EditLabel.Width = 25
          EditLabel.Height = 13
          EditLabel.Caption = 'User:'
          Enabled = False
          TabOrder = 1
        end
        object eHost: TLabeledEdit
          Left = 3
          Top = 20
          Width = 91
          Height = 21
          EditLabel.Width = 3
          EditLabel.Height = 13
          TabOrder = 0
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1060#1072#1081#1083#1080' '#1087#1086' TCP'
      ImageIndex = 1
      object Splitter1: TSplitter
        Left = 0
        Top = 211
        Width = 466
        Height = 3
        Cursor = crVSplit
        Align = alTop
        ExplicitTop = 217
        ExplicitWidth = 290
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 466
        Height = 211
        Align = alTop
        TabOrder = 0
        DesignSize = (
          466
          211)
        object Label6: TLabel
          Left = 8
          Top = 1
          Width = 116
          Height = 13
          Caption = #1042#1110#1076#1087#1088#1072#1074#1083#1077#1085#1110' '#1092#1072#1081#1083#1080':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Button1: TButton
          Tag = 1
          Left = 4
          Top = 180
          Width = 85
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = #1055#1077#1088#1077#1074'. '#1079#1074#39#1103#1079#1086#1082
          Enabled = False
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 96
          Top = 180
          Width = 85
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = #1042#1080#1076#1072#1083#1080#1090#1080
          Enabled = False
          TabOrder = 1
          OnClick = Button2Click
        end
        object SG1: TStringGrid
          Left = 2
          Top = 16
          Width = 463
          Height = 161
          Anchors = [akLeft, akTop, akRight, akBottom]
          ColCount = 6
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
          PopupMenu = PopupMenu1
          TabOrder = 2
          OnDrawCell = SG1DrawCell
        end
        object Button3: TButton
          Left = 189
          Top = 180
          Width = 85
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = #1053#1077#1072#1082#1090#1091#1072#1083#1100#1085#1110
          Enabled = False
          TabOrder = 3
          OnClick = Button3Click
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 214
        Width = 466
        Height = 205
        Align = alClient
        TabOrder = 1
        DesignSize = (
          466
          205)
        object Label7: TLabel
          Left = 8
          Top = 1
          Width = 101
          Height = 13
          Caption = #1054#1090#1088#1080#1084#1072#1085#1110' '#1092#1072#1081#1083#1080':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object SG2: TStringGrid
          Left = 2
          Top = 16
          Width = 463
          Height = 154
          Anchors = [akLeft, akTop, akRight, akBottom]
          ColCount = 6
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
          TabOrder = 0
          OnDrawCell = SG2DrawCell
          RowHeights = (
            24
            24
            24
            24
            24)
        end
        object Button4: TButton
          Left = 96
          Top = 176
          Width = 85
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = #1042#1080#1076#1072#1083#1080#1090#1080
          Enabled = False
          TabOrder = 1
          OnClick = Button4Click
        end
        object Button5: TButton
          Tag = 2
          Left = 4
          Top = 176
          Width = 85
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = #1055#1077#1088#1077#1074'. '#1079#1074#39#1103#1079#1086#1082
          Enabled = False
          TabOrder = 2
          OnClick = Button1Click
        end
      end
    end
  end
  object XPManifest1: TXPManifest
    Left = 272
    Top = 192
  end
  object PopupMenu1: TPopupMenu
    Left = 304
    Top = 192
    object N1: TMenuItem
      Caption = #1055#1086#1082#1072#1079#1072#1090#1080
      OnClick = N1Click
    end
  end
end
