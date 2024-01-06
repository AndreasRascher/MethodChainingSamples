codeunit 50302 DownloadMgt
{
    procedure Package() IPackageActions: Interface IPackageActions
    var
        InnerDownloadMgt: Codeunit DownloadMgtImpl;
    begin
        exit(InnerDownloadMgt);
    end;

    procedure TextFile() ITextFileActions: Interface ITextFileActions
    var
        InnerDownloadMgt: Codeunit DownloadMgtImpl;
    begin
        exit(InnerDownloadMgt);
    end;
}