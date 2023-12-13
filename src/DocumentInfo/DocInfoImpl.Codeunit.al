codeunit 50304 DocInfoImpl implements DocInfoSalesAddress, DocInfo, RelatedTables
{
    procedure setHeaderRec(HeaderNew: Variant)
    begin
        CurrHeaderGlobal := HeaderNew;
    end;

    #region Address
    procedure SellToAddress(var AddrArray: array[8] of Text[100]);
    var
        formatAddr: Codeunit "Format Address";
        SalesHeader: Record "Sales Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        salesHeader := CurrHeaderGlobal;
        begin
            case true of
                GetSalesHeader(SalesHeader, CurrHeaderGlobal):
                    formatAddr.SalesHeaderSellTo(AddrArray, salesHeader);
                GetSalesInvHeader(SalesInvHeader, CurrHeaderGlobal):
                    formatAddr.SalesInvSellTo(AddrArray, SalesInvHeader);
                GetSalesCrMemoHeader(SalesCrMemoHeader, CurrHeaderGlobal):
                    formatAddr.SalesCrMemoSellTo(AddrArray, SalesCrMemoHeader);
                GetSalesShptHeader(SalesShipmentHeader, CurrHeaderGlobal):
                    formatAddr.SalesShptSellTo(AddrArray, SalesShipmentHeader);
                else
                    Error('unhandled case');
            end;
        end;
    end;

    procedure BillToAddress(var AddrArray: array[8] of Text[100]);
    var
        formatAddr: Codeunit "Format Address";
        AddrArray2: array[8] of Text[100];
        SalesHeader: Record "Sales Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        salesHeader := CurrHeaderGlobal;
        begin
            case true of
                GetSalesHeader(SalesHeader, CurrHeaderGlobal):
                    formatAddr.SalesHeaderBillTo(AddrArray, salesHeader);
                GetSalesInvHeader(SalesInvHeader, CurrHeaderGlobal):
                    formatAddr.SalesInvBillTo(AddrArray, SalesInvHeader);
                GetSalesCrMemoHeader(SalesCrMemoHeader, CurrHeaderGlobal):
                    formatAddr.SalesCrMemoBillTo(AddrArray, SalesCrMemoHeader);
                GetSalesShptHeader(SalesShipmentHeader, CurrHeaderGlobal):
                    begin
                        formatAddr.SalesShptShipTo(AddrArray2, SalesShipmentHeader);
                        formatAddr.SalesShptBillTo(AddrArray, AddrArray2, SalesShipmentHeader);
                    end;
                else
                    Error('unhandled case');
            end;
        end;
    end;

    procedure ShipToAddress(var AddrArray: array[8] of Text[100]);
    var
        formatAddr: Codeunit "Format Address";
        AddrArray2: array[8] of Text[100];
        SalesHeader: Record "Sales Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        salesHeader := CurrHeaderGlobal;
        begin
            case true of
                GetSalesHeader(SalesHeader, CurrHeaderGlobal):
                    formatAddr.SalesHeaderShipTo(AddrArray, AddrArray2, salesHeader);
                GetSalesInvHeader(SalesInvHeader, CurrHeaderGlobal):
                    formatAddr.SalesInvShipTo(AddrArray, AddrArray2, SalesInvHeader);
                GetSalesCrMemoHeader(SalesCrMemoHeader, CurrHeaderGlobal):
                    formatAddr.SalesCrMemoShipTo(AddrArray, AddrArray2, SalesCrMemoHeader);
                GetSalesShptHeader(SalesShipmentHeader, CurrHeaderGlobal):
                    formatAddr.SalesShptShipTo(AddrArray, SalesShipmentHeader);
                else
                    Error('unhandled case');
            end;
        end;
    end;

    procedure Address(): Interface DocInfoSalesAddress;
    var
        docInfoImpl: Codeunit DocInfoImpl;
    begin
        docInfoImpl.setHeaderRec(CurrHeaderGlobal);
        exit(docInfoImpl);
    end;
    #endregion Address
    procedure RelatedTables(): Interface RelatedTables;
    var
        docInfoImpl: Codeunit DocInfoImpl;
    begin
        docInfoImpl.setHeaderRec(CurrHeaderGlobal);
        exit(docInfoImpl);
    end;

    #region GetRecords
    local procedure GetSalesHeader(var SalesHeader: Record "Sales Header"; RecVariant: Variant) OK: Boolean
    var
        recRef: RecordRef;
    begin
        recRef.GetTable(RecVariant);
        OK := (recRef.Name = SalesHeader.TableName);
        if OK then
            recRef.SetTable(RecVariant);
    end;

    local procedure GetSalesInvHeader(var SalesInvoiceHeader: Record "Sales Invoice Header"; RecVariant: Variant) OK: Boolean
    var
        recRef: RecordRef;
    begin
        recRef.GetTable(RecVariant);
        OK := (recRef.Name = SalesInvoiceHeader.TableName);
        if OK then
            recRef.SetTable(RecVariant);
    end;

    local procedure GetSalesCrMemoHeader(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; RecVariant: Variant) OK: Boolean
    var
        recRef: RecordRef;
    begin
        recRef.GetTable(RecVariant);
        OK := (recRef.Name = SalesCrMemoHeader.TableName);
        if OK then
            recRef.SetTable(RecVariant);
    end;

    local procedure GetSalesShptHeader(var SalesShptHeader: Record "Sales Shipment Header"; RecVariant: Variant) OK: Boolean
    var
        recRef: RecordRef;
    begin
        recRef.GetTable(RecVariant);
        OK := (recRef.Name = SalesShptHeader.TableName);
        if OK then
            recRef.SetTable(RecVariant);
    end;
    #endregion GetRecords

    #region PaymentTerms    
    procedure PaymentTerms() PaymentTerms: Record "Payment Terms";
    begin
        PaymentTerms(PaymentTerms);
    end;

    procedure PaymentTerms(var PaymentTermsFound: Record "Payment Terms") Found: Boolean;
    var
        SalesHeader: Record "Sales Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        paymentTermsCode: Code[10];
    begin
        salesHeader := CurrHeaderGlobal;
        begin
            case true of
                GetSalesHeader(SalesHeader, CurrHeaderGlobal):
                    paymentTermsCode := SalesHeader."Payment Terms Code";
                GetSalesInvHeader(SalesInvHeader, CurrHeaderGlobal):
                    paymentTermsCode := SalesInvHeader."Payment Terms Code";
                GetSalesCrMemoHeader(SalesCrMemoHeader, CurrHeaderGlobal):
                    paymentTermsCode := SalesCrMemoHeader."Payment Terms Code";
                GetSalesShptHeader(SalesShipmentHeader, CurrHeaderGlobal):
                    paymentTermsCode := SalesShipmentHeader."Payment Terms Code";
                else
                    Error('unhandled case');
            end;
        end;
        Found := (paymentTermsCode <> '') and PaymentTermsFound.Get(paymentTermsCode);
    end;

    procedure PaymentTerms(var PaymentTerms: Record "Payment Terms"; LanguageCode: Code[10]) Found: Boolean;
    begin
        Found := PaymentTerms(PaymentTerms);
        if Found then
            PaymentTerms.TranslateDescription(PaymentTerms, LanguageCode);
    end;

    procedure PaymentTerms(LanguageCode: Code[10]) PaymentTerms: Record "Payment Terms";
    begin
        if not PaymentTerms(PaymentTerms) then
            exit;
        PaymentTerms.TranslateDescription(PaymentTerms, LanguageCode);
    end;
    #endregion PaymentTerms
    procedure ShipmentMethods() ShipmentMethods: Record "Shipment Method";
    begin

    end;

    procedure ShipmentMethods(var ShipmentMethodsFound: Record "Shipment Method") Found: Boolean;
    var
        SalesHeader: Record "Sales Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        shipmentMethodCode: Code[10];
    begin
        salesHeader := CurrHeaderGlobal;
        begin
            case true of
                GetSalesHeader(SalesHeader, CurrHeaderGlobal):
                    shipmentMethodCode := SalesHeader."Shipment Method Code";
                GetSalesInvHeader(SalesInvHeader, CurrHeaderGlobal):
                    shipmentMethodCode := SalesInvHeader."Shipment Method Code";
                GetSalesCrMemoHeader(SalesCrMemoHeader, CurrHeaderGlobal):
                    shipmentMethodCode := SalesCrMemoHeader."Shipment Method Code";
                GetSalesShptHeader(SalesShipmentHeader, CurrHeaderGlobal):
                    shipmentMethodCode := SalesShipmentHeader."Shipment Method Code";
                else
                    Error('unhandled case');
            end;
        end;
        Found := (shipmentMethodCode <> '') and ShipmentMethodsFound.Get(shipmentMethodCode);

    end;

    procedure ShipmentMethods(LanguageCode: Code[10]) ShipmentMethods: Record "Shipment Method";
    begin

    end;

    procedure ShipmentMethods(var ShipmentMethods: Record "Shipment Method"; LanguageCode: Code[10]) Found: Boolean;
    begin

    end;

    procedure SalespersonPurchaser(var SalespersonPurchaserFound: Record "Salesperson/Purchaser") Found: Boolean;
    begin

    end;

    procedure SalespersonPurchaser() SalespersonPurchaser: Record "Salesperson/Purchaser";
    begin

    end;

    var
        CurrHeaderGlobal: Variant;
}