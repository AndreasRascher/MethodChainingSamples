interface IPackageActions
{
    procedure New() IPackageActions: Interface IPackageActions
    procedure AddFile(InStream: InStream; fileName: Text) IPackageActions: Interface IPackageActions
    procedure AddFile(tempBlob: Codeunit "Temp Blob"; fileName: Text) IPackageActions: Interface IPackageActions
    procedure DownloadPackage(packageFileName: Text)
}