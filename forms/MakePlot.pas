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
    procedure BuildGraph;
    procedure BuildD;
    procedure DButtonClick(Sender: TObject);
    function Check: Boolean;
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

function TPlotting.Check: Boolean;
var
Temp1, Temp2: Extended;
begin
  try
    Temp1:=StrToFloat(LowGr.Text);
    Temp2:=StrToFloat(HGr.Text);
    Result := True;
  except
    ShowMessage('Ошибка. Введите корректно границы построения графика.');
    Result := False;
  end;
  if Result then
  begin
    Result := Temp1 < Temp2;
    if not Result then
      ShowMessage('Ошибка. Невозможные границы для построения функции.');
  end;
end;

procedure TPlotting.Buildgraph;
var
  a, b, x, y, MinY, MaxY: Extended;
  i, LengthMas: Integer;
  Flag, FirstSet: Boolean;
  Mas, TempMas: TMas;
  Problem: string;
begin
  if Check then
  begin
    a:=StrToFloat(LowGr.Text);
    b:=StrToFloat(HGr.Text);
    Flag := False;
    x := a;
    e := (b-a)*0.0001;
    LengthMas := 0;
    Problem := EnterEdit.Text;
    RPN(Problem, Mas, LengthMas, Flag);
    if not Flag then
    begin
      FirstSet:=False;
      while (x<b) and not FirstSet do
      begin
        TempMas:=Mas;
        Fill_x(TempMas, LengthMas, x);
        y := Solve(TempMas, LengthMas, Flag, e);
        if not Flag then
          begin
            Chart1.Series[0].AddXY(X, Y);
            MinY:=y;
            MaxY:=y;
            FirstSet:=True;
          end;
        x := x + e;
        Flag := False;
      end;
      while x <= b do
      begin
        TempMas:=Mas;
        Fill_x(TempMas, LengthMas, x);
        y := Solve(TempMas, LengthMas, Flag, e);
        if not Flag then
          begin
            Chart1.Series[0].AddXY(X, Y);
            if y<MinY then
            MinY:=y;
            if y>MaxY then
            MaxY:=Y;
          end;
        x := x + e;
        Flag := False;
      end;
      if abs(MinY-MaxY)>0.001 then
      Chart1.Axes.Left.SetMinMax(2*MinY, 2*MaxY)
      else
      Chart1.Axes.left.SetMinMax(MinY-10, Miny+10);
    end
    else
      ShowMessage('Ошибка. Проверьте правильность ввода');
  end;
end;

procedure TPlotting.BuildD;
var
  a, b, x, y, x0, y0, dx, dy, MinY, MaxY: Extended;
  i, LengthMas: Integer;
  Flag, Sety0, FirstSet: Boolean;
  Mas, TempMas: TMas;
  Problem: string;
begin
  if Check then
  begin
    a:=StrToFloat(LowGr.Text);
    b:=StrToFloat(HGr.Text);
    Flag := False;
    x := a;
    e := (b-a)*0.0001;
    LengthMas := 0;
    Problem := EnterEdit.Text;
    RPN(Problem, Mas, LengthMas, Flag);
    if not Flag then
    begin
      Sety0:=False;
      while (x<b) and not Sety0 do
      begin
        TempMas:=Mas;
        Fill_x(TempMas, LengthMas, x);
        y0 := Solve(TempMas, LengthMas, Flag, e);
        if not Flag then
          begin
            sety0:=True;
            x0:=x;
          end;
        x:=x+e;
        Flag:=False;
      end;
      FirstSet:=False;
      while (x<b) and not FirstSet do
      begin
        TempMas:=Mas;
        Fill_x(TempMas, LengthMas, x);
        y := Solve(TempMas, LengthMas, Flag, e);
        if not Flag then
          begin
            dx := X-X0;
            dy := Y-Y0;
            Chart1.Series[0].AddXY(X, dy/dx);
            MinY:=dy/dx;
            MaxY:=MinY;
          end;
        x0:=x;
        y0:=y;
        x := x + e;
        Flag := False;
      end;
      while x <= b do
      begin
        TempMas:=Mas;
        Fill_x(TempMas, LengthMas, x);
        y := Solve(TempMas, LengthMas, Flag, e);
        if not Flag then
          begin
            dx := X-X0;
            dy := Y-Y0;
            Chart1.Series[0].AddXY(X, dy/dx);
            if dy/dx > MaxY then
            MaxY:=dy/dx;
            if dy/dx < MinY then
            MinY:=dy/dx;
          end;
        x0:=x;
        y0:=y;
        x := x + e;
        Flag := False;
      end;
      if abs(MinY-MaxY)>0.001 then
      Chart1.Axes.Left.SetMinMax(2*MinY, 2*MaxY)
      else
      Chart1.Axes.left.SetMinMax(MinY-10, Miny+10);
    end
    else
      ShowMessage('Ошибка. Проверьте правильность ввода');
  end;
end;


procedure TPlotting.BuildButtonClick(Sender: TObject);
begin
  Chart1.Series[0].Clear;
  FunctionLabel.Caption:='График функции y = f(x)';
  BuildGraph;
end;

procedure TPlotting.DButtonClick(Sender: TObject);
begin
  Chart1.Series[0].Clear;
  FunctionLabel.Caption:='График функции y = f''(x)';
  BuildD;
end;

procedure TPlotting.ExitButtonClick(Sender: TObject);
begin
  Close;
end;

end.
