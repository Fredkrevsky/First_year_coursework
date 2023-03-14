program Main;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const r=100;
e = 0.001;
AvailableButtons:array[1..17] of string = ('sin', 'cos', 'tg', 'ctg', 'ln', 'lg',
'abs', 'sqr', 'sqrt', 'exp', '+', '-', '*', '/', '=', '(', ')');
Numbers = ('0123456789.');

type
TNumber = Real;
TProblem = array[1..r] of array [1..2] of TNumber;

(*
0 - число
1 - не число
*)

procedure Possible;                          //Ничего делать не надо
var i:integer;
begin
  writeln('Возможные функции:');
  for i:=Low(AvailableButtons) to High(AvailableButtons) do
  begin
    writeln(i, ': ', AvailableButtons[i]);
  end;
end;

procedure Enter_The_Problem(var strProblem:string; var Flag:Boolean);  //В перспективе удалить
begin
  Flag:=True;
  writeln('Введите пример:');
  Readln(strProblem);
end;

procedure Into_Array(strProblem:string; var Problem:TProblem; Flag:Boolean; var Problem_Length:Integer);
var i:Integer;
TempStr:string;                       //Сделать защиту от двух точек
begin
  i:=1;
  Problem_Length:=0;
  while i<=length(strProblem) do
  begin
    TempStr:='';
    while (i<=Length(strProblem)) and (pos(strProblem[i], Numbers)<>0) do
    begin
      TempStr:=TempStr+strProblem[i];
      Inc(i);
    end;
    if TempStr<>'' then
    begin
      if pos('.', TempStr)<>0 then
      TempStr[pos('.', TempStr)]:=',';
      Inc(Problem_Length);
      Problem[Problem_Length][1]:=strToFloat(TempStr);
      Problem[Problem_Length][2]:=0;
    end;
    Inc(i);
  end;
end;

procedure Display_Array(Problem:TProblem; Problem_Length:integer);
var i:integer;
begin
  for i:=1 to Problem_Length do
  begin
    Writeln(Problem[i][1]:10:3);
  end;
end;

procedure Calculating(var Problem:TProblem; Left, Right:Integer; var Flag:boolean);
var i:integer;
begin

end;

procedure Find_Brackets(var Problem:TProblem; Problem_Length:Integer;
var Left, Right:Integer; var Flag:boolean);
 var
 i:Integer;
 f:boolean;
begin

end;

var
Problem:Tproblem;
strProblem:string;
Problem_Length, Left, Right:integer;
Flag:boolean;
begin
  Possible;
  Enter_The_Problem(strProblem, Flag);
  Into_Array(strProblem, Problem, Flag, Problem_Length);
  Display_Array(Problem, Problem_Length);
  Readln;
end.
