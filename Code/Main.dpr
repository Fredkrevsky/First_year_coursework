program Main;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const
e = 0.001;
r = 100;

type
Tmas = array[1..r] of string;

procedure Enter_The_Problem(var strProblem:string);
begin
  writeln('Введите пример:');
  Readln(strProblem);
end;

procedure Spaces(var strProblem:string; var Flag:Boolean; var MasProblem:TMas; var LengthMas:Integer);
var i:Integer;
NumberOfDots:Byte;
Temp:string;
begin
  LengthMas:=0;
  i:=1;
  while (i<=length(strProblem)) and Flag do
  begin
    Temp:='';
    NumberOfDots:=0;
    case strProblem[i] of
    '0'..'9':
      begin
        while (i<=Length(strProblem)) and ((strProblem[i]>='0') and (strProblem[i]<='9') or (strProblem[i] = '.')) do
        begin
          Temp:=Temp+strProblem[i];
          if strProblem[i] = '.' then
          Inc(NumberOfDots);
          Inc(i);
        end;
        if NumberOfDots>1 then
        Flag:=False;
        Inc(LengthMas);
        MasProblem[LengthMas]:=Temp;
        Inc(i);
      end;
    '+', '-', '*', '/', '^', '(', ')':
      begin
        Inc(LengthMas);
        Temp:=strProblem[i];
        MasProblem[LengthMas]:=Temp;
        Inc(i);
        if i<=Length(strProblem) then
        Inc(i);
      end;
    else
      Flag:=False;
      Inc(i);
    end;
  end;
end;

var
strProblem:string;
Flag:boolean;
MasProblem:TMas;
LengthMas:Integer;
begin
  for var i:=1 to 100 do
  begin
    LengthMas:=0;
    Flag:=True;
    Enter_The_Problem(strProblem);
    Spaces(strProblem, Flag, MasProblem, LengthMas);
    if Flag then
    begin
    Writeln('В строку:');
    Writeln(strProblem);
    Writeln('В массив:');
    for var j:=1 to LengthMas do
      Writeln(MasProblem[j]);
    end
    else
    Writeln('Ошибка');
  end;
  Readln;
end.
