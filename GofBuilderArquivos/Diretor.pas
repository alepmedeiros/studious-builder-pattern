unit Diretor;

interface

uses
  Builder;

type
  TDiretor = class
    public
      procedure Construct(Builder : iBuilder);
  end;

implementation

{ TDiretor }

procedure TDiretor.Construct(Builder: iBuilder);
begin
  Builder.BuilderCabecalho;
  Builder.BuilderDetalhes;
  Builder.BuilderRodape;
end;

end.
