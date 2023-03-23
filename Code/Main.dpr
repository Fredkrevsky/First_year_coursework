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
Pointer = ^Element;
Element = record
Data:string;
Next:Pointer;
end;

procedure Push(var Stack:Pointer; ToAdd:string);
var
Temp:Pointer;
begin
  New(Temp);
  Temp^.Data:=ToAdd;
  Temp^.Next:=Stack;
  Stack:=Temp;
end;

procedure Pop(var Stack:Pointer; var ToPop:string);
var
  Temp:Pointer;
begin
  if Stack <> nil then
  begin
    ToPop:=Stack^.Data;
    Temp:=Stack;
    Stack:=Stack^.Next;
    Dispose(Temp);
  end;
end;

procedure PrintStack(Stack:Pointer);
begin
  while Stack<>nil do
  begin
    Writeln(Stack^.Data);
    Stack:=Stack^.Next;
  end;
end;

procedure FreeStack(var Stack:Pointer);          //Только в самом конце удалять
var
   Temp:Pointer;
begin
  while Stack <> nil do
  begin
    Temp:=Stack;
    Stack:=Stack^.Next;
    Dispose(Temp);
  end;
end;

procedure Analyze(var Problem:string; var Flag:Boolean; var MasProblem:TMas;
var LengthMas:Integer; var Stack:Pointer);
var i:Integer;
NumberOfDots:Byte;
LocalFlag:Boolean;
TempPointer:Pointer;
Temp:string;
begin
  LengthMas:=1;
  i:=1;
  while (i<=length(Problem)) and Flag do
  begin
    Temp:='';
    NumberOfDots:=0;
    LocalFlag:=False;
    case Problem[i] of
    '0'..'9':
      begin
        while (i<=Length(Problem)) and ((Problem[i]>='0') and
        (Problem[i]<='9') or (Problem[i] = '.')) do
        begin
          Temp:=Temp+Problem[i];
          if Problem[i] = '.' then
          Inc(NumberOfDots);
          Inc(i);
        end;
        if NumberOfDots<2 then
        LocalFlag:=True;
        MasProblem[LengthMas]:=Temp;
        //AddToStack(Temp, St);
      end;
    '+', '-':
      begin
        //AddToStack(Problem[i], St);
        TempPointer:=Stack;
        while Stack^.next <> nil do
        //Push(TempPointer, St);
      end;
     '*', '/':
      begin

      end;
     '^':
      begin
        //AddToStack(Problem[i], St);
        TempPointer:=Stack;
        while (Stack^.next <> nil) and (Stack^.Data <> '^') do
        //Push(TempPointer, St);
      end;
    '(':
      begin

      end;
    ')':
      begin
        Inc(i);
      end;
    else
      begin
        if Problem[i] = 'x' then
        begin
          Inc(i);
        end;
        if (i<=length(Problem)-2) and not LocalFlag then
        begin
        Temp:=Problem[i]+Problem[i+1]+Problem[i+2];
        if (Temp = 'sin') or (Temp = 'cos') or (Temp = 'exp') or (Temp = 'sqr') or (Temp = 'ctg') then
          begin
            //MasProblem[LengthMas]:=Temp;
            //AddToStack(Temp, St);
            Inc(i, 3);
            LocalFlag:=True
          end;
        end;
        if (i<=Length(Problem)-1) and not LocalFlag then
        begin
        Temp:=Problem[i]+Problem[i+1];
        if (Temp = 'ln') or (Temp = 'tg') then
          begin
            //MasProblem[LengthMas]:=Temp;
            //AddToStack(Temp, St);
            Inc(i, 2);
            LocalFlag:=True
          end;
        end;
        if (i<=Length(Problem)-3) and not LocalFlag then
        begin
        Temp:=Problem[i]+Problem[i+1]+Problem[i+2]+Problem[i+3];
        if (Temp = 'sqrt') then
          begin
            //MasProblem[LengthMas]:=Temp;
            //AddToStack(Temp, St);
            Inc(i, 4);
            LocalFlag:=True;
          end;
        end;
      end;
    end;
    Flag:=LocalFlag;
    Inc(i);
    Inc(LengthMas);
  end;
end;

var
Stack:Pointer;
Problem:string;
Flag:boolean;
MasProblem:TMas;
LengthMas:Integer;
begin
  for var i:=1 to 100 do
  begin
    LengthMas:=0;
    Flag:=True;
    writeln('Введите пример:');
    Readln(Problem);
    New(Stack);
    Stack^.Next:=nil;
    Analyze(Problem, Flag, MasProblem, LengthMas, Stack);
    if Flag then
    begin
    Writeln('В строку:');
    Writeln(Problem);
    Writeln('В массив:');
    for var j:=1 to LengthMas do
      Writeln(MasProblem[j]);
    Writeln('Через стек:');
    end
    else
    Writeln('Ошибка');
  end;
  Readln;
end.
