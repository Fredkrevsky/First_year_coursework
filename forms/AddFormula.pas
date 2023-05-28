unit AddFormula;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, SolveProblem;

type
  TFAddF = class(TForm)
    NameEdit: TEdit;
    DataEdit: TEdit;
    NameLabel: TLabel;
    Label1: TLabel;
    AddButton: TButton;
    procedure AddButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAddF: TFAddF;

implementation

{$R *.dfm}

procedure TFAddF.AddButtonClick(Sender: TObject);
begin
  ShowMessage('Формула успешно добавлена');
  NameEdit.Text:='';
  DataEdit.Text:='';
end;

end.
