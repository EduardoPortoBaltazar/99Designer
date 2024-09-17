unit Form_Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.Objects, Data.DB;

type
  TFrm_Principal = class(TForm)
    ToolBar1: TToolBar;
    ListView: TListView;
    btn_refresh: TSpeedButton;
    img_done: TImage;
    img_detalhe: TImage;
    procedure btn_refreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListViewUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Principal: TFrm_Principal;

implementation

{$R *.fmx}

uses Data_Module;

procedure Add_Tarefa(cod_tarefa : integer; descricao, categoria, status,
                     data_tarefa, hora : string; icone : TStream);
var
        item : TListViewItem;
        img : TListItemImage;
        bmp : TBitmap;
        txt : TListItemText;
begin
        with Frm_Principal do
        begin
                item := ListView.Items.Add;

                with item do
                begin
                        // Icone...
                        if icone <> nil then
                        begin
                                bmp := TBitmap.Create;
                                bmp.LoadFromStream(icone);
                        end;

                        img := TListItemImage(Objects.FindDrawable('Image3'));
                        img.OwnsBitmap := true;
                        img.Bitmap := bmp;


                        // Descricao...
                        txt := TListItemText(Objects.FindDrawable('Text1'));
                        txt.Text := descricao;


                        // Data e Hora...
                        txt := TListItemText(Objects.FindDrawable('Text2'));
                        txt.Text := data_tarefa + ' - ' + hora;


                        // Tarefa concluida...
                        img := TListItemImage(Objects.FindDrawable('Image4'));
                        img.OwnsBitmap := true;

                        if status = 'F' then
                                img.Bitmap := img_done.Bitmap
                        else
                                img.Visible := false;

                        // Icone detalhes...
                        img := TListItemImage(Objects.FindDrawable('Image5'));
                        img.OwnsBitmap := true;
                        img.Bitmap := img_detalhe.Bitmap;
                end;
        end;
end;

procedure TFrm_Principal.btn_refreshClick(Sender: TObject);
var
        icone : TStream;
begin
        with dm do
        begin
                qry_geral.Active := false;
                qry_geral.sql.Clear;
                qry_geral.sql.Add('SELECT * FROM TAB_TAREFA');
                qry_geral.Active := true;

                while NOT qry_geral.Eof do
                begin
                        if qry_geral.FieldByName('ICONE').AsString <> '' then
                                icone := qry_geral.CreateBlobStream(qry_geral.FieldByName('ICONE'), TBlobStreamMode.bmRead)
                        else
                                icone := nil;

                        Add_Tarefa(qry_geral.FieldByName('COD_TAREFA').AsInteger,
                                   qry_geral.FieldByName('DESCRICAO').AsString,
                                   qry_geral.FieldByName('CATEGORIA').AsString,
                                   qry_geral.FieldByName('STATUS').AsString,
                                   FormatDateTime('dd/mm/yyyy', qry_geral.FieldByName('DATA').AsDateTime),
                                   qry_geral.FieldByName('HORA').AsString,
                                   icone);

                        qry_geral.next;
                end;
        end;

end;

procedure TFrm_Principal.FormCreate(Sender: TObject);
begin
        img_done.Visible := false;
        img_detalhe.Visible := false;
end;

procedure TFrm_Principal.ListViewUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
        txt : TListItemText;
        img : TListItemImage;
begin
        with AItem do
        begin
                // Altura do item...
                Height := 60;

                // Icone...
                img := TListItemImage(Objects.FindDrawable('Image3'));
                img.OwnsBitmap := true;
                img.PlaceOffset.Y := 9;
                img.Opacity := 0.8;


                // Descricao...
                txt := TListItemText(Objects.FindDrawable('Text1'));
                txt.PlaceOffset.Y :=  11;
                txt.Width := Screen.Width - txt.PlaceOffset.X - 45;


                // Data e Hora...
                txt := TListItemText(Objects.FindDrawable('Text2'));
                txt.PlaceOffset.Y := 32;


                // Tarefa concluida...
                img := TListItemImage(Objects.FindDrawable('Image4'));
                img.OwnsBitmap := true;
                img.PlaceOffset.Y := 9;
                img.Opacity := 0.6;
                img.Height := 14;
                img.Width := 14;


                // Icone detalhes...
                img := TListItemImage(Objects.FindDrawable('Image5'));
                img.OwnsBitmap := true;
                img.PlaceOffset.Y := 9;
                img.Opacity := 0.4;
                img.Height := 14;
                img.Width := 14;

        end;
end;

end.
