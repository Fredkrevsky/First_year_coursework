program Functions;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

procedure Reduction(var x:real; Period:integer);
var f:boolean;
begin
f:=(x<0);
x:=abs(x);
while x>Period*pi do
begin
  x:=x-Period*pi;
end;
if f then
x:=-x;
end;

function sin(x, e:real):real;
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

function cos(x, e:real):real;
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

function tg(x, e:real):real;
begin
  Reduction(x, 1);
  if abs(abs(x)-pi/2)<e then
  Result:=1/e
  else
  Result:=sin(x, e)/cos(x, e);
end;

function ctg(x, e:real):real;
begin
  Reduction(x, 1);
  if abs(x)<e then
  Result:=1/e
  else
  Result:=cos(x, e)/sin(x, e);
end;


var i:integer;
begin
  for i:=-10 to 10 do
  begin
    write('x = ', i);
    writeln('   ctg(x) = ', ctg(i, 0.001):7:2);
  end;
  readln;
end.
