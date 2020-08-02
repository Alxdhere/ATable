unit xAlxdItem;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  {$IFDEF DEBUGCOM}
  Windows,
  {$ENDIF}
  Classes, ComObj, ActiveX, AlxdGrid_TLB, StdVcl;

type
  TAlxdItem = class(TAutoIntfObject, IAlxdItem)
  private
    FOwner: TComponent;

  protected
    function Get_PropertyByNum(Index: Integer): OleVariant; safecall;
    procedure Set_PropertyByNum(Index: Integer; Value: OleVariant); safecall;

  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    constructor Create(AOwner: TComponent); overload;
    destructor  Destroy; override;
  end;

implementation

uses ComServ, uAlxdItem;

function TAlxdItem.Get_PropertyByNum(Index: Integer): OleVariant;
begin
  Result:=(FOwner as TAlxdItemInt).PropertyByNum[Index];
end;

procedure TAlxdItem.Set_PropertyByNum(Index: Integer; Value: OleVariant);
begin
  (FOwner as TAlxdItemInt).PropertyByNum[Index]:=Value;
end;

procedure TAlxdItem.AfterConstruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.AfterConstruction');
  {$ENDIF}
  inherited;
end;

procedure TAlxdItem.BeforeDestruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.BeforeDestruction');
  {$ENDIF}
  inherited;
end;

constructor TAlxdItem.Create(AOwner: TComponent);
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.CreateEx');
  {$ENDIF}
  inherited Create(ComServer.TypeLib, IAlxdItem);
  FOwner:=AOwner;
  //Create(ComServer.TypeLib, IAlxdEditor);
end;

destructor  TAlxdItem.Destroy;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.Destroy');
  {$ENDIF}
  inherited;
end;

end.
