unit Builder;

interface

uses
  Produto;

type
  iBuilder = interface
    procedure BuilderCabecalho;
    procedure BuilderDetalhes;
    procedure builderRodape;
    function GetRelatorio : TProduto;
  end;

implementation

end.
