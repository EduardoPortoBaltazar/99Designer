unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, FMX.Objects, FMX.ListBox,
  FMX.Layouts;

type
  TForm2 = class(TForm)
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    ListBoxItem7: TListBoxItem;
    Button3: TButton;
    Rectangle3: TRectangle;
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.Button3Click(Sender: TObject);
begin
    // Imadiatamente apos o click
    //Rectangle3.AnimateFloat('Opacity', 0, 1, TAnimationType.&In,
    //                        TInterpolationType.Linear);

    // Atrasa o inicio da animacao
    //Rectangle3.AnimateFloatDelay('Opacity', 0, 1, 3, TAnimationType.&In,
    //                        TInterpolationType.Linear);

    // Prende a execucao do projeto ate terminar (Nao funciona no Android)...
    //Rectangle3.AnimateFloatWait('Opacity', 0, 5, TAnimationType.&In,
    //                        TInterpolationType.Linear);

    //ListBoxItem1.AnimateInt('Index', 6, 6, TAnimationType.&In,
    //                        TInterpolationType.Linear);

    //Form2.AnimateColor('Fill.Color', $FF000000, 5, TAnimationType.&In,
    //                        TInterpolationType.Linear);

    TAnimator.AnimateFloat(Rectangle3, 'Opacity', 0, 1, TAnimationType.&In,
                           TInterpolationType.Linear);
end;

end.
