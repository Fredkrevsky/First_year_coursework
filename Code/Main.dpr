program Main;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  MyFunctions;

var
  FloatStack: FloatPointer;
  Stack: FloatPointer;
  Problem: string;
  Temp: Real;
  Flag: Boolean;
  MasProblem: Tmas;
  LengthMas: Integer;
  e:Real;
begin
  e:=0.001;
  LengthMas := 0;
  Flag := False;
  Writeln('Введите пример:');
  Readln(Problem);
  Prepare(Problem);
  ReplaceDots(Problem);
  Rpn(Problem, MasProblem, LengthMas, Flag, e);
  if not Flag then
  begin
    Stack := nil;
    Solve(MasProblem, LengthMas, Flag, Stack, e);
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
