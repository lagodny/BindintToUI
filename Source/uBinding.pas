unit uBinding;

interface

uses
  Generics.Collections,
  System.Bindings.Expression,
  System.Bindings.Helper;

type
  TBoundObject = class
  protected
    type
      TExpressionList = class(TObjectList<TBindingExpression>);
  private
    FBindings: TExpressionList;
  protected
    procedure Notify(const APropertyName: string = '');
    property Bindings: TExpressionList read FBindings;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Bind(const AProperty: string;
      const ABindObject: TObject; ABindToProperty: string;
      const ACreateOptions: TBindings.TCreateOptions = [coNotifyOutput, coEvaluate]);
    procedure ClearBindings;

  end;

implementation

{ TBoundObject }

procedure TBoundObject.Bind(const AProperty: string; const ABindObject: TObject; ABindToProperty: string;
  const ACreateOptions: TBindings.TCreateOptions);
begin
  // ������
  FBindings.Add(
    // From Source to Dest
    TBindings.CreateManagedBinding(
      // inputs
      [TBindings.CreateAssociationScope([Associate(Self, 'src')])],
      'src.' + AProperty,
      // outputs
      [TBindings.CreateAssociationScope([Associate(ABindObject, 'dst')])],
      'dst.' + ABindToProperty,
      nil, nil, ACreateOptions
    )
  );

  // � �����
  FBindings.Add(
    // From Dest to Source
    TBindings.CreateManagedBinding(
      // inputs
      [TBindings.CreateAssociationScope([Associate(ABindObject, 'src')])],
      'src.' + ABindToProperty,
      // outputs
      [TBindings.CreateAssociationScope([Associate(Self, 'dst')])],
      'dst.' + AProperty,
      nil, nil, ACreateOptions
    )
  );

end;

procedure TBoundObject.ClearBindings;
var
  i: TBindingExpression;
begin
  for i in FBindings do
    TBindings.RemoveBinding(i);
  FBindings.Clear;
end;

constructor TBoundObject.Create;
begin
  inherited;
  FBindings := TExpressionList.Create(False);
end;

destructor TBoundObject.Destroy;
begin
  ClearBindings;
  FBindings.Free;
  inherited;
end;

procedure TBoundObject.Notify(const APropertyName: string);
begin
  TBindings.Notify(Self, APropertyName);
end;

end.
