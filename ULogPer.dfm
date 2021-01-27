object FormLP: TFormLP
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1086#1082#1072#1079#1072#1090#1080' '#1078#1091#1088#1085#1072#1083' '#1087#1086#1076#1110#1081' '#1079#1072' '#1087#1077#1088#1110#1086#1076
  ClientHeight = 69
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DT1: TDateTimePicker
    Left = 6
    Top = 8
    Width = 140
    Height = 21
    Date = 42006.521120868060000000
    Time = 42006.521120868060000000
    TabOrder = 0
    OnChange = DT1Change
  end
  object DT2: TDateTimePicker
    Left = 166
    Top = 8
    Width = 140
    Height = 21
    Date = 42006.522914490750000000
    Time = 42006.522914490750000000
    TabOrder = 1
    OnChange = DT2Change
  end
  object BBOK: TBitBtn
    Left = 6
    Top = 38
    Width = 300
    Height = 25
    Caption = #1055#1086#1082#1072#1079#1072#1090#1080' '#1078#1091#1088#1085#1072#1083' '#1087#1086#1076#1110#1081
    TabOrder = 2
    OnClick = BBOKClick
    Kind = bkOK
  end
  object XPManifest1: TXPManifest
    Left = 152
    Top = 8
  end
end
