codeunit 50102 DocInfo
{
    procedure From(SalesHeader: Record "Sales Header"): Interface DocInfo
    var
        documentInfoInternal: Codeunit DocInfoImpl;
    begin
        documentInfoInternal.setHeaderRec(SalesHeader);
        exit(documentInfoInternal);
    end;

    procedure From(salesInvHeader: Record "Sales Invoice Header"): Interface DocInfo
    var
        documentInfoInternal: Codeunit DocInfoImpl;
    begin
        documentInfoInternal.setHeaderRec(salesInvHeader);
        exit(documentInfoInternal);
    end;

    procedure From(salesShipmentHeader: Record "Sales Shipment Header"): Interface DocInfo
    var
        documentInfoInternal: Codeunit DocInfoImpl;
    begin
        documentInfoInternal.setHeaderRec(salesShipmentHeader);
        exit(documentInfoInternal);
    end;

}