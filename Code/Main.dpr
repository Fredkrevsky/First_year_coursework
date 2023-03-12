program Main;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const r=100;
e = 0.001;
AvailableOperations:array[1..15] of string = ('sin', 'cos', 'tg', 'ctg', 'ln', 'log10',
'abs', 'sqr', 'sqrt', 'exp', '+', '-', '*', '/', '=');

type
TMasOfOperands = array[1..r] of Real;
TMasOfOperations = array[1..r] of Integer;

procedure Possible;
var i:integer;
begin
  writeln('Возможные функции:');
  for i:=Low(AvailableOperations) to High(AvailableOperations) do
  begin
    writeln(i, ': ', AvailableOperations[i]);
  end;
end;

procedure Enter_The_Problem(var Operands:TMasOfOperands;
var Operations:TMasOfOperations; var Number:integer);
var
i:integer;
PunktOfMenu:char;
begin
  i:=0;
  Operations[i]:=1;
  while Operations[i]<>15 do
  begin
  Inc(i);
  Inc(Number);
  Writeln('Выберите что будете вводить:');
  writeln('1.Унарную операцию');
  Writeln('2.Операнд');
  Readln(PunktOfMenu);
  if PunktOfMenu = '1' then
    begin
    Writeln('Введите унарную операцию:');
    Readln(Operations[i]);
    Writeln('Введите операнд:');
    Readln(Operands[i]);
      case Operations[i] of
      1: Operands[i]:=sin(Operands[i]);
      2: Operands[i]:=cos(Operands[i]);
      else
      writeln('Пока такой функции не сущетсвует');
      end;
    end;
  if PunktOfMenu = '2' then
    begin
    Writeln('Введите операнд:');
    Readln(Operands[i]);
    end;
    Writeln('Введите бинарную операцию');
    Readln(Operations[i]);
  end;
end;

procedure DisplayArrays(Operands:TMasOfOperands;
Operations:TMasOfOperations; Number:integer);
var i:integer;
begin
for i:=1 to Number do
begin
Writeln('Число = ', Operands[i]:8:3);
Writeln('Операция = ' ,Operations[i]);
end;
end;

procedure Calculating(var Operands:TMasOfOperands;
var Operations:TMasOfOperations; Number:integer; var Flag:boolean);
var i:integer;
begin
  Flag:=True;
  i:=1;
  while flag and (i<Number) do
  begin
  case Operations[i] of
    11: Operands[i+1]:=Operands[i]+Operands[i+1];
    12: Operands[i+1]:=Operands[i]-Operands[i+1];
    13: Operands[i+1]:=Operands[i]*Operands[i+1];
    14: if abs(Operands[i])<e then
    Flag:=False
    else
    Operands[i+1]:=Operands[i]/Operands[i+1];
  end;
  Inc(i);
  end;
end;

function isInPriority(operations:TMasOfOperations; Number:Integer):boolean;
begin
  Result:=((Operations[Number] = 13) or (Operations[Number] = 14))
  and ((Operations[Number-1] = 11) or (Operations[Number-1] = 12));
end;

procedure Priority_Swap(var Operands:TMasOfOperands;
var Operations:TMasOfOperations; Number:Integer);
var intTemp:integer;
realTemp:real;
begin
  intTemp:=Operations[Number];
  Operations[Number]:=Operations[Number-1];
  Operations[Number-1]:=intTemp;

  realTemp:=Operands[Number-1];
  Operands[Number-1]:=Operands[Number];
  Operands[Number]:=Operands[Number+1];
  Operands[Number+1]:=realTemp;
end;


procedure Prioritet(var Operands:TMasOfOperands;
var Operations:TMasOfOperations; Number:Integer);
var i:integer;
Flag:boolean;
begin
i:=2;
while i<Number do
  begin
  while (i>1) and isInPriority(Operations, i) do
    begin
    Priority_Swap(Operands, Operations, i);
    Dec(i);
    end;
  Inc(i);
  end;
end;

var
Operands:TMasOfOperands;
Operations:TMasOfOperations;
Number:integer;
Result:Real;
Flag:boolean;
begin
Writeln('Допустимые операции:');
Possible;
Enter_The_Problem(Operands, Operations, Number);
Prioritet(Operands, Operations, Number);
DisplayArrays(Operands, Operations, Number);
Calculating(Operands, Operations, Number, Flag);
writeln('Результат = ', Operands[Number]:10:3);
Readln;
end.
