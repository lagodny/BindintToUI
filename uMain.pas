unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit,
  System.Bindings.Helper,
  uTestBinding;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    FPerson: TPersot;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Edit1Change(Sender: TObject);
begin
  TBindings.Notify(Sender, 'Text');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FPerson := TPersot.Create;
  FPerson.Bind('Name', Edit1, 'Text');
  FPerson.Bind('Name', Edit2, 'Text');
  FPerson.Name := 'Вася';
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FPerson.Free;
end;

end.
