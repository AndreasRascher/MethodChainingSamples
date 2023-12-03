codeunit 50105 DownloadMgtImpl implements IPackageActions
{
    var
        ContentGlobal: TextBuilder;
        DownloadFileNameGlobal: Text;
        requestedExtensionsFiltersGlobal: List of [Text];
        tempBlobListGlobal: Codeunit "Temp Blob List";
        fileNamesGlobal: Dictionary of [Integer, Text];

    procedure New() IPackageActions: Interface IPackageActions;
    var
        InnerDownloadMgt: Codeunit DownloadMgtImpl;
    begin
        exit(InnerDownloadMgt);
    end;

    procedure AddFile(inS: InStream; fileName: Text) IPackageActions: Interface IPackageActions;
    var
        tempBlob: Codeunit "Temp Blob";
        outS: OutStream;
        InnerDownloadMgt: Codeunit DownloadMgtImpl;
    begin
        tempBlob.CreateOutStream(outS);
        CopyStream(outS, inS);
        AddFile(tempBlob, fileName);
        InnerDownloadMgt.Set(tempBlobListGlobal, fileNamesGlobal);
        exit(InnerDownloadMgt);
    end;

    procedure AddFile(var tempBlob: codeunit System.Utilities."Temp Blob"; fileName: Text) IPackageActions: Interface IPackageActions;
    var
        InnerDownloadMgt: Codeunit DownloadMgtImpl;
    begin
        tempBlobListGlobal.Add(tempBlob);
        fileNamesGlobal.Set(tempBlobListGlobal.Count(), fileName);
        InnerDownloadMgt.Set(tempBlobListGlobal, fileNamesGlobal);
        exit(InnerDownloadMgt);
    end;

    procedure AddContent(var textBuilderContent: TextBuilder) IPackageActions: Interface IPackageActions;
    begin

    end;

    procedure AddContent(var Text: Text) IPackageActions: Interface IPackageActions;
    begin

    end;

    procedure DownloadPackage(packageFileName: Text);
    var
        dataCompression: Codeunit "Data Compression";
        index: Integer;
        tempBlob: Codeunit "Temp Blob";
        fileName: Text;
        IStr: InStream;
        OStr: OutStream;
    begin
        begin
            dataCompression.CreateZipArchive();
            for Index := 1 to fileNamesGlobal.Count do begin
                FileName := fileNamesGlobal.Get(Index);
                tempBlobListGlobal.Get(index, tempBlob);
                tempBlob.CreateInStream(IStr);
                dataCompression.AddEntry(IStr, FileName);
            end;
            Clear(tempBlob);
            tempBlob.CreateOutStream(OStr);
            dataCompression.SaveZipArchive(OStr);
            tempBlob.CreateInStream(IStr);
            FileName := packageFileName;
            DownloadFromStream(IStr, 'Download', '', '', FileName);
        end;
    end;

    internal procedure Set(var tempBlobList: Codeunit System.Utilities."Temp Blob List"; fileNames: Dictionary of [Integer, Text])
    begin
        tempBlobListGlobal.AddRange(tempBlobList);
        fileNamesGlobal := fileNames;
    end;

}
