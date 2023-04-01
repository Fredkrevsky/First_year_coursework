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

procedure Rpn(Problem:string; var MasProblem:TMas; var LengthMas:Integer;
var Flag:Boolean);
var i:Integer;
Temp:string;
Stack:Pointer;
begin
  Stack:=nil;
  LengthMas:=0;
  i:=1;
  while (i<=length(Problem)) and not Flag and (LengthMas<r) do
  begin
    Temp:='';
    case Problem[i] of
    '0'..'9':
      begin
        while (i<=Length(Problem)) and ((Problem[i]>='0') and
        (Problem[i]<='9') or (Problem[i] = ',')) do
        begin
          Temp:=Temp+Problem[i];
          Inc(i);
        end;
        Dec(i);
        Inc(LengthMas);
        MasProblem[LengthMas]:=Temp;
      end;
    '+', '-':
      begin
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
        Push(Stack, '(');
    ')':
        repeat
          Pop(Stack, Temp);
          if Temp <> '(' then
          begin
            Inc(LengthMas);
            MasProblem[LengthMas]:=Temp;
          end
        until (Stack = nil) or (Temp = '(');
    'x':
        Push(Stack, 'x');
    's', 'c', 'e':
        if (i<=length(Problem)-2) then
        begin
        Temp:=Copy(Problem, i, 3);
        if (Temp = 'sin') or (Temp = 'cos') or (Temp = 'exp') or
        (Temp = 'ctg') then
          begin
            Push(Stack, Temp);
            Inc(i, 2);
          end;
        end;
    'l', 't':
        if (i<=Length(Problem)-1) and not Flag then
        begin
        Temp:=Copy(Problem, i, 2);
        if (Temp = 'ln') or (Temp = 'tg') then
          begin
            Push(Stack, Temp);
            Inc(i);
          end;
        end;
    'k':                //Здесь сделать значок квадратного корня из числа, который потом будет вводиться с кнопки
        Push(Stack, 'k');
    else
      Flag:=True;
    end;
    Inc(i);
  end;
  if not Flag then
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

procedure Solve(MasProblem:TMas; LengthMas:Integer; var Flag:Boolean; var Stack:FloatPointer);
var i:Integer;
Temp:Real;
Operand2:Real;
begin
  i:=1;
  while (i<=LengthMas) and not Flag do
  begin
    if IsNumber(MasProblem[i]) then
    begin
      FloatPush(Stack, StrToFloat(MasProblem[i]));
      Inc(i);
    end
    else
    begin
      Flag:=Stack=nil;
      if Not Flag then
      begin
        FloatPop(Stack, Temp);
        case Length(MasProblem[i]) of
        1:
          begin
            if MasProblem[i][1] = 'k' then
            Temp:=Degree(Temp, 0.5, e, Flag)
            else
            begin
              Flag:=Stack=nil;
              if Not Flag then
                begin
                FloatPop(Stack, Operand2);
                case MasProblem[i][1] of
                '+':
                    Temp:=Operand2+Temp;
                '-':
                    Temp:=Operand2-Temp;
                '*':
                    Temp:=Operand2*Temp;
                '/':
                    Temp:=Divide(Operand2, Temp, e, Flag);
                '^':
                   Temp:=Degree(Operand2, Temp, e, Flag);
                end;
              end;
            end;
          end;
        2:
          begin
            case MasProblem[i][1] of
            'l':
                Temp:=Loge(Temp, e, Flag);
            't':
                Temp:=tg(Temp, e, Flag);
            end;
          end;
        3:
          begin
            case MasProblem[i][1] of
            's': Temp:=Sinus(Temp, e);
            'c':
              begin
                case MasProblem[i][2] of
                  't': Temp:=Ctg(Temp, e, Flag);
                  'o': Temp:=Cosinus(Temp, e);
                end;
              end;
            'e': Temp:=exp(Temp);
            end;
          end;
        4:
            Temp:=Degree(Temp, 0.5, e, Flag);
        end;
      end;
      FloatPush(Stack, Temp);
      Inc(i);
    end;
  end;
end;

var
FloatStack:FloatPointer;
Stack:FloatPointer;
Problem:string;
Temp:real;
Flag:boolean;
MasProblem:TMas;
LengthMas:Integer;
begin
  LengthMas:=0;
  Flag:=False;
  writeln('Введите пример:');
  Readln(Problem);
  Prepare(Problem);
  ReplaceDots(Problem);
  Rpn(Problem, MasProblem, LengthMas, Flag);
  if not Flag then
  begin
    Stack:=nil;
    Solve(MasProblem, LengthMas, Flag, Stack);
      if not Flag then
      begin
        FloatPop(Stack, Temp);
        if Stack = nil then
        Writeln('Результат = ', Temp:10:3)
        else
        Writeln('Ошибка');
      end
      else
      Writeln('Ошибка');
  end
  else
  Writeln('Ошибка');
  Readln;
end.
