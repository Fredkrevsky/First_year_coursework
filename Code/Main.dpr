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
Pointer = ^stack;
stack = record
data:string;
next:Pointer;
end;

procedure Enter_The_Problem(var strProblem:string);
begin
  writeln('Введите пример:');
  Readln(strProblem);
end;

procedure AddToStack(StrToAdd:string; var St:Pointer);
var x:Pointer;
begin
  New(x);
  x^.Data:=StrToAdd;
  x^.Next:=St;
  St:=x;
end;

procedure Push(var Temp:Pointer; St:Pointer);
var x:Pointer;
begin

end;

procedure Print_Stack(var St:Pointer);
begin
  while St^.Next<>nil do
  begin
    Writeln(St^.Data);
    St:=St^.Next;
  end;
end;

procedure Analyze(var strProblem:string; var Flag:Boolean; var MasProblem:TMas; var LengthMas:Integer; var St:Pointer);
var i:Integer;
NumberOfDots:Byte;
LocalFlag:Boolean;
TempPointer:Pointer;
Temp:string;
begin
  LengthMas:=1;
  i:=1;
  while (i<=length(strProblem)) and Flag do
  begin
    Temp:='';
    NumberOfDots:=0;
    LocalFlag:=False;
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
        MasProblem[LengthMas]:=Temp;
        //AddToStack(Temp, St);
      end;
    '+', '-':
      begin
        AddToStack(strProblem[i], St);
        TempPointer:=St;
        while St^.next <> nil do
        Push(TempPointer, St);
      end;
     '*', '/':
      begin
        while (St^.Next<>nil) and (St^data)
      end;
     '^':
      begin
        AddToStack(strProblem[i], St);
        TempPointer:=St;
        while (St^.next <> nil) and (St^.Data <> '^') do
        Push(TempPointer, St);
      end;
    '(':
      begin
        AddToStack(strProblem[i], St);
      end;
    ')':
      begin
        //MasProblem[LengthMas]:=strProblem[i];
        //AddToStack(strProblem[i], St);
        Inc(i);
      end;
    'a'..'z':
      begin
        if (i<=length(strProblem)-2) then
        begin
        Temp:=strProblem[i]+strProblem[i+1]+strProblem[i+2];
        if (Temp = 'sin') or (Temp = 'cos') or (Temp = 'exp') or (Temp = 'sqr') or (Temp = 'ctg') then
          begin
            //MasProblem[LengthMas]:=Temp;
            AddToStack(Temp, St);
            Inc(i, 3);
            LocalFlag:=True
          end;
        end;
        if (i<=Length(strProblem)-1) and not LocalFlag then
        begin
        Temp:=strProblem[i]+strProblem[i+1];
        if (Temp = 'ln') or (Temp = 'tg') then
          begin
            //MasProblem[LengthMas]:=Temp;
            AddToStack(Temp, St);
            Inc(i, 2);
            LocalFlag:=True
          end;
        end;
        if (i<=Length(strProblem)-3) and not LocalFlag then
        begin
        Temp:=strProblem[i]+strProblem[i+1]+strProblem[i+2]+strProblem[i+3];
        if (Temp = 'sqrt') then
          begin
            //MasProblem[LengthMas]:=Temp;
            AddToStack(Temp, St);
            Inc(i, 4);
            LocalFlag:=True;
          end;
        end;
        Flag:=LocalFlag;
      end;
    else
      Flag:=False;
    end;
    Inc(LengthMas);
  end;
end;

var
St:Pointer;
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
    New(St);
    St^.Next:=nil;
    Analyze(strProblem, Flag, MasProblem, LengthMas, St);
    if Flag then
    begin
    Writeln('В строку:');
    Writeln(strProblem);
    Writeln('В массив:');
    for var j:=1 to LengthMas do
      Writeln(MasProblem[j]);
    Writeln('Через стек:');
    Print_Stack(St);
    end
    else
    Writeln('Ошибка');
  end;
  Readln;
end.
