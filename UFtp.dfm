object FTPparam: TFTPparam
  Left = 0
  Top = 0
  Caption = 'FTP'
  ClientHeight = 224
  ClientWidth = 217
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    217
    224)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 1
    Top = 0
    Width = 215
    Height = 187
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = #1055#1072#1088#1084#1077#1090#1088#1080' FTP:'
    TabOrder = 0
    DesignSize = (
      215
      187)
    object Label1: TLabel
      Left = 13
      Top = 13
      Width = 3
      Height = 13
    end
    object eUser: TLabeledEdit
      Left = 13
      Top = 108
      Width = 185
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 87
      EditLabel.Height = 13
      EditLabel.Caption = #1030#1084#39#1103' '#1050#1086#1088#1080#1089#1090#1091#1074#1072#1095#1072
      TabOrder = 2
    end
    object ePass: TLabeledEdit
      Left = 13
      Top = 145
      Width = 185
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 41
      EditLabel.Height = 13
      EditLabel.Caption = #1055#1072#1088#1086#1083#1100':'
      TabOrder = 3
    end
    object eDir: TLabeledEdit
      Left = 13
      Top = 71
      Width = 185
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 62
      EditLabel.Height = 13
      EditLabel.Caption = #1044#1080#1088#1077#1082#1090#1086#1088#1110#1103':'
      TabOrder = 1
    end
    object eHost: TLabeledEdit
      Left = 13
      Top = 34
      Width = 185
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 41
      EditLabel.Height = 13
      EditLabel.Caption = #1040#1076#1088#1077#1089#1072':'
      TabOrder = 0
    end
  end
  object BitBtn2: TBitBtn
    Left = 124
    Top = 192
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    TabOrder = 2
    Kind = bkCancel
  end
  object BitBtn1: TBitBtn
    Left = 14
    Top = 192
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 1
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
end
