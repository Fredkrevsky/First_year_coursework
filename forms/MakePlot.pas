unit MakePlot;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VclTee.TeEngine,
  Vcl.ExtCtrls, VclTee.TeeProcs, VclTee.Chart, VclTee.Series, Vcl.StdCtrls,
  Vcl.Menus, MyFunctions, Vcl.ExtDlgs, TypesAndStructures;

type
  TPlotting = class(TForm)
    BuildButton: TButton;
    EnterEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ClearButton: TButton;
    LowGr: TEdit;
    HGr: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    ExitButton: TButton;
    SavePictureDialog1: TSavePictureDialog;
    DButton: TButton;
    Chart1: TChart;
    Series1: TLineSeries;
    FunctionLabel: TLabel;
    procedure BuildButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure BuildGraph;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPlot: TPlotting;
  LengthMas: Integer;
  e: Real;

implementation

{$R *.dfm}
procedure TPlotting.Buildgraph;
var
  a, b, x, y: Real;
  i, LengthMas: Integer;
  isCorrect, Flag: Boolean;
  Mas, TempMas: TMas;
  Problem: string;
begin
  try
    a := StrToFloat(LowGr.Text);
    b := StrToFloat(HGr.Text);
    isCorrect := True;
  except
    ShowMessage('Ошибка. Введите числа');
    isCorrect := False;
  end;
  if isCorrect then
  begin
    isCorrect := a < b;
    if not isCorrect then
      ShowMessage('Ошибка. Нижняя граница должна быть меньше');
  end;
  if isCorrect then
  begin
    Flag := False;
    x := a;
    e := 0.01;
    LengthMas := 0;
    Problem := EnterEdit.Text;
    RPN(Problem, Mas, LengthMas, Flag);
    if not Flag then
    begin
      while x <= b do
      begin
        TempMas:=Mas;
        Fill_x(TempMas, LengthMas, x);
        y := Solve(TempMas, LengthMas, Flag, e);
        if not Flag then
          Chart1.Series[0].AddXY(X, Y);
        x := x + e;
        Flag := False;
      end;
    end
    else
      ShowMessage('Ошибка. Проверьте правильность ввода');
  end;
end;

procedure TPlotting.BuildButtonClick(Sender: TObject);
begin
  FunctionLabel.Caption:='График функции y = f(x)';
  BuildGraph;
end;



procedure TPlotting.ClearButtonClick(Sender: TObject);
begin
  Chart1.Series[0].Clear;
end;

procedure TPlotting.ExitButtonClick(Sender: TObject);
begin
  Close;
end;

end.
