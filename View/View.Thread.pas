unit View.Thread;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TfrmLThread = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLThread: TfrmLThread;

implementation

{$R *.fmx}

procedure TfrmLThread.Button1Click(Sender: TObject);
var
  LThread: TThread;
begin
  LThread :=  TThread.CreateAnonymousThread(
  procedure
  var
    I: Integer;
  begin
    for I := 1 to 10 do
    begin
      sleep(1000);
      Label1.Text := i.ToString;
    end;
  end);


  TThread.CreateAnonymousThread(
  procedure
  var
    I: Integer;
  begin
    for I := 1 to 10 do
    begin
      sleep(2000);
      Label2.Text := i.ToString;
    end;
  end).start;
end;

end.
