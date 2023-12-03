interface ITextFileActions
{
    procedure NewTextFile() ITextFileActions: Interface ITextFileActions;
    procedure AddText(textToAdd: Text) ITextFileActions: Interface ITextFileActions;
    procedure AddTextLine(lineText: Text) ITextFileActions: Interface ITextFileActions;
    procedure WriteToTempBlob() fileContent: Codeunit "Temp Blob"
    procedure DownloadTextFile(toFileName: Text) ITextFileActions: Interface ITextFileActions;
}