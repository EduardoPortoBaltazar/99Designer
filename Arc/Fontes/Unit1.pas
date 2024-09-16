unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    Arc1: TArc;
    Label1: TLabel;
    FloatAnimation1: TFloatAnimation;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    TrackBar1: TTrackBar;
    CheckBox3: TCheckBox;
    Arc2: TArc;
    Label2: TLabel;
    FloatAnimation2: TFloatAnimation;
    Arc3: TArc;
    Label3: TLabel;
    FloatAnimation3: TFloatAnimation;
    Arc4: TArc;
    Label4: TLabel;
    FloatAnimation4: TFloatAnimation;
    Arc5: TArc;
    Label5: TLabel;
    FloatAnimation5: TFloatAnimation;
    Arc6: TArc;
    Label6: TLabel;
    FloatAnimation6: TFloatAnimation;
    Arc7: TArc;
    Label7: TLabel;
    FloatAnimation7: TFloatAnimation;
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure Setup();
begin
    with form1 do
    begin
        if RadioButton2.IsChecked then
            FloatAnimation1.AnimationType := TAnimationType.Out
        else if RadioButton3.IsChecked then
            FloatAnimation1.AnimationType := TAnimationType.InOut
        else
            FloatAnimation1.AnimationType := TAnimationType.&In;


        FloatAnimation1.Duration := TrackBar1.Value;
        FloatAnimation2.Duration := TrackBar1.Value;
        FloatAnimation3.Duration := TrackBar1.Value;
        FloatAnimation4.Duration := TrackBar1.Value;
        FloatAnimation5.Duration := TrackBar1.Value;
        FloatAnimation6.Duration := TrackBar1.Value;
        FloatAnimation7.Duration := TrackBar1.Value;


        FloatAnimation1.AutoReverse := CheckBox3.IsChecked;
        FloatAnimation2.AutoReverse := CheckBox3.IsChecked;
        FloatAnimation3.AutoReverse := CheckBox3.IsChecked;
        FloatAnimation4.AutoReverse := CheckBox3.IsChecked;
        FloatAnimation5.AutoReverse := CheckBox3.IsChecked;
        FloatAnimation6.AutoReverse := CheckBox3.IsChecked;
        FloatAnimation7.AutoReverse := CheckBox3.IsChecked;


        FloatAnimation1.Loop := CheckBox2.IsChecked;
        FloatAnimation2.Loop := CheckBox2.IsChecked;
        FloatAnimation3.Loop := CheckBox2.IsChecked;
        FloatAnimation4.Loop := CheckBox2.IsChecked;
        FloatAnimation5.Loop := CheckBox2.IsChecked;
        FloatAnimation6.Loop := CheckBox2.IsChecked;
        FloatAnimation7.Loop := CheckBox2.IsChecked;


        FloatAnimation1.Duration := TrackBar1.Value;
        FloatAnimation2.Duration := TrackBar1.Value;
        FloatAnimation3.Duration := TrackBar1.Value;
        FloatAnimation4.Duration := TrackBar1.Value;
        FloatAnimation5.Duration := TrackBar1.Value;
        FloatAnimation6.Duration := TrackBar1.Value;
        FloatAnimation7.Duration := TrackBar1.Value;


        FloatAnimation2.AnimationType := FloatAnimation1.AnimationType;
        FloatAnimation3.AnimationType := FloatAnimation1.AnimationType;
        FloatAnimation4.AnimationType := FloatAnimation1.AnimationType;
        FloatAnimation5.AnimationType := FloatAnimation1.AnimationType;
        FloatAnimation6.AnimationType := FloatAnimation1.AnimationType;
        FloatAnimation7.AnimationType := FloatAnimation1.AnimationType;

    end;

end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
    Setup;
    FloatAnimation1.Enabled := CheckBox1.IsChecked;
    FloatAnimation2.Enabled := CheckBox1.IsChecked;
    FloatAnimation3.Enabled := CheckBox1.IsChecked;
    FloatAnimation4.Enabled := CheckBox1.IsChecked;
    FloatAnimation5.Enabled := CheckBox1.IsChecked;
    FloatAnimation6.Enabled := CheckBox1.IsChecked;
    FloatAnimation7.Enabled := CheckBox1.IsChecked;
end;

procedure TForm1.CheckBox2Change(Sender: TObject);
begin
    Setup;
end;

procedure TForm1.RadioButton1Change(Sender: TObject);
begin
    Setup;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
    Setup;
end;

end.
