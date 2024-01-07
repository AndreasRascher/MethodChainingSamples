codeunit 50301 DownloadMgtTest
{
    trigger OnRun()
    var
        DownloadMgt: Codeunit DownloadMgt;
    begin
        // Sample: add textfile and download as zip package
        DownloadMgt.Package().AddFile(File1TempBlob, '123.test').DownloadPackage('1.zip');
        // Sample: create textfile, add 2 lines and start download in one go
        DownloadMgt.TextFile().
                        AddTextLine('Line 1').
                        AddTextLine('Line 2').
                        DownloadTextFile('sampleTextFile.txt');

        // Sample: create zip package with 3 text files.
        InitFileTempBlobs();
        DownloadMgt.Package().
                        New().
                        AddFile(File1TempBlob, 'dummyFile1.txt').
                        AddFile(File2TempBlob, 'dummyFile2.txt').
                        // Add new textfile - defined inline
                        AddFile(DownloadMgt.TextFile().AddText('Content File 3').AsTempBlob(), 'dummyFile3.txt').
                        DownloadPackage('Package.zip');
    end;

    local procedure InitFileTempBlobs()
    var
        OStr: OutStream;
        debug: Boolean;
    begin
        dummyTextBuilder.Append('TheDummyText');
        File1TempBlob.CreateOutStream(OStr);
        OStr.WriteText('dummyFile1 content');
        debug := File1TempBlob.HasValue();
        File2TempBlob.CreateOutStream(OStr);
        OStr.WriteText('dummyFile2 content');
    end;

    var
        dummyTextBuilder: TextBuilder;
        File1TempBlob, File2TempBlob : Codeunit "Temp Blob";

}