codeunit 50104 DocInfo
{
    procedure From(SalesHeader: Record "Sales Header"): Interface DocInfoSales
    var
        documentInfoInternal: Codeunit DocInfoImpl;
    begin
        documentInfoInternal.setHeaderRec(SalesHeader);
        exit(documentInfoInternal);
    end;

    procedure From(salesInvHeader: Record "Sales Invoice Header"): Interface DocInfoSales
    var
        documentInfoInternal: Codeunit DocInfoImpl;
    begin
        documentInfoInternal.setHeaderRec(salesInvHeader);
        exit(documentInfoInternal);
    end;

    procedure From(salesShipmentHeader: Record "Sales Shipment Header"): Interface DocInfoSales
    var
        documentInfoInternal: Codeunit DocInfoImpl;
    begin
        documentInfoInternal.setHeaderRec(salesShipmentHeader);
        exit(documentInfoInternal);
    end;

    procedure From(purchaseHeader: Record "Purchase Header"): Interface DocInfoPurchase
    var
        documentInfoInternal: Codeunit DocInfoImpl;
    begin
        documentInfoInternal.setHeaderRec(purchaseHeader);
        exit(documentInfoInternal);
    end;

    procedure From(purchaseLine: Record "Purchase Line"): Interface DocInfoPurchaseLine
    var
        documentInfoInternal: Codeunit DocInfoImpl;
    begin
        documentInfoInternal.setHeaderRec(purchaseLine);
        exit(documentInfoInternal);
    end;

    procedure From(PurchaseInvHeader: Record "Purch. Inv. Header"): Interface DocInfoPurchase
    var
        documentInfoInternal: Codeunit DocInfoImpl;
    begin
        documentInfoInternal.setHeaderRec(PurchaseInvHeader);
        exit(documentInfoInternal);
    end;

    procedure From(PurchaseRcptHeader: Record "Purch. Rcpt. Header"): Interface DocInfoPurchase
    var
        documentInfoInternal: Codeunit DocInfoImpl;
    begin
        documentInfoInternal.setHeaderRec(PurchaseRcptHeader);
        exit(documentInfoInternal);
    end;

}