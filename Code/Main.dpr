program Main;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const r=100;
e = 0.001;
ListOfOperations:array[1..15] of string = ('+', '-', '*', '/',
'sin', 'cos', 'tg', 'ctg', 'ln', 'log10', 'abs', 'sqr', 'sqrt', 'exp', '=');

type
TMasOfOperands = array[1..r+1] of Real;
TMasOfOperations = array[1..r] of Integer;

procedure Possible;
var i:integer;
begin
  writeln('Возможные функции:');
  for i:=Low(ListOfOperations) to High(ListOfOperations) do
  begin
    writeln(i, ': ', ListOfOperations[i]);
  end;
end;

procedure Enter_The_Problem(var Operands:TMasOfOperands;
var Operations:TMasOfOperations; var Number:integer);
var
CurrPunkt:string;
i:integer;
begin
  Number:=1;
  i:=1;
  Writeln('Введите операнд:');
  readln(Operands[i]);
  writeln('Введите операцию:');
  readln(Operations[i]);
  while Operations[i]<>15 do
  begin
    Inc(Number);
    Inc(i);
    writeln('Введите операнд:');
    readln(Operands[i]);
    writeln('Введите операцию:');
    readln(Operations[i]);
  end;
end;

procedure DisplayArrays(Operands:TMasOfOperands;
Operations:TMasOfOperations; Number:integer);
var i:integer;
begin
for i:=1 to Number do
begin
Writeln(Operands[i]:8:3);
Writeln(Operations[i]);
end;
end;

procedure Calculating(var Result:Real; var Operands:TMasOfOperands;
Operations:TMasOfOperations; Number:integer; var Flag:boolean);
var i:integer;
begin
  i:=1;
  Flag:=True;
  while Flag and (i<=Number-1) do
  begin
    case Operations[i] of
      1: Operands[i+1]:=Operands[i]+Operands[i+1];
      2: Operands[i+1]:=Operands[i]-Operands[i+1];
      3: Operands[i+1]:=Operands[i]*Operands[i+1];
      4: if abs(Operands[i])<e then
      Flag:=False
      else
      Operands[i+1]:=Operands[i]/Operands[i+1];
      else
      Flag:=False;
    end;
    Inc(i);
  end;
  Result:=Operands[i];
end;

var s:string;
i:Integer;
Operands:TMasOfOperands;
Operations:TMasOfOperations;
Number:integer;
Result:Real;
Flag:boolean;
begin
Writeln('Допустимые операции:');
Possible;
Enter_The_Problem(Operands, Operations, Number);
Calculating(Result, Operands, Operations, Number, Flag);
writeln('Результат = ', Result:10:3);
Readln;
end.
