unit ConcreteBuilder;

interface

uses
  Produto,
  Builder,
  Data.DB,
  Datasnap.DBClient;

type
  TConcreteBuilder = class(TInterfacedObject, iBuilder)
    private
      FProduto: TProduto;
      FDados: olevariant;
      FQtdeRegistros: integer;
    public
      constructor Create(Dados: olevariant);
      destructor Destroy; override;
      procedure BuilderCabecalho;
      procedure BuilderDetalhes;
      procedure builderRodape;
      function GetRelatorio : TProduto;
  end;

implementation

uses
  System.SysUtils;

procedure TConcreteBuilder.BuilderCabecalho;
begin
  FProduto.Adicionar('<html><head><meta charset="UTF-8">');

  FProduto.Adicionar('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">');
  FProduto.Adicionar('<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>');

  FProduto.Adicionar('</head>');
  FProduto.Adicionar('<div class="container">');
  FProduto.Adicionar('<div class="panel panel-default">');
  FProduto.Adicionar('<div class="panel-heading">');
  FProduto.Adicionar('<h4>Relatório de Fornecedores</h4>');
  FProduto.Adicionar('<h4>' + FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + '</h4>');
  FProduto.Adicionar('</div>');
end;

procedure TConcreteBuilder.BuilderDetalhes;
var
  DataSet: TClientDataSet;
begin
  FProduto.Adicionar('<table class="table table-fixed">');
  FProduto.Adicionar('<thead><tr>');
  FProduto.Adicionar('<th class="col-xs-2">Código</th>');
  FProduto.Adicionar('<th class="col-xs-8">Fornecedor</th>');
  FProduto.Adicionar('<th class="col-xs-2">Cidade</th>');
  FProduto.Adicionar('</tr></thead><tbody>');

  DataSet := TClientDataSet.Create(nil);
  try
    DataSet.Data := FDados;
    DataSet.First;

    while not DataSet.Eof do
    begin
      FProduto.Adicionar('<tr>');
      FProduto.Adicionar('<td class="col-xs-2">' + DataSet.FieldByName('VendorNo').AsString + '</td>');
      FProduto.Adicionar('<td class="col-xs-2">' + DataSet.FieldByName('VendorName').AsString + '</td>');
      FProduto.Adicionar('<td class="col-xs-2">' + DataSet.FieldByName('City').AsString + '</td>');
      FProduto.Adicionar('</tr>');

      Inc(FQtdeRegistros);

      DataSet.Next;
    end;

    FProduto.Adicionar('</tbody></table></div></div>');
  finally
    FreeAndNil(DataSet);
  end;
end;

procedure TConcreteBuilder.builderRodape;
begin
  FProduto.Adicionar('<div id="footer">');
  FProduto.Adicionar('<div class="container">');
  FProduto.Adicionar('<p class="text-center">Qtde de Registros: ' + IntToStr(FQtdeRegistros)+ '</p>');
  FProduto.Adicionar('</div></div></body></html>');
end;

constructor TConcreteBuilder.Create(Dados: olevariant);
begin
  FQtdeRegistros := 0;
  FDados := Dados;
  FProduto := TProduto.Create;
end;

destructor TConcreteBuilder.Destroy;
begin
  FreeAndNil(FProduto);
  inherited;
end;

function TConcreteBuilder.GetRelatorio: TProduto;
begin
  Result := FProduto;
end;

end.
