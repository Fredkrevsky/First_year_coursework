unit TypesAndStructures;

interface

const
  r = 100;
  e = 0.001;
  FLOfFunc: set of Char = ['l', 't', 's', 'c', 'e'];
  Numbers: set Of Char = ['0' .. '9'];

type
  TMas = array [1 .. r] of string;

  TConstantInFile = record
    Name: string[30];
    Value: Real;
  end;

  TFormulaInFile = record
    Name: string[30];
    Data: string[50];
  end;

Type

  TFloatStack = ^FloatElement;

  FloatElement = record
    Data: Extended;
    Next: TFloatStack;
  end;

  TStringStack = ^StringElement;

  StringElement = record
    Data: String;
    Next: TStringStack;
  end;


  function FloatPop(var Stack: TFloatStack): Extended;
  function FloatTop(Stack: TFloatStack): Extended;
  procedure FloatPush(var Stack: TFloatStack; ToPush: Extended);
  function Pop(var Stack: TStringStack): String;
  function Top(Stack: TStringStack): String;
  procedure Push(var Stack: TStringStack; ToPush: String);




implementation

function FloatPop(var Stack: TFloatStack): Extended;
var
  Temp: TFloatStack;
begin
  Result := Stack^.Data;
  Temp := Stack;
  Stack:=Stack^.Next;
  Dispose(Temp);
end;

function FloatTop(Stack: TFloatStack): Extended;
begin
  Result := Stack^.Data;
end;

procedure FloatPush(var Stack: TFloatStack; ToPush: Extended);
var
  Temp: TFloatStack;
begin
  New(Temp);
  Temp^.Data := ToPush;
  Temp^.Next := Stack;
  Stack := Temp;
end;

function Pop(var Stack: TStringStack): String;
var
  Temp: TStringStack;
Begin
  Result := Stack^.Data;
  Temp := Stack;
  Stack:=Stack^.Next;
  Dispose(Temp);
End;

function Top(Stack: TStringStack): String;
Begin
  Result := Stack^.Data;
End;

procedure Push(var Stack: TStringStack; ToPush: String);
var
  Temp: TStringStack;
Begin
  New(Temp);
  Temp^.Data := ToPush;
  Temp^.Next := Stack;
  Stack := Temp;
End;

end.
