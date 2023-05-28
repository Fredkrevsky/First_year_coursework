object FAddF: TFAddF
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'FAddF'
  ClientHeight = 345
  ClientWidth = 585
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object NameLabel: TLabel
    Left = 80
    Top = 69
    Width = 181
    Height = 21
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1080#1084#1103' '#1092#1086#1088#1084#1091#1083#1099':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 80
    Top = 151
    Width = 142
    Height = 21
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1092#1086#1088#1084#1091#1083#1091':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object NameEdit: TEdit
    Left = 320
    Top = 68
    Width = 201
    Height = 26
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'NameEdit'
  end
  object DataEdit: TEdit
    Left = 320
    Top = 150
    Width = 201
    Height = 26
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = 'DataEdit'
  end
  object AddButton: TButton
    Left = 216
    Top = 248
    Width = 123
    Height = 49
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = AddButtonClick
  end
end
