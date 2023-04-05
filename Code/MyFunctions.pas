unit MyFunctions;

interface

uses System.SysUtils;

const r=100;
e = 0.001;

type
  Tmas = array [1 .. r] of string;
  Pointer = ^Element;

  Element = record
    Data: string;
    Next: Pointer;
  end;

  FloatPointer = ^FloatElement;

  FloatElement = record
    Data: Real;
    Next: FloatPointer;
  end;

function Divide(Operand1, Operand2, e: Real; var Flag: Boolean): Real;
function Degree(Operand1, Operand2, e: Real; var Flag: Boolean): Real;
procedure Reduction(var x: Real; Period: integer);
function sinus(x, e: Real): Real;
function cosinus(x, e: Real): Real;
function tg(x, e: Real; var Flag: Boolean): Real;
function ctg(x, e: Real; var Flag: Boolean): Real;
function loge(x, e: Real; var Flag: Boolean): Real;
procedure ReplaceDots(var Problem: string);
function IsNumber(ToCheck: String): Boolean;
procedure Push(var Stack: Pointer; ToPush: string);
procedure Pop(var Stack: Pointer; var ToPop: string);
procedure FloatPush(var Stack: FloatPointer; ToPush: Real);
procedure FloatPop(var Stack: FloatPointer; var ToPop: Real);
procedure Prepare(var Problem: String);
procedure Rpn(Problem: string; var MasProblem: Tmas; var LengthMas: Integer;
  var Flag: Boolean; e:Real);
procedure Fill_x(var MasProblem: Tmas; LengthMas: Integer; x: Real);
procedure Solve(MasProblem: Tmas; LengthMas: Integer; var Flag: Boolean;
  var Stack: FloatPointer; e:Real);


implementation

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

function sinus(x, e: Real): Real;
var
  k: integer;
  sin, delta: Real;
begin
  Reduction(x, 2);
  sin := 0;
  k := 2;
  delta := x;
  while Abs(delta) > e do
  begin
    sin := sin + delta;
    delta := -delta * x * x / k / (k + 1);
    k := k + 2;
  end;
  Result := sin;
end;

function cosinus(x, e: Real): Real;
var
  k: integer;
  cos, delta: Real;
begin
  Reduction(x, 2);
  cos := 0;
  k := 1;
  delta := 1;
  while Abs(delta) > e do
  begin
    cos := cos + delta;
    delta := -delta * x * x / k / (k + 1);
    k := k + 2;
  end;
  Result := cos;
end;

function tg(x, e: Real; var Flag: Boolean): Real;
begin
  Reduction(x, 1);
  Flag := Abs(Abs(x) - pi / 2) < e;
  if not Flag then
    Result := sinus(x, e) / cosinus(x, e)
  else
    Result := 0;
end;

function ctg(x, e: Real; var Flag: Boolean): Real;
begin
  Reduction(x, 1);
  Flag := Abs(x) < e;
  if not Flag then
    Result := cosinus(x, e) / sinus(x, e)
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

procedure ReplaceDots(var Problem: string);
begin
  while Pos('.', Problem) <> 0 do
  begin
    Problem[Pos('.', Problem)] := ',';
  end;
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

procedure Push(var Stack: Pointer; ToPush: string);
var
  Temp: Pointer;
begin
  New(Temp);
  Temp^.Data := ToPush;
  Temp^.Next := Stack;
  Stack := Temp;
end;

procedure Pop(var Stack: Pointer; var ToPop: string);
var
  Temp: Pointer;
begin
  if Stack <> nil then
  begin
    ToPop := Stack^.Data;
    Temp := Stack;
    Stack := Stack^.Next;
    Dispose(Temp);
  end;
end;

procedure FloatPush(var Stack: FloatPointer; ToPush: Real);
var
  Temp: FloatPointer;
begin
  New(Temp);
  Temp^.Data := ToPush;
  Temp^.Next := Stack;
  Stack := Temp;
end;

procedure FloatPop(var Stack: FloatPointer; var ToPop: Real);
var
  Temp: FloatPointer;
begin
  if Stack <> nil then
  begin
    ToPop := Stack^.Data;
    Temp := Stack;
    Stack := Stack^.Next;
    Dispose(Temp);
  end;
end;

procedure Prepare(var Problem: String);
var
  i: Integer;
begin
  if Problem[1] = '-' then
    Insert('0', Problem, 1);
  i := 2;
  while i <= Length(Problem) do
  begin
    if (Problem[i] = '-') and (Problem[i - 1] = '(') then
      Insert('0', Problem, i)
    else
      Inc(i)
  end;
end;

procedure Rpn(Problem: string; var MasProblem: Tmas; var LengthMas: Integer;
  var Flag: Boolean; e:Real);
var
  i: Integer;
  Temp: string;
  Stack: Pointer;
begin
  Stack := nil;
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
          while (Stack <> nil) and (Stack^.Data <> '(') do
          begin
            Pop(Stack, Temp);
            Inc(LengthMas);
            MasProblem[LengthMas] := Temp;
          end;
          Push(Stack, Problem[i]);
        end;
      '*', '/':
        begin
          while (Stack <> nil) and (Stack^.Data <> '+') and (Stack^.Data <> '-')
            and (Stack^.Data <> '(') do
          begin
            Pop(Stack, Temp);
            Inc(LengthMas);
            MasProblem[LengthMas] := Temp;
          end;
          Push(Stack, Problem[i]);
        end;
      '^':
        begin
          while (Stack <> nil) and (Stack^.Data <> '+') and (Stack^.Data <> '-')
            and (Stack^.Data <> '*') and (Stack^.Data <> '/') and
            (Stack^.Data <> '(') do
          begin
            Pop(Stack, Temp);
            Inc(LengthMas);
            MasProblem[LengthMas] := Temp;
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
            MasProblem[LengthMas] := Temp;
          end
          until (Stack = nil) or (Temp = '(');
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
          'k': // Здесь сделать значок квадратного корня из числа, который потом будет вводиться с кнопки
            Push(Stack, 'k');
        else
          Flag := True;
    end;
    Inc(i);
  end;
  if not Flag then
  begin
    while Stack <> nil do
    begin
      Pop(Stack, Temp);
      Inc(LengthMas);
      MasProblem[LengthMas] := Temp;
    end;
  end;
end;

procedure Fill_x(var MasProblem: Tmas; LengthMas: Integer; x: Real);
var
  i: Integer;
begin
  for i := 1 to LengthMas do
  begin
    if MasProblem[i] = 'x' then
      MasProblem[i] := FloatToStr(x);
  end;
end;

procedure Solve(MasProblem: Tmas; LengthMas: Integer; var Flag: Boolean;
  var Stack: FloatPointer; e:Real);
var
  i: Integer;
  Temp: Real;
  Operand2: Real;
begin
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
        FloatPop(Stack, Temp);
        case Length(MasProblem[i]) of
          1:
            begin
              if MasProblem[i][1] = 'k' then
                Temp := Degree(Temp, 0.5, e, Flag)
              else
              begin
                Flag := Stack = nil;
                if Not Flag then
                begin
                  FloatPop(Stack, Operand2);
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
            end;
          2:
            begin
              case MasProblem[i][1] of
                'l':
                  Temp := Loge(Temp, e, Flag);
                't':
                  Temp := tg(Temp, e, Flag);
              end;
            end;
          3:
            begin
              case MasProblem[i][1] of
                's':
                  Temp := Sinus(Temp, e);
                'c':
                  begin
                    case MasProblem[i][2] of
                      't':
                        Temp := Ctg(Temp, e, Flag);
                      'o':
                        Temp := Cosinus(Temp, e);
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
end;

end.
