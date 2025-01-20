unit Frame.Viagem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, Dados;

type
  TFrameViagem = class(TFrame)
    Rectangle1: TRectangle;
    Image1: TImage;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    lblDe: TLabel;
    Image2: TImage;
    lblPara: TLabel;
    lblData: TLabel;
    lblCia: TLabel;
    imgMais: TImage;
  private
    FViagem: TViagem;
    procedure ConfigViagem(const Value: TViagem);

  public
    property Viagem: TViagem read FViagem write ConfigViagem;


  end;

implementation




{$R *.fmx}

{ TFrameViagem }

procedure TFrameViagem.ConfigViagem(const Value: TViagem);
begin
  FViagem:= Value;
  lblDe.Text:= FViagem.de;
  lblPara.Text:= FViagem.para;
  lblData.Text:= FViagem.data;
  lblCia.Text:= FViagem.cia;
  imgMais.TagString:= FViagem.codigo.ToString;

end;

end.
