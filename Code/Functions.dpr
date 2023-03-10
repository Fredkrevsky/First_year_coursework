program Functions;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

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

function sin(x, e:Real):Real;
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

function cos(x, e:Real):Real;
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

procedure tg(var x:Real; e:Real; var Error:boolean);
begin
  Reduction(x, 1);
  Error:=abs(abs(x)-pi/2)<e;
  if not Error then
  x:=sin(x, e)/cos(x, e);
end;

procedure ctg(var x:Real; e:Real; var Error:boolean);
begin
  Reduction(x, 1);
  Error:=abs(x)<e;
  if not Error then
  x:=cos(x, e)/sin(x, e);
end;

procedure loge(var x:Real; e:Real; var Error:Boolean);
begin
  Error:=x<e;
  if not Error then
  x:=ln(x);
end;

procedure log10(var x:Real; e:Real; var Error:Boolean);
begin
  Error:=x<e;
  if not Error then
  x:=ln(x)/ln(10);
end;

procedure log2(var x:Real; e:Real; var Error:Boolean);
begin
  Error:=x<e;
  if not Error then
  x:=ln(x)/ln(2);
end;

procedure sqrt_4all(var x:Real; e:Real; var Error:Boolean);
begin
  Error:=x<0;
  if not Error then
  x:=sqrt(x);
end;

var i:integer;
x:real;
Error:Boolean;
begin
for i:=-10 to 10 do
  begin
    write('x = ', i);
    x:=i;
    Error:=False;
    sqrt_4all(x, 0.01, Error);
    if Error then
    writeln(' ?? ?????????')
    else
    writeln(' ln(x) = ', x:7:3);
  end;
  readln;
end.
