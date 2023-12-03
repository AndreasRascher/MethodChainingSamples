codeunit 50100 DownloadMgt
{
    procedure Package() IPackageActions: Interface IPackageActions
    var
        InnerDownloadMgt: Codeunit DownloadMgtImpl;
    begin
        exit(InnerDownloadMgt);
    end;
}