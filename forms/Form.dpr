program Form;

uses
  Vcl.Forms,
  MyFunctions in '..\Code\MyFunctions.pas',
  SolveProblem in 'SolveProblem.pas' {FSolve};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFSolve, FSolve);
  Application.Run;
end.
