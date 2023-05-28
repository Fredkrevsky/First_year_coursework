unit SolveProblem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, MyFunctions, TypesAndStructures;

type
  TFSolve = class(TForm)
    BtnSolve: TButton;
    EnterEdit: TEdit;
    ResultEdit: TEdit;
    EnterPrLb: TLabel;
    ResLb: TLabel;
    Seven: TButton;
    Eight: TButton;
    Nine: TButton;
    Divide: TButton;
    Four: TButton;
    Five: TButton;
    Six: TButton;
    Multiply: TButton;
    One: TButton;
    Two: TButton;
    Three: TButton;
    Minus: TButton;
    Zero: TButton;
    Dot: TButton;
    PowerOf: TButton;
    Plus: TButton;
    BtnSin: TButton;
    BtnCos: TButton;
    BtnTg: TButton;
    BtnCtg: TButton;
    BtnLn: TButton;
    BtnExp: TButton;
    BracketO: TButton;
    BracketCl: TButton;
    ExitButton: TButton;
    ClearButton: TButton;
    Backspace: TButton;
    procedure EnterEditChange(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure CalcButton(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure BackspaceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Solve(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  FSolve: TFSolve;
  Problem: string;
  Temp: Real;
  Flag: boolean;
  e: Real;
  FConstants: File of TConstantInFile;
  FFormulas: File of TFormulaInFile;
  BeforeKoska, AfterKoska: Integer;

implementation

{$R *.dfm}

procedure TFSolve.BackspaceClick(Sender: TObject);
var
  TempString: string;
  TempPos: Integer;
begin
  TempString := EnterEdit.Text;
  TempPos := EnterEdit.SelStart;
  Delete(TempString, TempPos, 1);
  EnterEdit.Text := TempString;
  EnterEdit.SetFocus;
  EnterEdit.SelStart := TempPos - 1;
  EnterEdit.SelLength := 0;
end;

procedure TFSolve.EnterEditChange(Sender: TObject);
begin
  ResultEdit.Text := '';
end;

procedure TFSolve.CalcButton(Sender: TObject);
var
  ButtonCaption: string;
  TempString: string;
  TempPos: Integer;
begin
  ButtonCaption := (Sender as TButton).Caption;
  TempPos := EnterEdit.SelStart;
  if TempPos = 0 then
    EnterEdit.Text := EnterEdit.Text + ButtonCaption
  else
  begin
    TempString := EnterEdit.Text;
    Insert(ButtonCaption, TempString, TempPos + 1);
    EnterEdit.Text := TempString;
  end;
  EnterEdit.SetFocus;
  EnterEdit.SelStart := TempPos + Length(ButtonCaption);
  EnterEdit.SelLength := 0;
end;

procedure TFSolve.ClearButtonClick(Sender: TObject);
begin
  EnterEdit.Text := '';
end;

procedure TFSolve.FormCreate(Sender: TObject);
begin
  AssignFile(FConstants, 'Constants');
  Reset(FConstants);

  CloseFile(FConstants);
  AssignFile(FFormulas, 'Formulas');
  Reset(FFormulas);

  CloseFile(FFormulas);
end;

procedure TFSolve.Solve(Sender: TObject);
var
  Temp: Extended;
begin
  if EnterEdit.Text <> '' then
  begin
    Problem := EnterEdit.Text;
    Flag := False;
    Temp := SolveTheProblem(Problem, Flag);
    if Flag then
      ResultEdit.Text := 'Œ¯Ë·Í‡'
    else
      ResultEdit.Text := FloatToStrF(Temp, ffFixed, 5, 5);
  end
end;

procedure TFSolve.ExitButtonClick(Sender: TObject);
begin
  Close;
end;

end.
