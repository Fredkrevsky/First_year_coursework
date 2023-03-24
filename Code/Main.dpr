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

procedure Rpn(var Problem:string; var Flag:Boolean; var MasProblem:TMas;
var LengthMas:Integer; var Stack:Pointer);
var i:Integer;
Temp:string;
begin
  LengthMas:=0;
  i:=1;
  while (i<=length(Problem)) and Flag do
  begin
    Temp:='';
    Flag:=False;
    case Problem[i] of
    '0'..'9':
      begin
        while (i<=Length(Problem)) and ((Problem[i]>='0') and
        (Problem[i]<='9') or (Problem[i] = '.')) do
        begin
          Temp:=Temp+Problem[i];
          Inc(i);
        end;
        Dec(i);
        Flag:=True;
        Inc(LengthMas);
        MasProblem[LengthMas]:=Temp;
      end;
    '+', '-':
      begin
        Flag:=True;
        while (Stack<>nil) and (Stack^.Data<>'(') do
        begin
          Pop(Stack, Temp);
          Inc(LengthMas);
          MasProblem[LengthMas]:=Temp;
        end;
        Push(Stack, Problem[i]);
      end;
     '*', '/':
      begin
        Flag:=True;
        while (Stack<>nil) and (Stack^.Data <> '+') and (Stack^.Data <> '-') and (Stack^.Data <> '(') do
        begin
          Pop(Stack, Temp);
          Inc(LengthMas);
          MasProblem[LengthMas]:=Temp;       //В перспективе как процедуру
        end;
        Push(Stack, Problem[i]);
      end;
     '^':
      begin
        Flag:=True;
        while (Stack<>nil) and (Stack^.Data <> '+') and (Stack^.Data <> '-')
         and (Stack^.Data <> '*') and (Stack^.Data <> '/') and (Stack^.Data <> '(') do
        begin
          Pop(Stack, Temp);
          Inc(LengthMas);
          MasProblem[LengthMas]:=Temp;
        end;
        Push(Stack, '^');
      end;
    '(':
      begin
        Flag:=True;
        Push(Stack, '(');
      end;
    ')':
      begin
      Flag:=True;
        repeat
          Pop(Stack, Temp);
          if Temp <> '(' then
          begin
            Inc(LengthMas);
            MasProblem[LengthMas]:=Temp;
          end
        until (Stack = nil) or (Temp = '(');
      end;
    else
      begin
        if Problem[i] = 'x' then
        begin
          Push(Stack, 'x');
          Flag:=True;
        end;
        if (i<=length(Problem)-2) and not Flag then
        begin
        Temp:=Copy(Problem, i, 3);
        if (Temp = 'sin') or (Temp = 'cos') or (Temp = 'exp') or
        (Temp = 'ctg') then
          begin
            Push(Stack, Temp);
            Inc(i, 2);
            Flag:=True
          end;
        end;
        if (i<=Length(Problem)-1) and not Flag then
        begin
        Temp:=Copy(Problem, i, 2);
        if (Temp = 'ln') or (Temp = 'tg') then
          begin
            Push(Stack, Temp);
            Inc(i);
            Flag:=True
          end;
        end;
        if (i<=Length(Problem)-3) and not Flag then
        begin
        Temp:=Copy(Problem, i, 4);
        if (Temp = 'sqrt') then
          begin
            Push(Stack, Temp);
            Inc(i, 3);
            Flag:=True;
          end;
        end;
      end;
    end;
    Inc(i);
  end;
  if (i>Length(Problem)) and Flag then
  begin
    while Stack <> nil do
    begin
      Pop(Stack, Temp);
      Inc(LengthMas);
      MasProblem[LengthMas]:=Temp;
    end;
  end;
end;

procedure Fill_x(var MasProblem:TMas; LengthMas:Integer; x:real);
var i:Integer;
begin
  for i:=1 to LengthMas do
    begin
      if MasProblem[i] = 'x' then
      MasProblem[i]:=FloatToStr(x);
    end;
end;

procedure Solve(MasProblem:TMas; LengthMas:Integer);
begin

end;

var
Stack:Pointer;
Problem:string;
Flag:boolean;
MasProblem:TMas;
LengthMas:Integer;
begin
  LengthMas:=0;
  Flag:=True;
  writeln('Введите пример:');
  Readln(Problem);
  Stack:=nil;
  Rpn(Problem, Flag, MasProblem, LengthMas, Stack);
  Fill_x(MasProblem, LengthMas, 23.34);
  if Flag then
  begin
  Writeln('В строку:');
  Writeln(Problem);
  Writeln('В массив:');
  for var i:=1 to LengthMas do
    Writeln(MasProblem[i]);
  end
  else
  Writeln('Ошибка');
  Readln;
end.
