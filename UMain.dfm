object MainForm: TMainForm
  Left = 486
  Top = 93
  VertScrollBar.Visible = False
  Caption = #1053#1072#1083#1072#1096#1090#1091#1074#1072#1085#1085#1103
  ClientHeight = 513
  ClientWidth = 509
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 257
    Width = 509
    Height = 2
    Cursor = crVSplit
    Align = alTop
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 509
    Height = 257
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    DesignSize = (
      509
      257)
    object SpeedButton1: TSpeedButton
      Left = 39
      Top = 215
      Width = 23
      Height = 22
      Anchors = [akLeft, akBottom]
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object Label1: TLabel
      Left = 113
      Top = 233
      Width = 61
      Height = 16
      Anchors = [akLeft, akBottom]
      Caption = #1030#1085#1090#1077#1088#1074#1072#1083':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 223
      Top = 233
      Width = 22
      Height = 16
      Anchors = [akLeft, akBottom]
      Caption = #1089#1077#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 262
      Top = 225
      Width = 2
      Height = 33
      Anchors = [akLeft, akBottom]
    end
    object Bevel2: TBevel
      Left = 96
      Top = 225
      Width = 2
      Height = 33
      Anchors = [akLeft, akBottom]
    end
    object SpeedButton2: TSpeedButton
      Left = 51
      Top = 150
      Width = 23
      Height = 22
      Anchors = [akLeft, akBottom]
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
      OnClick = SpeedButton2Click
    end
    object Bevel5: TBevel
      Left = 445
      Top = 224
      Width = 2
      Height = 33
      Anchors = [akLeft, akBottom]
    end
    object G1: TGauge
      Left = 2
      Top = 225
      Width = 444
      Height = 31
      Anchors = [akLeft, akRight, akBottom]
      Progress = 0
      Visible = False
    end
    object edit1: TEdit
      Left = 179
      Top = 231
      Width = 41
      Height = 21
      Anchors = [akLeft, akBottom]
      TabOrder = 0
      Text = '100'
    end
    object CheckBox2: TCheckBox
      Left = 288
      Top = 233
      Width = 155
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = #1055#1086#1082#1072#1079#1091#1074#1072#1090#1080' '#1087#1086#1074#1110#1076#1086#1084#1083#1077#1085#1085#1103
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object Button2: TButton
      Left = 48
      Top = 229
      Width = 25
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 8
      Top = 229
      Width = 25
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = Button1Click
    end
    object SG1: TStringGrid
      Left = 2
      Top = 4
      Width = 505
      Height = 221
      Anchors = [akLeft, akTop, akRight, akBottom]
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
      PopupMenu = PopupMenu2
      TabOrder = 3
      OnClick = SG1Click
      OnDblClick = SG1DblClick
      OnDrawCell = SG1DrawCell
      OnKeyPress = SG1KeyPress
      OnSelectCell = SG1SelectCell
      ColWidths = (
        64
        85
        64
        64
        64)
      RowHeights = (
        24
        24
        24
        24
        24)
    end
    object ComboBox3: TComboBox
      Left = 155
      Top = 184
      Width = 41
      Height = 21
      DropDownCount = 9
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 5
      Text = #1042#1080#1073#1077#1088#1110#1090#1100' '#1090#1080#1087
      Visible = False
      OnChange = ComboBox3Change
      OnDropDown = ComboBox3DropDown
      Items.Strings = (
        '- '#1030#1079' '#1079#1072#1084#1110#1085#1086#1102
        '- '#1041#1077#1079' '#1079#1072#1084#1110#1085#1080)
    end
    object ComboBox2: TComboBox
      Left = 108
      Top = 184
      Width = 41
      Height = 21
      DropDownCount = 9
      ItemHeight = 13
      TabOrder = 6
      Visible = False
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
    object ComboBox1: TComboBox
      Left = 69
      Top = 184
      Width = 33
      Height = 21
      ItemHeight = 13
      TabOrder = 7
      Visible = False
      OnChange = ComboBox1Change
      OnDropDown = ComboBox1DropDown
    end
    object BBStart: TBitBtn
      Left = 449
      Top = 228
      Width = 58
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1055#1091#1089#1082
      TabOrder = 8
      OnClick = BBStartClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 259
    Width = 509
    Height = 254
    Align = alClient
    TabOrder = 1
    DesignSize = (
      509
      254)
    object Bevel3: TBevel
      Left = 79
      Top = 217
      Width = 5
      Height = 37
      Anchors = [akBottom]
      Shape = bsLeftLine
    end
    object Bevel4: TBevel
      Left = 330
      Top = 217
      Width = 6
      Height = 37
      Anchors = [akBottom]
      Shape = bsRightLine
    end
    object BitBtn1: TBitBtn
      Left = 345
      Top = 224
      Width = 75
      Height = 25
      Anchors = [akBottom]
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 426
      Top = 224
      Width = 75
      Height = 25
      Anchors = [akBottom]
      TabOrder = 1
      OnClick = BitBtn2Click
      Kind = bkCancel
    end
    object Button3: TButton
      Left = 7
      Top = 224
      Width = 25
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 47
      Top = 224
      Width = 25
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button6: TButton
      Left = 119
      Top = 224
      Width = 55
      Height = 25
      Anchors = [akBottom]
      Caption = 'Help'
      TabOrder = 4
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 260
      Top = 224
      Width = 70
      Height = 25
      Anchors = [akBottom]
      Caption = #1030#1085#1092' TCP'
      TabOrder = 5
      OnClick = Button7Click
    end
    object BLog: TButton
      Left = 84
      Top = 224
      Width = 35
      Height = 25
      Anchors = [akBottom]
      Caption = #1051#1086#1075'...'
      TabOrder = 6
      OnClick = BLogClick
    end
    object SG2: TStringGrid
      Left = 0
      Top = 1
      Width = 505
      Height = 220
      Anchors = [akLeft, akTop, akRight, akBottom]
      ColCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
      TabOrder = 7
      OnClick = SG2Click
      OnDrawCell = SG2DrawCell
      OnSetEditText = SG2SetEditText
    end
    object BAutoRun: TBitBtn
      Left = 174
      Top = 224
      Width = 86
      Height = 25
      Anchors = [akBottom]
      Caption = #1040#1074#1090#1086#1089#1090#1072#1088#1090
      TabOrder = 8
      OnClick = BAutoRunClick
      NumGlyphs = 2
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 304
    Top = 56
    object N3: TMenuItem
      Caption = #1053#1072#1083#1072#1096#1090#1091#1074#1072#1085#1085#1103
      Default = True
      OnClick = N3Click
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object N6: TMenuItem
      Caption = #1046#1091#1088#1085#1072#1083' '#1087#1086#1076#1110#1081
      OnClick = N6Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N1: TMenuItem
      Caption = #1042#1080#1093#1110#1076
      OnClick = N1Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 264
    Top = 48
  end
  object TcpServer1: TTcpServer
    OnAccept = TcpServer1Accept
    Left = 280
    Top = 104
  end
  object JvTrayIcon1: TJvTrayIcon
    Active = True
    Icon.Data = {
      0000010001002020000001002000A81000001600000028000000200000004000
      0000010020000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000410000
      00FF000000FF000000FF000000FF000000FF0000002000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000410000
      00FFFE9800FFFE9800FFF54F51FE000000FF000000FF0000002F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000410000
      00FFFE9800FFFE9800FFFE9800FFE94B4DFE000000FF000000FF0000002E0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000410000
      00FFFA5153FEFE9800FFFE9800FFFE9800FFEE4D4FFE000000FF000000FF0000
      0024000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000310000
      00FF000000FFEE4D4FFFFE9800FFFE9800FFFE9800FFFE9800FF000000FF0000
      00FF000000330000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0039000000FF000000FFF34F51FEFE9800FFFE9800FFFE9800FF000000000000
      00FF000000FF0000004B00000000000000000000000000000000000000000000
      00000000000000000000000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FFFE9800FFFE9800FFFE9800FF000000000000
      0002000000FF000000FF00000052000000000000000000000000000000000000
      00000000000000000000000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FFFE9800FFFE9800FF000000000000
      000000000006000000FF000000FF000000560000000300000000000000000000
      00000000000000000000000000FF000000FF0000000000000000FF5355A4FE98
      00FFFE9800FFFE9800FFFE9800FFFE9800FFFE9800FF0000000000000000FE52
      546AFE9800FFFE9800FFFE9800FFFE9800FFFE9800FFFE9800FF000000000000
      000000000000FF53555A000000FF000000FF0000006700000000000000000000
      00000000000000000000000000FF000000FF0000000000000000FF5355A4FE98
      00FFFE9800FFFE9800FFFE9800FFFE9800FFFE9800FF0000000000000000FE52
      546AFE9800FFFE9800FFFE9800FFFE9800FFFE9800FFFE9800FF000000000000
      000000000000FF53555AFE9800FF000000FF000000FF00000000000000000000
      00000000000000000000000000FF000000FF0000000000000000FF5355A4FE98
      00FFFE9800FFFE9800FFFE9800FFFE9800FFFE9800FF0000000000000000FE52
      546AFE9800FFFE9800FFFE9800FFFE9800FFFE9800FFFE9800FF000000000000
      000000000000FF53555A000000FF000000FF0000006700000000000000000000
      00000000000000000000000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF622020FFFE9800FFFE9800FF000000000000
      000000000006000000FF000000FF000000560000000300000000000000000000
      00000000000000000000000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FFFE9800FFFE9800FFFE9800FF000000000000
      0002000000FF000000FF00000052000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0039000000FF000000FFF34F51FFFE9800FFFE9800FFFE9800FF000000000000
      00FF000000FF0000004B00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000310000
      00FF000000FFEE4D4FFFFE9800FFFE9800FFFE9800FFFE9800FF000000FF0000
      00FF000000330000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000410000
      00FFFA5153FFFE9800FFFE9800FFFE9800FFEE4D4FFF000000FF000000FF0000
      0024000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000410000
      00FFFE9800FFFE9800FFFE9800FFE94B4DFF000000FF000000FF0000002E0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000410000
      00FFFE9800FFFE9800FFF54F51FF000000FF000000FF0000002F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000411607
      07FE351111FF351111FF311010FF000000FF0000002000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE03FFFFFE01FFFFFE
      00FFFFFE007FFFFE003FFFFF011FE000010FE0000183E60301C3E60301C3E603
      01C3E0000183E000010FFFFF011FFFFE003FFFFE007FFFFE00FFFFFE01FFFFFE
      03FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    IconIndex = 0
    Hint = 'Mover server'
    PopupMenu = PopupMenu1
    Visibility = [tvVisibleTaskBar, tvVisibleTaskList, tvAutoHide, tvRestoreDbClick, tvMinimizeDbClick, tvAnimateToTray]
    Left = 320
    Top = 144
  end
  object PopupMenu2: TPopupMenu
    Left = 200
    Top = 160
    object N5: TMenuItem
      Caption = #1050#1086#1087#1110#1102#1074#1072#1090#1080' '#1087#1110#1089#1083#1103' '#1077#1083#1077#1084#1077#1085#1090#1072
      OnClick = N5Click
    end
    object N4: TMenuItem
      Caption = #1050#1086#1087#1110#1102#1074#1072#1090#1080' '#1074' '#1082#1110#1085#1077#1094#1100' '#1089#1087#1080#1089#1082#1091
      OnClick = N4Click
    end
  end
  object TcpClient1: TTcpClient
    Left = 384
    Top = 104
  end
  object ZM1: TJvZlibMultiple
    OnDecompressedFile = ZM1DecompressedFile
    OnCompressedFile = ZM1CompressedFile
    Left = 384
    Top = 144
  end
  object Log1: TJvLogFile
    DefaultSeverity = lesInformation
    Left = 264
    Top = 144
  end
  object XPManifest1: TXPManifest
    Left = 168
    Top = 288
  end
  object UPTimer: TTimer
    Interval = 7200000
    OnTimer = UPTimerTimer
    Left = 432
    Top = 40
  end
  object TmrWeb: TTimer
    Interval = 1800000
    OnTimer = TmrWebTimer
    Left = 292
    Top = 315
  end
end
