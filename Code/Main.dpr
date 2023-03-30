program Main;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  MyFunctions, System.SysUtils;

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

FloatPointer = ^FloatElement;
FloatElement = record
Data:Real;
Next:FloatPointer;
end;

function IsNumber(ToCheck:String):Boolean;
begin
  try
    StrToFloat(ToCheck);
    Result:=True;
  except
    Result:=False;
  end;
end;

procedure Push(var Stack:Pointer; ToPush:string);
var
Temp:Pointer;
begin
  New(Temp);
  Temp^.Data:=ToPush;
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

procedure FloatPush(var Stack:FloatPointer; ToPush:Real);
var Temp:FloatPointer;
begin
  New(Temp);
  Temp^.Data:=ToPush;
  Temp^.Next:=Stack;
  Stack:=Temp;
end;

procedure FloatPop(var Stack:FloatPointer; var ToPop:Real);
var
  Temp:FloatPointer;
begin
  if Stack <> nil then
  begin
    ToPop:=Stack^.Data;
    Temp:=Stack;
    Stack:=Stack^.Next;
    Dispose(Temp);
  end;
end;

procedure FloatPrint(Stack:FloatPointer);
begin
  while Stack<>nil do
  begin
    Writeln(Stack^.Data);
    Stack:=Stack^.Next;
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

procedure Prepare(var Problem:String);
var
i:Integer;
begin
  if Problem[1] = '-' then
  Insert('0', Problem, 1);
  i:=2;
  while i<=Length(Problem) do
  begin
    if (Problem[i] = '-') and (Problem[i-1] = '(') then
    Insert('0', Problem, i)
    else
    Inc(i)
  end;
end;

procedure ReplaceDots(var MasProblem:TMas; LengthMAs:Integer);
var
i, Temp:Integer;
begin
  for i:=1 to LengthMas do
  begin
    Temp:=Pos('.', MasProblem[i]);
    if Temp<>0 then
      MasProblem[i][Temp]:=',';
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
          MasProblem[LengthMas]:=Temp;
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
  if Flag then
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

procedure Solve(MasProblem:TMas; LengthMas:Integer; var Stack:FloatPointer; var Flag:Boolean);
var i:Integer;
Temp:Real;
Operand1, Operand2:Real;
begin
  i:=1;
  while (i<=LengthMas) and Flag do
  begin
    if IsNumber(MasProblem[i]) then
    begin
      FloatPush(Stack, StrToFloat(MasProblem[i]));
      Inc(i);
    end
    else
    begin
      case Length(MasProblem[i]) of
      1:
        begin
        FloatPop(Stack, Operand1);
        FloatPop(Stack, Operand2);
          case MasProblem[i][1] of
          '+':
              Temp:=Operand1+Operand2;
          '-':
              Temp:=Operand1-Operand2;
          '*':
              Temp:=Operand1*Operand2;
          '/':
              Temp:=Divide(Operand1, Operand2, e, Flag);
          '^':
             Temp:=Degree(Operand1, Operand2, e, Flag);
          end;
        end;
      2:
        begin
          FloatPop(Stack, Operand1);
          case MasProblem[i][1] of
          'l':
              Temp:=Loge(Operand1, e, Flag);
          't':
              Temp:=tg(Temp, e, Flag);
          end;
        end;
      3:
        begin
          FloatPop(Stack, Operand1);
          case MasProblem[i][1] of
          's': Temp:=Sinus(Operand1, e);
          'c':
            begin
              case MasProblem[i][2] of
                't': Temp:=Ctg(Operand1, e, Flag);
                'o': Temp:=Cosinus(Operand1, e);
              end;
            end;
          'e': Temp:=exp(Operand1);
          end;
        end;
      4: Temp:=Degree(Operand1, 0.5, e, Flag);
      end;
      FloatPush(Stack, Temp);
      Inc(i);
    end;
  end;
end;

var
FloatStack:FloatPointer;
Stack:Pointer;
Problem:string;
Temp:real;
Flag:boolean;
MasProblem:TMas;
LengthMas:Integer;
begin
  LengthMas:=0;
  Flag:=True;
  writeln('Введите пример:');
  Readln(Problem);
  Prepare(Problem);
  Stack:=nil;
  Rpn(Problem, Flag, MasProblem, LengthMas, Stack);
  if Flag then
  begin
    Fill_x(MasProblem, LengthMas, 23.34);
    ReplaceDots(MasProblem, LengthMas);
    Solve(MasProblem, LengthMas, FloatStack, Flag);
      if Flag then
      begin
        FloatPop(FloatStack, Temp);
        Writeln('Результат = ', Temp:10:3);
      end
      else
      Writeln('Ошибка');
  end
  else
  Writeln('Ошибка');
  Readln;
end.
