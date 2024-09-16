unit View.Animacoes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, FMX.Objects, FMX.ListBox,
  FMX.Layouts;

type
  TList = class(TForm)
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    FloatAnimation1: TFloatAnimation;
    Rectangle5: TRectangle;
    Button1: TButton;
    ColorAnimation1: TColorAnimation;
    ColorAnimation2: TColorAnimation;
    Rectangle6: TRectangle;
    Button2: TButton;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  List: TList;

implementation

{$R *.fmx}

procedure TList.Button1Click(Sender: TObject);
begin
 FloatAnimation1.Enabled := True;
 ColorAnimation1.Enabled := True;
 ColorAnimation2.Enabled := True;
end;

procedure TList.Button2Click(Sender: TObject);
begin
  Rectangle6.AnimateFloat('Opacity', 0, 2, TAnimationType.&In, TInterpolationType.Linear);
end;

procedure TList.Button3Click(Sender: TObject);
begin
  ListBox1.AnimateInt('Index', 6, 6, TAnimationType.&In, TInterpolationType.Linear);
end;

procedure TList.FloatAnimation1Finish(Sender: TObject);
begin
  ShowMessage('Animacao terminou ');
end;

end.
