codeunit 50101 DownloadMgtTest
{
    trigger OnRun()
    var
        DownloadMgt: Codeunit DownloadMgt;
    begin
        initializeDummies();
        DownloadMgt.TextFile().
                        AddTextLine('Line 1').
                        AddTextLine('Line 2').
                        DownloadTextFile('sampleTextFile.txt');
        DownloadMgt.Package().
                        New().
                        AddFile(dummyFile1, 'dummyFile1.txt').
                        AddFile(dummyFile2, 'dummyFile2.txt').
                        DownloadPackage('Package.zip');
    end;

    local procedure initializeDummies()
    var
        OStr: OutStream;
        debug: Boolean;
    begin
        dummyTextBuilder.Append('TheDummyText');
        dummyFile1.CreateOutStream(OStr);
        OStr.WriteText('dummyFile1 content');
        debug := dummyFile1.HasValue();
        dummyFile2.CreateOutStream(OStr);
        OStr.WriteText('dummyFile2 content');
    end;

    var
        dummyTextBuilder: TextBuilder;
        dummyFile1, dummyFile2 : Codeunit "Temp Blob";

}