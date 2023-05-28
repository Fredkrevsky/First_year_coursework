object Menu: TMenu
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Calculator'
  ClientHeight = 588
  ClientWidth = 477
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ExitButton: TButton
    Left = 136
    Top = 416
    Width = 201
    Height = 81
    Caption = #1042#1099#1081#1090#1080
    TabOrder = 0
    OnClick = ExitButtonClick
  end
  object PlotButton: TButton
    Left = 136
    Top = 192
    Width = 201
    Height = 81
    Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1075#1088#1072#1092#1080#1082
    TabOrder = 1
    OnClick = PlotButtonClick
  end
  object ProblemButton: TButton
    Left = 136
    Top = 80
    Width = 201
    Height = 81
    Caption = #1056#1077#1096#1080#1090#1100' '#1087#1088#1080#1084#1077#1088
    TabOrder = 2
    OnClick = ProblemButtonClick
  end
  object SettingsButton: TButton
    Left = 136
    Top = 304
    Width = 201
    Height = 81
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
    TabOrder = 3
    OnClick = SettingsButtonClick
  end
end
