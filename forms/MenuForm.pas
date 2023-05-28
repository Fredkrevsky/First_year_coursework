unit MenuForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, SolveProblem, MakePlot, Unit1;

type
  TMenu = class(TForm)
    ExitButton: TButton;
    PlotButton: TButton;
    ProblemButton: TButton;
    SettingsButton: TButton;
    procedure ExitButtonClick(Sender: TObject);
    procedure ProblemButtonClick(Sender: TObject);
    procedure PlotButtonClick(Sender: TObject);
    procedure SettingsButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Menu: TMenu;

implementation

{$R *.dfm}

procedure TMenu.SettingsButtonClick(Sender: TObject);
var
  Form1: TForm1;
begin
  Form1 := TForm1.Create(nil);
  try
    Form1.ShowModal;
  finally
    Form1.Free;
  end;
end;

procedure TMenu.ExitButtonClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMenu.PlotButtonClick(Sender: TObject);
var
  FPlot: TPlotting;
begin
  FPlot := TPlotting.Create(nil);
  try
    FPlot.ShowModal;
  finally
    FPlot.Free;
  end;
end;

procedure TMenu.ProblemButtonClick(Sender: TObject);
var
  FSolve: TFSolve;
begin
  FSolve := TFsolve.Create(nil);
  try
    FSolve.ShowModal;
  finally
    FSolve.Free;
  end;
end;

end.
