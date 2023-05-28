unit MyFunctions;

interface

uses System.SysUtils, Math, TypesAndStructures;

procedure Fill_x(var MasProblem: TMas; LengthMas: integer; x: Real);
function Solve(MasProblem: TMas; LengthMas: integer; var Flag: Boolean;
  e: Real): Real;
function SolveTheProblem(Problem: string; var Flag: Boolean): Extended;
procedure Rpn(Problem: string; var MasProblem: TMas; var LengthMas: integer;
  var Flag: Boolean);

implementation

procedure Rpn(Problem: string; var MasProblem: TMas; var LengthMas: integer;
  var Flag: Boolean);

  procedure Prepare(var Problem: String);

  function NeedZero(Problem: string; i: Integer): Boolean;
  begin
    Result:= (Problem[i] = '-') and (Problem[i - 1] = '(');
  end;

  function NeedMul(Problem: string; i:Integer): Boolean;
  begin
    Result:=(((Problem[i] = '(') or
    (Problem[i] in FLOfFunc)) and (Problem[i-1] = 'x')) or
    ((Problem[i] = 'x') and
    ((Problem[i-1] in Numbers) or (Problem[i-1] = ')'))) or
    (((Problem[i-1] = ')') or (Problem[i-1] in Numbers)) and
    ((Problem[i] = '(') or (Problem[i] in FLOfFunc)));
  end;

  var
    i: integer;
  begin
    if Problem[1] = '-' then
      Insert('0', Problem, 1);
    i := 2;
    while i <= Length(Problem) do
    begin
      if NeedZero(Problem, i) then
        Insert('0', Problem, i)
      else if NeedMul(Problem, i) then
        Insert('*', Problem, i)
      else
        Inc(i)
    end;
    while Pos('.', Problem) <> 0 do
    begin
      Problem[Pos('.', Problem)] := ',';
    end;
  end;

var
  i: integer;
  Temp: string;
  Stack: TStringStack;
begin
  Prepare(Problem);
  Stack:=nil;
  LengthMas := 0;
  i := 1;
  while (i <= Length(Problem)) and not Flag and (LengthMas < r) do
  begin
    Temp := '';
    case Problem[i] of
      '0' .. '9':
        begin
          while (i <= Length(Problem)) and
            ((Problem[i] >= '0') and (Problem[i] <= '9') or
            (Problem[i] = ',')) do
          begin
            Temp := Temp + Problem[i];
            Inc(i);
          end;
          Dec(i);
          Inc(LengthMas);
          MasProblem[LengthMas] := Temp;
        end;
      '+', '-':
        begin
          while (Stack<>nil) and (Top(Stack) <> '(') do
          begin
            Temp:=Pop(Stack);
            Inc(LengthMas);
            MasProblem[LengthMas] := Temp;
          end;
          Push(Stack, Problem[i]);
        end;
      '*', '/':
        begin
          while (Stack <> nil) and (Top(Stack) <> '+') and (Top(Stack) <> '-')
            and (Top(Stack) <> '(') do
          begin
            Temp:=Pop(Stack);
            Inc(LengthMas);
            MasProblem[LengthMas] := Temp;
          end;
          Push(Stack, Problem[i]);
        end;
      '^':
        begin
          while (Stack <> nil) and (Top(Stack) <> '+') and (Top(Stack) <> '-')
            and (Top(Stack) <> '*') and (Top(Stack) <> '/') and
            (Top(Stack) <> '(') do
          begin
            Temp:=Pop(Stack);
            Inc(LengthMas);
            MasProblem[LengthMas] := Temp;
          end;
          Push(Stack, '^');
        end;
      '(':
        Push(Stack, '(');
      ')':
        begin
          repeat
            Temp:=Pop(Stack);
            if Temp <> '(' then
            begin
              Inc(LengthMas);
              MasProblem[LengthMas] := Temp;
            end
            until (Stack = nil) or (Temp = '(');
          end;
          'x': Push(Stack, 'x');
          's', 'c', 'e':
          if (i <= Length(Problem) - 2) then
          begin
            Temp := Copy(Problem, i, 3);
            if (Temp = 'sin') or (Temp = 'cos') or (Temp = 'exp') or
              (Temp = 'ctg') then
            begin
              Push(Stack, Temp);
              Inc(i, 2);
            end;
          end;
          'l', 't':
          if (i <= Length(Problem) - 1) and not Flag then
          begin
            Temp := Copy(Problem, i, 2);
            if (Temp = 'ln') or (Temp = 'tg') then
            begin
              Push(Stack, Temp);
              Inc(i);
            end;
          end;
        else
          Flag := True;
    end;
    Inc(i);
  end;
  if not Flag then
  begin
    while Stack <> nil do
    begin
      Temp:=Pop(Stack);
      Inc(LengthMas);
      MasProblem[LengthMas] := Temp;
    end;
  end;
  while Stack<>nil do
  Temp:=Pop(Stack);
end;

procedure Fill_x(var MasProblem: TMas; LengthMas: integer; x: Real);
var
  i: integer;
begin
  for i := 1 to LengthMas do
  begin
    if MasProblem[i] = 'x' then
      MasProblem[i] := FloatToStr(x);
  end;
end;

function Solve(MasProblem: TMas; LengthMas: integer; var Flag: Boolean;
  e: Real): Real;

  function Divide(Operand1, Operand2, e: Real; var Flag: Boolean): Real;
  begin
    Flag := Abs(Operand2) < e;
    if not Flag then
      Result := Operand1 / Operand2
    else
      Result := 0;
  end;

  function Degree(Operand1, Operand2, e: Real; var Flag: Boolean): Real;
  var
    i: integer;
    Temp: Real;
  begin
    if Operand1 > e then
      Result := exp(Operand2 * ln(Operand1))
    else if Abs(Operand1) < e then
    begin
      Flag := Operand2 < e;
      Result := 0;
    end
    else
    begin
      if Abs(Abs(Frac(Operand2 + 0.5)) - 0.5) < e then
      begin
        i := 1;
        Temp := Operand1;
        if Operand2 <= 0 then
        begin
          while Abs(i - Operand2) > e do
          begin
            Temp := Temp / Operand1;
            Dec(i);
          end;
        end
        else
        begin
          while Abs(i - Operand2) > e do
          begin
            Temp := Operand1 * Temp;
            Inc(i);
          end;
        end;
        Result := Temp;
      end
      else
      begin
        Flag := True;
        Result := 0;
      end;
    end;
  end;

  procedure Reduction(var x: Real; Period: integer);
  var
    f: Boolean;
  begin
    f := x < 0;
    x := Abs(x);
    while x > Period * pi do
      x := x - Period * pi;
    if f then
      x := -x;
  end;

  function tg(x, e: Real; var Flag: Boolean): Real;
  begin
    Reduction(x, 1);
    Flag := Abs(Abs(x) - pi / 2) < e;
    if not Flag then
      Result := sin(x) / cos(x)
    else
      Result := 0;
  end;

  function ctg(x, e: Real; var Flag: Boolean): Real;
  begin
    Reduction(x, 1);
    Flag := Abs(x) < e;
    if not Flag then
      Result := cos(x) / sin(x)
    else
      Result := 0;
  end;

  function loge(x, e: Real; var Flag: Boolean): Real;
  begin
    Flag := x < e;
    if not Flag then
      Result := ln(x)
    else
      Result := 0;
  end;

  function IsNumber(ToCheck: String): Boolean;
  begin
    try
      StrToFloat(ToCheck);
      Result := True;
    except
      Result := False;
    end;
  end;

var
  Stack: TFloatStack;
  i: integer;
  Temp: Real;
  Operand2: Real;
begin
  Stack:=nil;
  i := 1;
  while (i <= LengthMas) and not Flag do
  begin
    if IsNumber(MasProblem[i]) then
    begin
      FloatPush(Stack, StrToFloat(MasProblem[i]));
      Inc(i);
    end
    else
    begin
      Flag := Stack = nil;
      if Not Flag then
      begin
        Temp:=FloatPop(Stack);
        case Length(MasProblem[i]) of
          1:
            begin
              Flag := Stack = nil;
              if Not Flag then
              begin
                Operand2:=FloatPop(Stack);
                case MasProblem[i][1] of
                  '+':
                    Temp := Operand2 + Temp;
                  '-':
                    Temp := Operand2 - Temp;
                  '*':
                    Temp := Operand2 * Temp;
                  '/':
                    Temp := Divide(Operand2, Temp, e, Flag);
                  '^':
                    Temp := Degree(Operand2, Temp, e, Flag);
                end;
              end;

            end;
          2:
            begin
              case MasProblem[i][1] of
                'l':
                  Temp := loge(Temp, e, Flag);
                't':
                  Temp := tg(Temp, e, Flag);
              end;
            end;
          3:
            begin
              case MasProblem[i][1] of
                's':
                  Temp := sin(Temp);
                'c':
                  begin
                    case MasProblem[i][2] of
                      't':
                        Temp := ctg(Temp, e, Flag);
                      'o':
                        Temp := cos(Temp);
                    end;
                  end;
                'e':
                  Temp := exp(Temp);
              end;
            end;
          4:
            Temp := Degree(Temp, 0.5, e, Flag);
        end;
      end;
      FloatPush(Stack, Temp);
      Inc(i);
    end;
  end;
  if not Flag then
    Result:=FloatPop(Stack)
  else
    Result := 0;
  while Stack<>nil do
  Temp:=FloatPop(Stack);
end;

function SolveTheProblem(Problem: string; var Flag: Boolean): Extended;
var
  LengthMas: integer;
  Mas: TMas;
  e: Extended;
begin
  e := 0.0001;
  LengthMas := 0;
  Rpn(Problem, Mas, LengthMas, Flag);
  if not Flag then
    Result := Solve(Mas, LengthMas, Flag, e);
end;

end.
