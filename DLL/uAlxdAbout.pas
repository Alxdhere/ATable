unit uAlxdAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  TntForms, Dialogs, ShellApi, StdCtrls, ExtCtrls;

type
  TfrmAbout = class(TTntForm)
    lUrl1: TLabel;
    lMail1: TLabel;
    Image1: TImage;
    GroupBox1: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    lCopyright: TLabel;
    lRights: TLabel;
    lTitle: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure lMailClick(Sender: TObject);
    procedure lUrlClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

procedure TfrmAbout.lMailClick(Sender: TObject);
begin
 ShellExecute(handle, nil, PChar('mailto:"Alexander Shchetinin" <' + (Sender as TLabel).Caption + '>?SUBJECT=ATable"'), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmAbout.lUrlClick(Sender: TObject);
begin
 ShellExecute(handle, nil, PChar((Sender as TLabel).Caption), nil, nil, SW_SHOWNORMAL);
end;

end.
