codeunit 50303 DocInfoTests
{
    trigger OnRun()
    var
        docInfo: Codeunit DocInfo;
        salesHeader: Record "Sales Header";
        addrArray: array[8] of Text[100];
    begin
        salesHeader.FindFirst();
        docInfo.From(salesHeader).Address().SellToAddress(addrArray);
        docInfo.From(salesHeader).Address().BillToAddress(addrArray);
        docInfo.From(salesHeader).Address().ShipToAddress(addrArray);
        docInfo.From(salesHeader).RelatedTables().PaymentTerms();
        docInfo.From(salesHeader).RelatedTables().ShipmentMethods();
    end;
}