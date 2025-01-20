unit FListBox;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  Frame.Viagem, Dados;

type
  TfrmListBox = class(TForm)
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    ListBox: TListBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    procedure CriaFrame(ADados: TViagem);
  public

  end;

var
  frmListBox: TfrmListBox;

implementation


{$R *.fmx}

procedure TfrmListBox.Button1Click(Sender: TObject);
var
  V: TViagem;
  x: Integer;
begin
  for x:= 0 to 10 do
    begin
      v.codigo:= x;
      v.de:= 'São Paulo';
      v.para:= 'Rio de Janeiro';
      v.data:= '15/10/2019';
      v.cia:= 'VASP';

      CriaFrame(v);
    end;
end;

procedure TfrmListBox.CriaFrame(ADados: TViagem);
var
  LFrame: TFrameViagem;
  LItem: TListBoxItem;
begin
  LItem:= TListBoxItem.Create(nil);
  LItem.Text:= '';
  LItem.Height:= 120;

  LFrame:= TFrameViagem.Create(LItem);
  LFrame.Parent:= LItem;
  LFrame.Align:= TAlignLayout.Client;
  LFrame.Viagem:= ADados;


  LItem.Align:= TAlignLayout.Client;
  frmListBox.ListBox.AddObject(LItem);
end;

end.
