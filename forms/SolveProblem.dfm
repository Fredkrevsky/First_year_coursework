object FSolve: TFSolve
  Left = 0
  Top = 0
  Caption = 'FSolve'
  ClientHeight = 686
  ClientWidth = 1071
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object EnterPrLb: TLabel
    Left = 144
    Top = 32
    Width = 301
    Height = 48
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1088#1080#1084#1077#1088
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object ResLb: TLabel
    Left = 808
    Top = 109
    Width = 122
    Height = 48
    Caption = #1054#1090#1074#1077#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object BtnSolve: TButton
    Left = 544
    Top = 123
    Width = 113
    Height = 46
    Caption = #1056#1077#1096#1080#1090#1100
    TabOrder = 0
    OnClick = Solve
  end
  object EnterEdit: TEdit
    Left = 72
    Top = 103
    Width = 442
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = EnterEditChange
  end
  object ResultEdit: TEdit
    Left = 760
    Top = 179
    Width = 201
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
  object Seven: TButton
    Left = 72
    Top = 179
    Width = 50
    Height = 50
    Caption = '7'
    TabOrder = 3
    OnClick = CalcButton
  end
  object Eight: TButton
    Left = 128
    Top = 179
    Width = 50
    Height = 50
    Caption = '8'
    TabOrder = 4
    OnClick = CalcButton
  end
  object Nine: TButton
    Left = 184
    Top = 179
    Width = 50
    Height = 50
    Caption = '9'
    TabOrder = 5
    OnClick = CalcButton
  end
  object Divide: TButton
    Left = 240
    Top = 179
    Width = 50
    Height = 50
    Caption = '/'
    TabOrder = 6
    OnClick = CalcButton
  end
  object Four: TButton
    Left = 72
    Top = 235
    Width = 50
    Height = 50
    Caption = '4'
    TabOrder = 7
    OnClick = CalcButton
  end
  object Five: TButton
    Left = 128
    Top = 235
    Width = 50
    Height = 50
    Caption = '5'
    TabOrder = 8
    OnClick = CalcButton
  end
  object Six: TButton
    Left = 184
    Top = 235
    Width = 50
    Height = 50
    Caption = '6'
    TabOrder = 9
    OnClick = CalcButton
  end
  object Multiply: TButton
    Left = 240
    Top = 235
    Width = 50
    Height = 50
    Caption = '*'
    TabOrder = 10
    OnClick = CalcButton
  end
  object One: TButton
    Left = 72
    Top = 291
    Width = 50
    Height = 50
    Caption = '1'
    TabOrder = 11
    OnClick = CalcButton
  end
  object Two: TButton
    Left = 128
    Top = 291
    Width = 50
    Height = 50
    Caption = '2'
    TabOrder = 12
    OnClick = CalcButton
  end
  object Three: TButton
    Left = 184
    Top = 291
    Width = 50
    Height = 50
    Caption = '3'
    TabOrder = 13
    OnClick = CalcButton
  end
  object Minus: TButton
    Left = 240
    Top = 291
    Width = 50
    Height = 50
    Caption = '-'
    TabOrder = 14
    OnClick = CalcButton
  end
  object Zero: TButton
    Left = 72
    Top = 347
    Width = 50
    Height = 50
    Caption = '0'
    TabOrder = 15
    OnClick = CalcButton
  end
  object Dot: TButton
    Left = 128
    Top = 347
    Width = 50
    Height = 50
    Caption = ','
    TabOrder = 16
    OnClick = CalcButton
  end
  object PowerOf: TButton
    Left = 184
    Top = 347
    Width = 50
    Height = 50
    Caption = '^'
    TabOrder = 17
    OnClick = CalcButton
  end
  object Plus: TButton
    Left = 240
    Top = 347
    Width = 50
    Height = 50
    Caption = '+'
    TabOrder = 18
    OnClick = CalcButton
  end
  object BtnSin: TButton
    Left = 296
    Top = 179
    Width = 50
    Height = 50
    Caption = 'sin'
    TabOrder = 19
    OnClick = CalcButton
  end
  object BtnCos: TButton
    Left = 296
    Top = 235
    Width = 50
    Height = 50
    Caption = 'cos'
    TabOrder = 20
    OnClick = CalcButton
  end
  object BtnTg: TButton
    Left = 296
    Top = 291
    Width = 50
    Height = 50
    Caption = 'tg'
    TabOrder = 21
    OnClick = CalcButton
  end
  object BtnCtg: TButton
    Left = 296
    Top = 347
    Width = 50
    Height = 50
    Caption = 'ctg'
    TabOrder = 22
    OnClick = CalcButton
  end
  object BtnLn: TButton
    Left = 352
    Top = 347
    Width = 50
    Height = 50
    Caption = 'ln'
    TabOrder = 23
    OnClick = CalcButton
  end
  object BtnExp: TButton
    Left = 352
    Top = 291
    Width = 50
    Height = 50
    Caption = 'exp'
    TabOrder = 24
    OnClick = CalcButton
  end
  object BracketO: TButton
    Left = 352
    Top = 235
    Width = 50
    Height = 50
    Caption = '('
    TabOrder = 25
    OnClick = CalcButton
  end
  object BracketCl: TButton
    Left = 408
    Top = 235
    Width = 50
    Height = 50
    Caption = ')'
    TabOrder = 26
    OnClick = CalcButton
  end
  object ExitButton: TButton
    Left = 128
    Top = 441
    Width = 145
    Height = 65
    Caption = #1042#1099#1081#1090#1080' '#1074' '#1075#1083#1072#1074#1085#1086#1077' '#1084#1077#1085#1102
    TabOrder = 27
    OnClick = ExitButtonClick
  end
  object ClearButton: TButton
    Left = 408
    Top = 179
    Width = 50
    Height = 50
    Caption = 'C'
    TabOrder = 28
    OnClick = ClearButtonClick
  end
  object Backspace: TButton
    Left = 352
    Top = 179
    Width = 50
    Height = 50
    Caption = '<-'
    TabOrder = 29
    OnClick = BackspaceClick
  end
end
