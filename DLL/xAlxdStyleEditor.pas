unit xAlxdStyleEditor;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  {$IFDEF DEBUGCOM}
  Windows,
  {$ENDIF}
  ComObj, ActiveX, AlxdGrid_TLB, StdVcl;

type
  TAlxdStyleEditor = class(TAutoIntfObject, IAlxdStyleEditor)
  protected
    //function Get_AlxdSpreadSheets: IAlxdSpreadSheets; safecall;
    function Edit(const Value: AlxdSpreadSheetStyle): Integer; safecall;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    constructor Create; overload;
    destructor  Destroy; override;
  end;

implementation

uses ComServ, uAlxdStyleEditor, uAlxdSpreadSheetStyle;

function TAlxdStyleEditor.Edit(const Value: AlxdSpreadSheetStyle): Integer;
begin
  Result:=FfrmAlxdStyleEditor.Edit(TAlxdSpreadSheetStyleInt(Value.Pointer));
end;

procedure TAlxdStyleEditor.AfterConstruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdStyleEditor.AfterConstruction');
  {$ENDIF}
  inherited;
end;

procedure TAlxdStyleEditor.BeforeDestruction;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdStyleEditor.BeforeDestruction');
  {$ENDIF}
  inherited;
end;

constructor TAlxdStyleEditor.Create;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdStyleEditor.CreateEx');
  {$ENDIF}
  inherited Create(ComServer.TypeLib, IAlxdStyleEditor);
  //Create(ComServer.TypeLib, IAlxdEditor);
end;

destructor  TAlxdStyleEditor.Destroy;
begin
  {$IFDEF DEBUGCOM}
  OutputDebugString(#10'TAlxdStyleEditor.Destroy');
  {$ENDIF}
  inherited;
end;



end.
