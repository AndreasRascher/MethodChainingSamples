codeunit 50105 DownloadMgtImpl implements IPackageActions, ITextFileActions
{
    var
        tempBlobListGlobal: Codeunit "Temp Blob List";
        fileNamesGlobal: Dictionary of [Integer, Text];
        TextFileContentGlobal: TextBuilder;

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
        InnerDownloadMgt.SetPackageVars(tempBlobListGlobal, fileNamesGlobal);
        exit(InnerDownloadMgt);
    end;

    procedure AddFile(var tempBlob: codeunit System.Utilities."Temp Blob"; fileName: Text) IPackageActions: Interface IPackageActions;
    var
        InnerDownloadMgt: Codeunit DownloadMgtImpl;
    begin
        tempBlobListGlobal.Add(tempBlob);
        fileNamesGlobal.Set(tempBlobListGlobal.Count(), fileName);
        InnerDownloadMgt.SetPackageVars(tempBlobListGlobal, fileNamesGlobal);
        exit(InnerDownloadMgt);
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

    internal procedure SetPackageVars(var tempBlobList: Codeunit System.Utilities."Temp Blob List"; fileNames: Dictionary of [Integer, Text])
    begin
        tempBlobListGlobal.AddRange(tempBlobList);
        fileNamesGlobal := fileNames;
    end;

    internal procedure SetTextfileVars(textFileContentNew: TextBuilder)
    begin
        TextFileContentGlobal := textFileContentNew;
    end;

    procedure NewTextFile() ITextFileActions: Interface ITextFileActions;
    var
        InnerDownloadMgt: Codeunit DownloadMgtImpl;
    begin
        Clear(TextFileContentGlobal);
        InnerDownloadMgt.SetTextfileVars(TextFileContentGlobal);
        exit(InnerDownloadMgt);
    end;

    procedure AddText(textToAppend: Text) ITextFileActions: Interface ITextFileActions;
    var
        InnerDownloadMgt: Codeunit DownloadMgtImpl;
    begin
        TextFileContentGlobal.Append(textToAppend);
        InnerDownloadMgt.SetTextfileVars(TextFileContentGlobal);
        exit(InnerDownloadMgt);
    end;

    procedure AddTextLine(lineText: Text) ITextFileActions: Interface ITextFileActions;
    var
        InnerDownloadMgt: Codeunit DownloadMgtImpl;
    begin
        TextFileContentGlobal.AppendLine(lineText);
        InnerDownloadMgt.SetTextfileVars(TextFileContentGlobal);
        exit(InnerDownloadMgt);
    end;

    procedure DownloadTextFile(toFileName: Text) ITextFileActions: Interface ITextFileActions;
    var
        InnerDownloadMgt: Codeunit DownloadMgtImpl;
        InS: InStream;
    begin
        WriteToTempBlob().CreateInStream(InS);
        DownloadFromStream(InS, '', '', '', toFileName);
        exit(InnerDownloadMgt);
    end;

    procedure WriteToTempBlob() fileContent: codeunit System.Utilities."Temp Blob";
    var
        OutS: OutStream;
    begin
        fileContent.CreateOutStream(OutS);
        OutS.WriteText(TextFileContentGlobal.ToText());
    end;
}
