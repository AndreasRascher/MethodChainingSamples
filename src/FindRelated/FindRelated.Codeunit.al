codeunit 50100 FindRelated
{
    procedure ForSalesHeader(SalesHeader: Record "Sales Header") ISalesHeader: Interface ISalesHeader
    begin
        FindRelatedImpl.SetStartPointRec(SalesHeader);
        exit(FindRelatedImpl);
    end;

    procedure ForPurchaseHeader(PurchaseHeader: Record "Purchase Header") IPurchaseHeader: Interface IPurchaseHeader
    begin
        FindRelatedImpl.SetStartPointRec(PurchaseHeader);
        exit(FindRelatedImpl);
    end;

    procedure ForSalesLine(SalesLine: Record "Sales Line") ISalesLine: Interface ISalesLine
    begin
        FindRelatedImpl.SetStartPointRec(SalesLine);
        exit(FindRelatedImpl);
    end;

    procedure ForPurchaseLine(PurchaseLine: Record "Purchase Line") IPurchaseLine: Interface IPurchaseLine
    begin
        FindRelatedImpl.SetStartPointRec(PurchaseLine);
        exit(FindRelatedImpl);
    end;

    procedure ForStandardText(StandardText: Record "Standard Text") IStandardText: Interface IStandardText
    begin
        FindRelatedImpl.SetStartPointRec(StandardText);
        exit(FindRelatedImpl);
    end;

    procedure ForCustomer(Customer: Record Customer) ICustomer: Interface ICustomer
    begin
        FindRelatedImpl.SetStartPointRec(Customer);
        exit(FindRelatedImpl);
    end;

    procedure ForItem(Item: Record Item) IItem: Interface IItem
    begin
        FindRelatedImpl.SetStartPointRec(Item);
        exit(FindRelatedImpl);
    end;

    var
        FindRelatedImpl: Codeunit FindRelatedImpl;
}