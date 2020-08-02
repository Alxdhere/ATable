unit testModule1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComObj, AlxdGrid_TLB, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Items: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ItemsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  uAlxdEditor;

var
  testAlxdApplication: IAlxdApplication;

procedure TForm1.Button1Click(Sender: TObject);
var
  testAlxdEditor: IAlxdEditor;
  testAlxdStyleEditor: IAlxdStyleEditor;
  testAlxdStyleManager: IAlxdStyleManager;

  testAlxdSpreadSheets: IAlxdSpreadSheets;
  testAlxdSpreadSheet: IAlxdSpreadSheet;

  testAlxdItems: IAlxdItems;

  a: integer;
begin
  testAlxdApplication:=CreateOleObject('AlxdGrid.AlxdApplication') as IAlxdApplication;

  testAlxdEditor:=testAlxdApplication.AlxdEditor;
  testAlxdEditor.Open;

  testAlxdSpreadSheets:=testAlxdEditor.AlxdSpreadSheets;
  testAlxdSpreadSheets.Add;
  testAlxdSpreadSheets.Active:=0;

  testAlxdSpreadSheet:=testAlxdSpreadSheets.Items[0];

  //testAlxdItems:=testAlxdSpreadSheet.AlxdColumns;
  //testAlxdItems.Items[0].PropertyByNum[1]:='test';
  //testAlxdSpreadSheet.AddRows(1);
//  testAlxdStyleEditor:=testAlxdApplication.AlxdStyleEditor;
//  testAlxdStyleManager:=testAlxdApplication.AlxdStyleManager;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  testAlxdEditor: IAlxdEditor;
begin
  testAlxdEditor:=testAlxdApplication.AlxdEditor;
  testAlxdEditor.Close;
  //testAlxdEditor:=nil;
  testAlxdApplication.Quit;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to 100 do
  begin
    Button1Click(Sender);
    Button2Click(Sender);
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  testAlxdStyleManager: IAlxdStyleManager;
{  testAlxdEditor: IAlxdEditor;
  testAlxdStyleEditor: IAlxdStyleEditor;
  testAlxdStyleManager: IAlxdStyleManager;

  testAlxdSpreadSheets: IAlxdSpreadSheets;
  testAlxdSpreadSheet: IAlxdSpreadSheet;

  a: integer;}
begin
  testAlxdApplication:=CreateOleObject('AlxdGrid.AlxdApplication') as IAlxdApplication;

  testAlxdStyleManager:=testAlxdApplication.AlxdStyleManager;
  testAlxdStyleManager.Show;

  testAlxdApplication.Quit;  
  //testAlxdStyleManager.Op
//  testAlxdEditor:=testAlxdApplication.AlxdEditor;
//  testAlxdEditor.Open;

end;

procedure TForm1.Button5Click(Sender: TObject);
var
  testAlxdStyleEditor: IAlxdStyleEditor;
begin
  testAlxdApplication:=CreateOleObject('AlxdGrid.AlxdApplication') as IAlxdApplication;

  testAlxdStyleEditor:=testAlxdApplication.AlxdStyleEditor
//  testAlxdStyleEditor.
end;

procedure TForm1.Button6Click(Sender: TObject);
{var
  x: Variant;
  r: integer;}
//  v: TAlxdFillType;
begin
  {x:=GetActiveOleObject('Excel.Application');
  x:=x.Workbooks[1];
  x:=x.ActiveSheet;
  }
  {for r:=0 to FfrmEditor.alMain.ActionCount-1 do
  begin
    //writeln
  end;}
end;

procedure TForm1.ItemsClick(Sender: TObject);
begin
//
end;

end.
