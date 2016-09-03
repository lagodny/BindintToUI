unit uTestBinding;

interface

uses
  uBinding;

type
  TPersot = class(TBoundObject)
  private
    FName: string;
    procedure SetName(const Value: string);
  public
    property Name: string read FName write SetName;
  end;

implementation

{ TPersot }

procedure TPersot.SetName(const Value: string);
begin
  if Value <> FName then
  begin
    FName := Value;
    Notify('Name');
  end;
end;

end.
