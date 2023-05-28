program Form;

uses
  Vcl.Forms,
  SolveProblem in 'SolveProblem.pas',
  MyFunctions in 'MyFunctions.pas',
  MenuForm in 'MenuForm.pas',
  MakePlot in 'MakePlot.pas',
  TypesAndStructures in 'TypesAndStructures.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMenu, Menu);
  Application.CreateForm(TFSolve, FSolve);
  Application.CreateForm(TPlotting, FPlot);
  Application.Run;
end.
