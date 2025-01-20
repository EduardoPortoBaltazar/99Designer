program Listas;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form_Principal in 'Form_Principal.pas' {Frm_Principal},
  Data_Module in 'Data_Module.pas' {dm: TDataModule},
  FListBox in 'FListBox.pas' {frmListBox},
  Dados in 'Dados.pas',
  Frame.Viagem in 'Frames\Frame.Viagem.pas' {FrameViagem: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:= True;
  Application.Initialize;
  Application.CreateForm(TFrm_Principal, Frm_Principal);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmListBox, frmListBox);
  Application.Run;
end.
