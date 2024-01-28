// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50300 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        // DownloadMgtTest: Codeunit DownloadMgtTest;
        // DocInfoTests: Codeunit doc;
        docInfo: Codeunit DocInfo;
        purchaseHeader: Record "Purchase Header";
        purchaseLine: Record "Purchase Line";
        tempTrackingSpecBuffer: Record "Tracking Specification" temporary;
    begin
        DocInfo.From(purchaseHeader).RelatedTables().PaymentTerms();
        docInfo.From(purchaseLine).TrackingSpecification(tempTrackingSpecBuffer);
        // DocInfoTests.Run();
        // tempBlobTest();
        // DownloadMgtTest.Run();
    end;

    procedure tempBlobTest()
    var
        tempBlob: Codeunit "Temp Blob";
        OutS: OutStream;
    begin
        tempBlob.CreateOutStream(OutS);
        OutS.WriteText('sample');
        tempBlobTest(tempBlob);
    end;

    procedure tempBlobTest(tempBlob: Codeunit "Temp Blob")
    var
        Success: Boolean;
        InS: InStream;
        Content: Text;
    begin
        Success := tempBlob.HasValue();
        tempBlob.CreateInStream(InS);
        InS.ReadText(Content);
    end;
}