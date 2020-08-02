unit xAlxdSpreadSheetStyle;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  {$IFDEF DEBUGCOM}
  Windows,
  {$ENDIF}
  Classes, ComObj, ActiveX, AlxdGrid_TLB, StdVcl;

type
  TAlxdSpreadSheetStyle = class(TAutoIntfObject, IAlxdSpreadSheetStyle)
  private
    FOwner: TComponent;
  protected
    function  Get_ColCount: Integer; safecall;
    function  Get_RowCount: Integer; safecall;
    procedure Set_ColCount(Value: Integer); safecall;
    procedure Set_RowCount(Value: Integer); safecall;
    function  Get_PropertyByNum(Index: Integer): OleVariant; safecall;
    procedure Set_PropertyByNum(Index: Integer; Value: OleVariant); safecall;
    function  LoadFrom(const FullFileName: WideString): WordBool; safecall;
    procedure CopyFrom(const Value: IAlxdSpreadSheetStyle); safecall;
    function Get_Pointer: Integer; safecall;
    function Get_Justify: AlxdJustify; safecall;
    procedure Set_Justify(Value: AlxdJustify); safecall;
  public
    property  Owner: TComponent read FOwner;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    //procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TComponent); overload;
    destructor  Destroy; override;
  end;

implementation

uses ComServ, uAlxdSpreadSheetStyle, uAlxdSystem;

function TAlxdSpreadSheetStyle.Get_ColCount: Integer;
begin
  Result:=(FOwner as TAlxdSpreadSheetStyleInt).ColCount;
end;

function TAlxdSpreadSheetStyle.Get_RowCount: Integer;
begin
  Result:=(FOwner as TAlxdSpreadSheetStyleInt).RowCount;
end;

procedure TAlxdSpreadSheetStyle.Set_ColCount(Value: Integer);
begin
  (FOwner as TAlxdSpreadSheetStyleInt).ColCount:=Value;
end;

procedure TAlxdSpreadSheetStyle.Set_RowCount(Value: Integer);
begin
  (FOwner as TAlxdSpreadSheetStyleInt).RowCount:=Value;
end;

function TAlxdSpreadSheetStyle.Get_Justify: AlxdJustify;
begin
  Result:=TOleEnum((FOwner as TAlxdSpreadSheetStyleInt).Justify);
end;

procedure TAlxdSpreadSheetStyle.Set_Justify(Value: AlxdJustify);
begin
  (FOwner as TAlxdSpreadSheetStyleInt).Justify:=TAlxdJustify(Value);
end;

function TAlxdSpreadSheetStyle.Get_PropertyByNum(Index: Integer): OleVariant;
begin
  Result:=(FOwner as TAlxdSpreadSheetStyleInt).PropertyByNum[Index];
end;

procedure TAlxdSpreadSheetStyle.Set_PropertyByNum(Index: Integer; Value: OleVariant);
begin
  (FOwner as TAlxdSpreadSheetStyleInt).PropertyByNum[Index]:=Value;
end;

function TAlxdSpreadSheetStyle.LoadFrom(const FullFileName: WideString): WordBool;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.LoadFrom');
  {$ENDIF}
  Result:=(FOwner as TAlxdSpreadSheetStyleInt).LoadFrom(FullFileName);
end;

procedure TAlxdSpreadSheetStyle.CopyFrom(const Value: IAlxdSpreadSheetStyle);
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.CopyFrom');
  {$ENDIF}
  (FOwner as TAlxdSpreadSheetStyleInt).Assign(TAlxdSpreadSheetStyleInt(Value.Pointer));
end;

function TAlxdSpreadSheetStyle.Get_Pointer: Integer;
begin
  Result:=Longint(FOwner);
end;

procedure TAlxdSpreadSheetStyle.AfterConstruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.AfterConstruction');
  {$ENDIF}
  inherited;
end;

procedure TAlxdSpreadSheetStyle.BeforeDestruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.BeforeDestruction');
  {$ENDIF}
  inherited;
end;

constructor TAlxdSpreadSheetStyle.Create(AOwner: TComponent);
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.CreateEx');
  {$ENDIF}
  inherited Create(ComServer.TypeLib, IAlxdSpreadSheetStyle);
  FOwner:=AOwner;
  //Create(ComServer.TypeLib, IAlxdEditor);
end;

destructor  TAlxdSpreadSheetStyle.Destroy;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdSpreadSheetStyle.Destroy');
  {$ENDIF}
  inherited;
end;


end.
