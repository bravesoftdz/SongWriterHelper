unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FastStringFuncs, FastStrings, ComCtrls, AdvStatusBar, ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Button1: TButton;
    AdvStatusBar1: TAdvStatusBar;
    ProgressBar1: TProgressBar;
    Panel1: TPanel;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  etkinklasor : String;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
 T:TextFile;
 S,s2:String;
 sayac:integer;
begin
 AssignFile(t,etkinklasor+'MHYPH.TXT');
 reset(t);

 ProgressBar1.Max := 187176;
 ProgressBar1.Position := 0;

 ListBox1.Items.Clear;
 sayac := 0;

 repeat
  readln(t,s);
  inc(sayac);
  if sayac mod 100 =0 then ProgressBar1.Position := sayac;

  s2 := s;
  s2 := FastReplace(s2,'_','');

  if (edit1.text <>'') and (edit2.text<>'') then
  begin
   if (SmartPos(edit1.text,s2,false) = 1) and
      ( (SmartPos(edit2.text,s2,false) = length(s2)-length(edit2.text)+1) and
        (length(s2)-length(edit2.text)+1>0) ) then
   begin
    ListBox1.Items.Add(s);
   end;
  end;

  if (edit1.text <>'') and (edit2.text='') then
  begin
   if (SmartPos(edit1.text,s2,false) = 1)  then
   begin
    ListBox1.Items.Add(s);
   end;
  end;

  if (edit1.text ='') and (edit2.text<>'') then
  begin
   if (SmartPos(edit2.text,s2,false) = length(s2)-length(edit2.text)+1) and
      (length(s2)-length(edit2.text)+1>0) then
   begin
    ListBox1.Items.Add(s);
   end;
  end;
 until eof(t);
 closefile(t);
 ProgressBar1.Position := 0;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 etkinklasor := paramstr(0);
 repeat
  IF etkinklasor[length(etkinklasor)]<>'\' THEN delete(etkinklasor,length(etkinklasor),1);
 until (etkinklasor[length(etkinklasor)]='\') or (etkinklasor='');
end;

end.
