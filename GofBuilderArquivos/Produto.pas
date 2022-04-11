unit Produto;

interface

uses
  System.Classes;

type
  TProduto = class
    private
      FConteudoHTML: TStringList;
    public
      constructor Create;
      destructor Destroy; override;

      procedure Adicionar(const Texto : String);

      procedure SalvarArquivo;
  end;

implementation

uses
  Vcl.Dialogs, System.SysUtils;

{ TProduto }

procedure TProduto.Adicionar(const Texto: String);
begin
  FConteudoHTML.Add(Texto);
end;

constructor TProduto.Create;
begin
  FConteudoHTML := TStringList.Create;
end;

destructor TProduto.Destroy;
begin
  FreeAndNil(FConteudoHTML);
  inherited;
end;

procedure TProduto.SalvarArquivo;
var
  SaveDialog: TSaveDialog;
begin
  SaveDialog := TSaveDialog.Create(nil);
  try
    SaveDialog.Execute;
    FConteudoHTML.SaveToFile(SaveDialog.FileName);
  finally
    FreeAndNil(SaveDialog);
  end;
end;

end.
