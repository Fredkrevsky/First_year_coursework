unit MyFunctions;

interface

function Divide(Operand1, Operand2, e:Real; var Flag:Boolean):Real;
Function Degree(Operand1, Operand2, e:Real; var Flag:Boolean):Real;
procedure Reduction(var x:real; Period:integer);
function sinus(x, e:Real):Real;
function cosinus(x, e:Real):Real;
function tg(x,e:Real; var Flag:boolean):Real;
function ctg(x,e:Real; var Flag:boolean):Real;

implementation

function Divide(Operand1, Operand2, e:Real; var Flag:Boolean):Real;
begin
  Flag:=Abs(Operand2)>e;
  if Flag then
  Result:=Operand1/Operand2
  else
  Result:=0;
end;

function Degree(Operand1, Operand2, e:Real; var Flag:Boolean):Real;
begin
  Flag:=False;
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

function tg(x,e:Real; var Flag:boolean):Real;
begin
  Reduction(x, 1);
  Flag:=abs(abs(x)-pi/2)>e;
  if not Flag then
  Result:=sinus(x, e)/cosinus(x, e)
  else
  Result:=0;
end;

function ctg(x,e:Real; var Flag:boolean):Real;
begin
  Reduction(x, 1);
  Flag:=abs(x)>e;
  if not Flag then
  Result:=cosinus(x, e)/sinus(x, e)
  else
  Result:=0;
end;

end.
