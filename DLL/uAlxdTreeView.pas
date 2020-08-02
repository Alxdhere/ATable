unit uAlxdTreeView;

interface

uses
  Messages, SysUtils, Classes, Controls, ComCtrls, uAlxdSystem, TntComCtrls;

type
//  TAlxdSortType = set of (stAlphabetically, stNotAlphabetically, stNumerically);
  TAlxdSortType = (stAlphabetically, stNotAlphabetically, stNumerically);
  TOnSized = procedure (Sender: TObject) of object;

  TAlxdTreeView = class(TTntTreeView)
  private
    { Private declarations }
    FOnSized: TOnSized;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    { Protected declarations }
  public
    { Public declarations }
    function  HasSelected: boolean;
    procedure SortSelected(Value: TAlxdSortType);

  published
    { Published declarations }
    property OnCancelEdit;
    property OnSized: TOnSized read FOnSized write FOnSized;
  end;

procedure Register;

implementation

function CustomSortProcAlphabetically(Node1, Node2: TTreeNode; Data: Longint): Integer; stdcall;
begin
//  Result := AnsiStrIComp(PChar(Node1.Text), PChar(Node2.Text));
end;

function CustomSortProcNotAlphabetically(Node1, Node2: TTreeNode; Data: Longint): Integer; stdcall;
begin
//  Result := -AnsiStrIComp(PChar(Node1.Text), PChar(Node2.Text));
end;

function CustomSortProcNumerically(Node1, Node2: TTreeNode; Data: Longint): Integer; stdcall;
var
  v1, v2: double;
  Code: integer;
begin
  Val(Node1.Text, v1, Code);
  Val(Node2.Text, v2, Code);
  Result := Integer(v1 > v2);
end;

function  TAlxdTreeView.HasSelected: boolean;
begin
  Result:=(Selected <> nil);
end;

procedure TAlxdTreeView.SortSelected(Value: TAlxdSortType);
var
  i: integer;
begin
  if HasSelected then
  begin
    for i:=0 to SelectionCount-1 do
      case Value of
      stAlphabetically:
        Selections[i].CustomSort(@CustomSortProcAlphabetically, 0);
      stNotAlphabetically:
        Selections[i].CustomSort(@CustomSortProcNotAlphabetically, 0);
      stNumerically:
        Selections[i].CustomSort(@CustomSortProcNumerically, 0);
      end;
  end;
end;

procedure TAlxdTreeView.WMSize(var Message: TWMSize);
begin
  inherited;
  if Assigned(FOnSized) then FOnSized(Self);
end;

procedure Register;
begin
  RegisterComponents('Alxd', [TAlxdTreeView]);
end;

end.
