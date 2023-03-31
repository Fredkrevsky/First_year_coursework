unit MyFunctions;

interface

function Divide(Operand1, Operand2, e:Real; var Flag:Boolean):Real;
function Degree(Operand1, Operand2, e:Real; var Flag:Boolean):Real;
procedure Reduction(var x:real; Period:integer);
function sinus(x, e:Real):Real;
function cosinus(x, e:Real):Real;
function tg(x,e:Real; var Flag:Boolean):Real;
function ctg(x,e:Real; var Flag:Boolean):Real;
function loge(x, e:Real; var Flag:Boolean):Real;

implementation

function Divide(Operand1, Operand2, e:Real; var Flag:Boolean):Real;
begin
  Flag:=Abs(Operand2)<e;
  if not Flag then
  Result:=Operand1/Operand2
  else
  Result:=0;
end;

function Degree(Operand1, Operand2, e:Real; var Flag:Boolean):Real;
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
      Flag:=True;
    end;
    Result:=0;
  end
  else
  begin
    if Abs(Abs(Frac(Operand2+0.5))-0.5)<e then
    begin
      i:=1;
      Temp:=Operand1;
      if Operand2<=0 then
      begin
        while Abs(i-Operand2)>e do
        begin
          Temp:=Temp/Operand1;
          Dec(i);
        end;
      end
      else
      begin
        while Abs(i-Operand2)>e do
        begin
          Temp:=Operand1*Temp;
          Inc(i);
        end;
      end;
      Result:=Temp;
    end
    else
    begin
      Flag:=True;
      Result:=0;
    end;
  end;
end;

procedure Reduction(var x:real; Period:integer);
var f:boolean;
begin
f:=x<0;
x:=abs(x);
while x>Period*pi do
begin
  x:=x-Period*pi;
end;
if f then
x:=-x;
end;

function sinus(x, e:Real):Real;
var
k:integer;
sin, delta:real;
begin
  Reduction(x, 2);
  sin:=0;
  k:=2;
  delta:=x;
  while abs(delta)>e do
  begin
    sin:=sin+delta;
    delta:=-delta*x*x/k/(k+1);
    k:=k+2;
  end;
  Result:=sin;
end;

function cosinus(x, e:Real):Real;
var
k:integer;
cos, delta:real;
begin
  Reduction(x, 2);
  cos:=0;
  k:=1;
  delta:=1;
  while abs(delta)>e do
  begin
    cos:=cos+delta;
    delta:=-delta*x*x/k/(k+1);
    k:=k+2;
  end;
  Result:=cos;
end;

function tg(x, e:Real; var Flag:boolean):Real;
begin
  Reduction(x, 1);
  Flag:=Abs(Abs(x)-pi/2)<e;
  if not Flag then
  Result:=sinus(x, e)/cosinus(x, e)
  else
  Result:=0;
end;

function ctg(x, e:Real; var Flag:boolean):Real;
begin
  Reduction(x, 1);
  Flag:=Abs(x)<e;
  if not Flag then
  Result:=cosinus(x, e)/sinus(x, e)
  else
  Result:=0;
end;

function loge(x, e:Real; var Flag:Boolean):Real;
begin
  Flag:=x<e;
  if not Flag then
  Result:=ln(x)
  else
  Result:=0;
end;

end.
