program Degree;

{$APPTYPE CONSOLE}

{$R *.res}
uses
  System.SysUtils;
const
e=0.001;

Type Tests = array[1..2] of array[1..2] of Real;

Function FuncDegree(Operand1, Operand2, e:Real; var Flag:Boolean):Real;
var i:Integer;
Temp:Real;
begin
  if Operand1>e then
  begin
    Result:=exp(Operand2*ln(Operand1));
  end
  else if Abs(Operand1)<e then
  begin
    if Operand2<e then
    begin
      Flag:=False;
    end;
    Result:=0;
  end
  else
  begin
    if Abs(Frac(Operand2))<e then
    begin
      i:=1;
      Temp:=Operand1;
      if Operand2<=0 then
      begin
        while i>=Operand2 do
        begin
          Temp:=Temp/Operand1;
          Dec(i);
        end;
      end
      else
      begin
        while i<=Operand2 do
        begin
          Temp:=Operand1*Temp;
          Inc(i);
        end;
      end;
      Result:=Temp;
    end
    else
    begin
      Flag:=False;
      Result:=0;
    end;
  end;
end;


var Flag:Boolean;
Temp:Real;
Test:Tests;
begin
  Test:=[(2, 3), (3, 4)];
  Flag:=True;
  Temp:=FuncDegree(2, 3, e, Flag);
  If Flag then
  writeln(Temp:6:2);
  Flag:=True;
  Temp:=FuncDegree(2, -3, e, Flag);
  If Flag then
  writeln(Temp:6:2);
  Flag:=True;
  Temp:=FuncDegree(0, 3, e, Flag);
  If Flag then
  writeln(Temp:6:2);
  Flag:=True;
  Temp:=FuncDegree(0, -3, e, Flag);
  If Flag then
  writeln(Temp:6:2);
  Flag:=True;
  Temp:=FuncDegree(-2, 3, e, Flag);
  If Flag then
  writeln(Temp:6:2);
  Flag:=True;
  Temp:=FuncDegree(-2, 2, e, Flag);
  If Flag then
  writeln(Temp:6:2);
  Temp:=FuncDegree(-2, 0.5, e, Flag);
  If Flag then
  writeln(Temp:6:2);
  Temp:=FuncDegree(-2, 1.999999, e, Flag);
  If Flag then
  writeln(Temp:6:2);
  Readln;
end.
