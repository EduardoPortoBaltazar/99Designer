unit Form_Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.Objects, Data.DB, FMX.Ani;

type
  TFrm_Principal = class(TForm)
    ToolBar1: TToolBar;
    ListView: TListView;
    btn_refresh: TSpeedButton;
    img_done: TImage;
    img_detalhe: TImage;
    rectLoading: TRectangle;
    Arc1: TArc;
    FloatAnimation2: TFloatAnimation;
    procedure btn_refreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListViewUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ListViewItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure ListViewDeletingItem(Sender: TObject; AIndex: Integer;
      var ACanDelete: Boolean);
    procedure ListViewPullRefresh(Sender: TObject);
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
        btn: TListItemTextButton;
begin
  with Frm_Principal do
  begin
    item := ListView.Items.Add;
    item.TagString:= cod_tarefa.ToString;

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
      img.Bitmap := img_done.Bitmap;

      if status = 'F' then
        img.Visible := True
      else
        img.Visible := false;

      // Icone detalhes...
      img := TListItemImage(Objects.FindDrawable('Image5'));
      img.OwnsBitmap := true;
      img.Bitmap := img_detalhe.Bitmap;

      //Botao concluido
      btn:= TListItemTextButton(Objects.FindDrawable('TextButton6'));
      btn.TagString:= cod_tarefa.ToString;
      if status = 'F' then
        btn.Text:= 'Não concluido'
      else
        btn.Text:= 'Marcar como concluido';
    end;
  end;
end;

procedure TFrm_Principal.btn_refreshClick(Sender: TObject);
var
        icone : TStream;
begin
  FloatAnimation2.Start;
        TThread.CreateAnonymousThread(
        procedure
        begin
          with dm do
          begin
                qry_geral.Active := false;
                qry_geral.sql.Clear;
                qry_geral.sql.Add('SELECT * FROM TAB_TAREFA');
                qry_geral.Active := true;

                ListView.BeginUpdate;
                while NOT qry_geral.Eof do
                begin
                    sleep(3000);
                        if qry_geral.FieldByName('ICONE').AsString <> '' then
                                icone := qry_geral.CreateBlobStream(qry_geral.FieldByName('ICONE'), TBlobStreamMode.bmRead)
                        else
                                icone := nil;

                  TThread.Synchronize(
                  nil,
                  procedure
                  begin
                    Add_Tarefa(qry_geral.FieldByName('COD_TAREFA').AsInteger,
                                   qry_geral.FieldByName('DESCRICAO').AsString,
                                   qry_geral.FieldByName('CATEGORIA').AsString,
                                   qry_geral.FieldByName('STATUS').AsString,
                                   FormatDateTime('dd/mm/yyyy', qry_geral.FieldByName('DATA').AsDateTime),
                                   qry_geral.FieldByName('HORA').AsString,
                                   icone);

                  end);
                  qry_geral.next;
                end;
            ListView.EndUpdate;
            FloatAnimation2.Stop;
          end;

        end).Start;



end;

procedure TFrm_Principal.FormCreate(Sender: TObject);
begin
  img_done.Visible := false;
  img_detalhe.Visible := false;
  ListView.DeleteButtonText:= 'Deletar';
end;

procedure TFrm_Principal.ListViewDeletingItem(Sender: TObject; AIndex: Integer;
  var ACanDelete: Boolean);
var
  Lbtn: TListItemTextButton;
  LCodTarefa: string;
begin
  Lbtn:= TListItemTextButton(TListView(sender).Items[AIndex].Objects.FindDrawable('TextButton6'));
  LCodTarefa:= TListView(sender).Items[AIndex].TagString;

  if Lbtn.Text = 'Marcar concluido' then
  begin
   dm.qry_geral.Active:= False;
   dm.qry_geral.SQL.Clear;
   dm.qry_geral.SQL.Add('DELETE FROM TAB_TAREFA');
   dm.qry_geral.SQL.Add('WHERE COD_TAREFA=:codTarefa');
   dm.qry_geral.ParamByName('codTarefa').Value:= LCodTarefa;
   dm.qry_geral.ExecSQL;
  end
  else
  begin
    ACanDelete:= False;
    ShowMessage('Somente tarefas concluidas podem ser excluidas');
  end;
end;

procedure TFrm_Principal.ListViewItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var
  Status, codTarefa: string;
  img: TListItemImage;
  indice: Integer;
begin
  if TListView(sender).Selected <> nil then
  begin
    indice:= TListView(sender).Selected.Index;

    if ItemObject is TListItemTextButton then
    begin
      if TListItemTextButton(ItemObject).Name = 'TextButton6' then
      begin
        if TListItemTextButton(ItemObject).Text = 'Não concluido' then
          status:= 'A'
        else
          Status:= 'F';

        //Atualiza banco de dados
        try
          codTarefa:= TListItemTextButton(ItemObject).TagString;

          dm.qry_geral.Active:= False;
          dm.qry_geral.SQL.Clear;
          dm.qry_geral.SQL.Add('UPDATE TAB_TAREFA SET STATUS= :Status');
          dm.qry_geral.SQL.Add('WHERE COD_TAREFA=:codTarefa');
          dm.qry_geral.ParamByName('Status').Value:= Status;
          dm.qry_geral.ParamByName('codTarefa').Value:= codTarefa;
          dm.qry_geral.ExecSQL;

          img := TListItemImage(ListView.Items[indice].Objects.FindDrawable('Image4'));

          if Status = 'F' then
          begin
            img.Visible:= True;
            TListItemTextButton(ItemObject).Text:= 'Não concluido';
          end
          else
          begin
            img.Visible:= False;
            TListItemTextButton(ItemObject).Text:= 'Marcar concluido';
          end;
        except
        end;
      end;
    end;
  end;
end;

procedure TFrm_Principal.ListViewPullRefresh(Sender: TObject);
begin
  //Fazer a carga dos dados
  ListView.StopPullRefresh;
end;

procedure TFrm_Principal.ListViewUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
var
        txt : TListItemText;
        img : TListItemImage;
begin
        with AItem do
        begin
                // Altura do item...
                Height := 80;

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

                //Importante
               //Criar texto importante
               txt:= TListItemText.Create(AItem);
               txt.Text:= 'Importante';
               txt.Name:= 'TextImportante';
               txt.Font.Size:= 8;
               txt.TextColor:= $FF90B2CF;
               txt.Width:= 50;
               txt.PlaceOffset.X:= Frm_Principal.Width - 80;
               txt.PlaceOffset.Y:= Height - 25;

        end;
end;

end.
