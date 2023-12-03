interface IPackageActions
{
    procedure New() IPackageActions: Interface IPackageActions
    procedure AddFile(InStream: InStream; fileName: Text) IPackageActions: Interface IPackageActions
    procedure AddFile(var tempBlob: Codeunit "Temp Blob"; fileName: Text) IPackageActions: Interface IPackageActions
    procedure AddContent(var textBuilderContent: TextBuilder) IPackageActions: Interface IPackageActions
    procedure AddContent(var Text: Text) IPackageActions: Interface IPackageActions
    procedure DownloadPackage(packageFileName: Text)
}