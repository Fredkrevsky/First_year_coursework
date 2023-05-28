object Plotting: TPlotting
  Left = 0
  Top = 0
  Caption = 'Plotting'
  ClientHeight = 762
  ClientWidth = 1161
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 64
    Top = 85
    Width = 178
    Height = 23
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1091#1088#1072#1074#1085#1077#1085#1080#1077':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 21
    Top = 130
    Width = 37
    Height = 24
    Caption = 'y = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 28
    Top = 199
    Width = 50
    Height = 21
    Caption = #1054#1090' x ='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 168
    Top = 199
    Width = 48
    Height = 21
    Caption = #1076#1086' x ='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object FunctionLabel: TLabel
    Left = 640
    Top = 32
    Width = 306
    Height = 33
    Caption = #1043#1088#1072#1092#1080#1082' '#1092#1091#1085#1082#1094#1080#1080' y = f(x)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object BuildButton: TButton
    Left = 8
    Top = 277
    Width = 153
    Height = 57
    Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1075#1088#1072#1092#1080#1082
    TabOrder = 0
    OnClick = BuildButtonClick
  end
  object EnterEdit: TEdit
    Left = 64
    Top = 134
    Width = 265
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object ClearButton: TButton
    Left = 180
    Top = 277
    Width = 153
    Height = 57
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1083#1086#1089#1082#1086#1089#1090#1100
    TabOrder = 2
    OnClick = ClearButtonClick
  end
  object LowGr: TEdit
    Left = 84
    Top = 202
    Width = 62
    Height = 21
    TabOrder = 3
  end
  object HGr: TEdit
    Left = 222
    Top = 202
    Width = 62
    Height = 21
    TabOrder = 4
  end
  object ExitButton: TButton
    Left = 84
    Top = 560
    Width = 139
    Height = 65
    Caption = #1042#1099#1081#1090#1080' '#1074' '#1075#1083#1072#1074#1085#1086#1077' '#1084#1077#1085#1102
    TabOrder = 5
    OnClick = ExitButtonClick
  end
  object DButton: TButton
    Left = 84
    Top = 365
    Width = 167
    Height = 57
    Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1087#1088#1086#1080#1079#1074#1086#1076#1085#1091#1102
    TabOrder = 6
  end
  object Chart1: TChart
    Left = 408
    Top = 85
    Width = 745
    Height = 532
    AllowPanning = pmNone
    Legend.Visible = False
    ScrollMouseButton = mbLeft
    Title.Color = clBlack
    Panning.MouseWheel = pmwNone
    View3D = False
    Zoom.Allow = False
    Zoom.MouseButton = mbRight
    Zoom.MouseWheel = pmwNormal
    TabOrder = 7
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Series1: TLineSeries
      Brush.BackColor = clDefault
      Dark3D = False
      Pointer.Draw3D = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Data = {0000000000}
      Detail = {0000000000}
    end
  end
  object SavePictureDialog1: TSavePictureDialog
    Left = 760
    Top = 632
  end
end
