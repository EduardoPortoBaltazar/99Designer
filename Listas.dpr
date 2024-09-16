program Listas;

uses
  System.StartUpCopy,
  FMX.Forms,
  FormPrincipal in 'FormPrincipal.pas' {Form1},
  UDM_dados in 'UDM_dados.pas' {DataModule2: TDataModule},
  View.Animacoes in 'View\View.Animacoes.pas' {List},
  View.ArcAnimation in 'View\View.ArcAnimation.pas' {Form2},
  View.Thread in 'View\View.Thread.pas' {frmLThread};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLThread, frmLThread);
  Application.CreateForm(TList, List);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule2, DataModule2);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
