unit View.ArcAnimation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani;

type
  TForm2 = class(TForm)
    Arc2: TArc;
    Label1: TLabel;
    FloatAnimation1: TFloatAnimation;
    Arc1: TArc;
    FloatAnimation2: TFloatAnimation;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

end.
