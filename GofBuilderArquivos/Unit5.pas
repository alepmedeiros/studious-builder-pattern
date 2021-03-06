unit Unit5;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TForm5 = class(TForm)
    DBGrid1: TDBGrid;
    Button1: TButton;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses
  Diretor, Builder, Produto, ConcreteBuilder;

{$R *.dfm}

procedure TForm5.Button1Click(Sender: TObject);
var
  Diretor : TDiretor;
  ConcreteBuilder : iBuilder;
  Produto : TProduto;
begin
  Diretor := TDiretor.Create;
  ConcreteBuilder := TConcreteBuilder.Create(ClientDataSet1.Data);
  try
    Diretor.Construct(ConcreteBuilder);
    Produto := ConcreteBuilder.GetRelatorio;

    Produto.SalvarArquivo;
  finally
    FreeAndNil(Diretor);
  end;
end;

end.
