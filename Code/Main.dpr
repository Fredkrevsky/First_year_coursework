program Main;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const r=100;
TOperators:array[1..14] of string = ('+', '-', '*', '/',
'sin', 'cos', 'tg', 'ctg', 'ln', 'log10', 'abs', 'sqr', 'sqrt', 'exp');
TOperands:array[1..11] of string = ('0', '1', '2', '3', '4', '5', '6', '7',
'8', '9', '.');
type
TMasOfOperands = array[1..r] of String;
TMasOfOperators = array[1..r] of String;


{procedure SplitIntoArrays(s:string ;var Operands:TMasOfOperands; var Operators:TMasOfOperators);
var i:Integer;
begin
i:=1;
}

//Сделать исключения, когда два подряд операнда
//Или операнд в начале


//Разбиваем на два массива: Операций и операндов
//Т.е. цифры и не цифры
procedure IntoArrays(var s:String; var Operands:TMasOfOperands; var Operators:TMasOfoperators);
var i, g1, j:Integer;
begin
j:=1;
i:=1;
g1:=1;
while (i<=Length(s)) do
begin
  if s[i] = '+' then
  begin
    Operands[j]:=copy(s, g1, i-g1);
    Operators[j]:=copy(s, i, 1);
    Inc(j);
    g1:=i+1;
  end;
  Inc(i);
end;
i:=Length(s);
  while (i>=1) and (s[i]<>'+') do
  Dec(i);
  Operands[j]:=copy(s, i+1, length(s)-i);
end;

var s:string;
i:Integer;
Operands:TMasOfOperands;
Operators:TMasOfoperators;

begin           //Пока реализую для +
Writeln('Введите пример:');
Readln(s);
IntoArrays(s, Operands, Operators);
Writeln('Итоговые массивы:');
for i:=1 to 3 do
  begin
    writeln(Operands[i]);
  end;
for i:=1 to 2 do
  begin
    writeln(Operators[i]);
  end;
Readln;
end.
