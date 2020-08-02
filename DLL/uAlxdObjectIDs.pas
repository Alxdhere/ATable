unit uAlxdObjectIDs;

interface

uses
  Windows, Classes, uAlxdSystem;

type
  TAlxdObjectIDsInt = class(TComponent)
  private
    FObjectIDs: TObjectIDs;

    function  Get_Count: integer;
    function  Get_Items(Index: integer): integer;
  public
    property  DirectObjectIDs: TObjectIDs read FObjectIDs write FObjectIDs;

    function  Add: integer;
    property  Count: integer read Get_Count;
    property  Items[Index: integer]: integer read Get_Items;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

//error group 000 (i.e. 101...199)

implementation

////////////////////////////////////////////////////////////////////////////////
//
//  Private
//
////////////////////////////////////////////////////////////////////////////////

function TAlxdObjectIDsInt.Get_Count: integer;
var
  c: integer;
begin
  c:=High(FObjectIDs);
  if c < 0 then
    c:=0
  else
    c:=c+1;
  Result:=c;
end;

function TAlxdObjectIDsInt.Get_Items(Index: integer): integer;
begin
  if (Index < 0) or (Index > Count)  then
  begin
    AlxdIndexedMessageBox(0, 001, '', MB_ICONWARNING + MB_OK);
    Result:=0;
    exit;
  end;

  Result:=FObjectIDs[Index];
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Private
//
////////////////////////////////////////////////////////////////////////////////

function  TAlxdObjectIDsInt.Add: integer;
begin
  SetLength(FObjectIDs, Count + 1);
  Result:=Count-1;
end;

constructor TAlxdObjectIDsInt.Create(AOwner: TComponent);
begin
  inherited;
  SetLength(FObjectIDs, 0);
end;

destructor TAlxdObjectIDsInt.Destroy;
begin
  inherited;
end;

end.
