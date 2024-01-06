codeunit 50102 DocInfoImpl implements DocInfoSales, DocInfoPurchase, DocInfoSalesAddress, DocInfoPurchAddress, DocInfoRelatedTables, DocInfoPurchaseLine
{
    procedure setHeaderRec(HeaderNew: Variant)
    begin
        CurrRecordGlobal := HeaderNew;
    end;

    procedure RelatedTables(): Interface DocInfoRelatedTables;
    var
        docInfoImpl: Codeunit DocInfoImpl;
    begin
        docInfoImpl.setHeaderRec(CurrRecordGlobal);
        exit(docInfoImpl);
    end;

    #region SalesAddress
    procedure SalesAddress(): Interface DocInfoSalesAddress;
    var
        docInfoImpl: Codeunit DocInfoImpl;
    begin
        docInfoImpl.setHeaderRec(CurrRecordGlobal);
        exit(docInfoImpl);
    end;

    procedure SellToAddress(var AddrArray: array[8] of Text[100]);
    var
        formatAddr: Codeunit "Format Address";
        SalesHeader: Record "Sales Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        salesHeader := CurrRecordGlobal;
        begin
            case true of
                GetSalesHeader(SalesHeader, CurrRecordGlobal):
                    formatAddr.SalesHeaderSellTo(AddrArray, salesHeader);
                GetSalesInvHeader(SalesInvHeader, CurrRecordGlobal):
                    formatAddr.SalesInvSellTo(AddrArray, SalesInvHeader);
                GetSalesCrMemoHeader(SalesCrMemoHeader, CurrRecordGlobal):
                    formatAddr.SalesCrMemoSellTo(AddrArray, SalesCrMemoHeader);
                GetSalesShptHeader(SalesShipmentHeader, CurrRecordGlobal):
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
        salesHeader := CurrRecordGlobal;
        begin
            case true of
                GetSalesHeader(SalesHeader, CurrRecordGlobal):
                    formatAddr.SalesHeaderBillTo(AddrArray, salesHeader);
                GetSalesInvHeader(SalesInvHeader, CurrRecordGlobal):
                    formatAddr.SalesInvBillTo(AddrArray, SalesInvHeader);
                GetSalesCrMemoHeader(SalesCrMemoHeader, CurrRecordGlobal):
                    formatAddr.SalesCrMemoBillTo(AddrArray, SalesCrMemoHeader);
                GetSalesShptHeader(SalesShipmentHeader, CurrRecordGlobal):
                    begin
                        formatAddr.SalesShptShipTo(AddrArray2, SalesShipmentHeader);
                        formatAddr.SalesShptBillTo(AddrArray, AddrArray2, SalesShipmentHeader);
                    end;
                else
                    Error('unhandled case');
            end;
        end;
    end;

    // implements IDocInfoSalesAddress + IDocInfoPurchAddress
    procedure ShipToAddress(var AddrArray: array[8] of Text[100]);
    var
        formatAddr: Codeunit "Format Address";
        AddrArray2: array[8] of Text[100];
        purchaseHeader: Record "Purchase Header";
        purchInvHeader: Record "Purch. Inv. Header";
        purchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        purchRcptHeader: Record "Purch. Rcpt. Header";
        salesHeader: Record "Sales Header";
        salesInvHeader: Record "Sales Invoice Header";
        salesCrMemoHeader: Record "Sales Cr.Memo Header";
        salesShipmentHeader: Record "Sales Shipment Header";
    begin
        begin
            case true of
                GetSalesHeader(salesHeader, CurrRecordGlobal):
                    formatAddr.SalesHeaderShipTo(AddrArray, AddrArray2, salesHeader);
                GetSalesInvHeader(salesInvHeader, CurrRecordGlobal):
                    formatAddr.SalesInvShipTo(AddrArray, AddrArray2, salesInvHeader);
                GetSalesCrMemoHeader(salesCrMemoHeader, CurrRecordGlobal):
                    formatAddr.SalesCrMemoShipTo(AddrArray, AddrArray2, salesCrMemoHeader);
                GetSalesShptHeader(salesShipmentHeader, CurrRecordGlobal):
                    formatAddr.SalesShptShipTo(AddrArray, salesShipmentHeader);
                GetPurchaseHeader(purchaseHeader, CurrRecordGlobal):
                    formatAddr.PurchHeaderShipTo(AddrArray, purchaseHeader);
                GetPurchaseInvHeader(purchInvHeader, CurrRecordGlobal):
                    formatAddr.PurchInvShipTo(AddrArray, purchInvHeader);
                GetPurchCrMemoHeader(purchCrMemoHdr, CurrRecordGlobal):
                    formatAddr.PurchCrMemoShipTo(AddrArray, purchCrMemoHdr);
                GetPurchRcpHeader(purchRcptHeader, CurrRecordGlobal):
                    formatAddr.PurchRcptShipTo(AddrArray, purchRcptHeader);
                else
                    Error('unhandled case');
            end;
        end;
    end;
    #endregion SalesAddress
    #region DocInfoPurchaseAddress
    procedure PurchaseAddress(): Interface DocInfoPurchAddress;
    var
        docInfoImpl: Codeunit DocInfoImpl;
    begin
        docInfoImpl.setHeaderRec(CurrRecordGlobal);
        exit(docInfoImpl);
    end;

    procedure BuyFromAddress(var AddrArray: array[8] of Text[100]);
    var
        formatAddr: Codeunit "Format Address";
        AddrArray2: array[8] of Text[100];
        purchaseHeader: Record "Purchase Header";
        purchInvHeader: Record "Purch. Inv. Header";
        purchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        purchRcptHeader: Record "Purch. Rcpt. Header";
    begin
        begin
            case true of
                GetPurchaseHeader(purchaseHeader, CurrRecordGlobal):
                    formatAddr.PurchHeaderBuyFrom(AddrArray, purchaseHeader);
                GetPurchaseInvHeader(purchInvHeader, CurrRecordGlobal):
                    formatAddr.PurchInvBuyFrom(AddrArray, purchInvHeader);
                GetPurchCrMemoHeader(purchCrMemoHdr, CurrRecordGlobal):
                    formatAddr.PurchCrMemoBuyFrom(AddrArray, purchCrMemoHdr);
                GetPurchRcpHeader(purchRcptHeader, CurrRecordGlobal):
                    formatAddr.PurchRcptBuyFrom(AddrArray, purchRcptHeader);
                else
                    Error('unhandled case');
            end;
        end;
    end;


    procedure PayToAddress(var AddrArray: array[8] of Text[100]);
    var
        formatAddr: Codeunit "Format Address";
        AddrArray2: array[8] of Text[100];
        purchaseHeader: Record "Purchase Header";
        purchInvHeader: Record "Purch. Inv. Header";
        purchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        purchRcptHeader: Record "Purch. Rcpt. Header";
    begin
        begin
            case true of
                GetPurchaseHeader(purchaseHeader, CurrRecordGlobal):
                    formatAddr.PurchHeaderPayTo(AddrArray, purchaseHeader);
                GetPurchaseInvHeader(purchInvHeader, CurrRecordGlobal):
                    formatAddr.PurchInvPayTo(AddrArray, purchInvHeader);
                GetPurchCrMemoHeader(purchCrMemoHdr, CurrRecordGlobal):
                    formatAddr.PurchCrMemoPayTo(AddrArray, purchCrMemoHdr);
                GetPurchRcpHeader(purchRcptHeader, CurrRecordGlobal):
                    formatAddr.PurchRcptPayTo(AddrArray, purchRcptHeader);
                else
                    Error('unhandled case');
            end;
        end;
    end;
    #endregion DocInfoPurchaseAddress
    #region GetRecords
    local procedure GetSalesHeader(var SalesHeader: Record "Sales Header"; RecVariant: Variant) OK: Boolean
    var
        recRef: RecordRef;
    begin
        recRef.GetTable(RecVariant);
        OK := (recRef.Name = SalesHeader.TableName);
        if OK then
            recRef.SetTable(SalesHeader);
    end;

    local procedure GetPurchaseHeader(var PurchaseHeader: Record "Purchase Header"; RecVariant: Variant) OK: Boolean
    var
        recRef: RecordRef;
    begin
        recRef.GetTable(RecVariant);
        OK := (recRef.Name = PurchaseHeader.TableName);
        if OK then
            recRef.SetTable(PurchaseHeader);
    end;

    local procedure GetPurchaseLine(var PurchaseLine: Record "Purchase Line"; RecVariant: Variant) OK: Boolean
    var
        recRef: RecordRef;
    begin
        recRef.GetTable(RecVariant);
        OK := (recRef.Name = PurchaseLine.TableName);
        if OK then
            recRef.SetTable(PurchaseLine);
    end;

    local procedure GetSalesInvHeader(var SalesInvoiceHeader: Record "Sales Invoice Header"; RecVariant: Variant) OK: Boolean
    var
        recRef: RecordRef;
    begin
        recRef.GetTable(RecVariant);
        OK := (recRef.Name = SalesInvoiceHeader.TableName);
        if OK then
            recRef.SetTable(SalesInvoiceHeader);
    end;

    local procedure GetSalesCrMemoHeader(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; RecVariant: Variant) OK: Boolean
    var
        recRef: RecordRef;
    begin
        recRef.GetTable(RecVariant);
        OK := (recRef.Name = SalesCrMemoHeader.TableName);
        if OK then
            recRef.SetTable(SalesCrMemoHeader);
    end;

    local procedure GetSalesShptHeader(var SalesShptHeader: Record "Sales Shipment Header"; RecVariant: Variant) OK: Boolean
    var
        recRef: RecordRef;
    begin
        recRef.GetTable(RecVariant);
        OK := (recRef.Name = SalesShptHeader.TableName);
        if OK then
            recRef.SetTable(SalesShptHeader);
    end;

    local procedure GetPurchaseInvHeader(purchInvHeader: Record "Purch. Inv. Header"; RecVariant: Variant) OK: Boolean
    var
        recRef: RecordRef;
    begin
        recRef.GetTable(RecVariant);
        OK := (recRef.Name = purchInvHeader.TableName);
        if OK then
            recRef.SetTable(purchInvHeader);
    end;

    local procedure GetPurchCrMemoHeader(purchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; RecVariant: Variant) OK: Boolean
    var
        recRef: RecordRef;
    begin
        recRef.GetTable(RecVariant);
        OK := (recRef.Name = purchCrMemoHdr.TableName);
        if OK then
            recRef.SetTable(purchCrMemoHdr);
    end;

    local procedure GetPurchRcpHeader(purchRcptHeader: Record "Purch. Rcpt. Header"; RecVariant: Variant) OK: Boolean
    var
        recRef: RecordRef;
    begin
        recRef.GetTable(RecVariant);
        OK := (recRef.Name = purchRcptHeader.TableName);
        if OK then
            recRef.SetTable(purchRcptHeader);
    end;
    #endregion GetRecords
    #region PaymentTerms    
    procedure PaymentTerms() PaymentTerms: Record "Payment Terms";
    begin
        PaymentTerms(PaymentTerms);
    end;

    procedure PaymentTerms(var PaymentTermsFound: Record "Payment Terms") Found: Boolean;
    var
        paymentTermsCode: text;
        tableRelationCodes: Dictionary of [Integer, Text];
    begin
        readTableRelationCodes(tableRelationCodes);
        if tableRelationCodes.Get(PaymentTermsFound.RecordId.TableNo, paymentTermsCode) then
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
    #region ShipmentMethod
    procedure ShipmentMethod() ShipmentMethod: Record "Shipment Method";
    begin
        ShipmentMethod(ShipmentMethod);
    end;

    procedure ShipmentMethod(var ShipmentMethodsFound: Record "Shipment Method") Found: Boolean;
    var
        shipmentMethodCode: Text;
        tableRelationCodes: Dictionary of [Integer, Text];
    begin
        readTableRelationCodes(tableRelationCodes);
        if tableRelationCodes.Get(ShipmentMethodsFound.RecordId.TableNo, shipmentMethodCode) then
            Found := (shipmentMethodCode <> '') and ShipmentMethodsFound.Get(shipmentMethodCode);
    end;

    procedure ShipmentMethod(LanguageCode: Code[10]) ShipmentMethod: Record "Shipment Method";
    begin
        if not ShipmentMethod(ShipmentMethod) then
            exit;
        ShipmentMethod.TranslateDescription(ShipmentMethod, LanguageCode);
    end;

    procedure ShipmentMethod(var ShipmentMethod: Record "Shipment Method"; LanguageCode: Code[10]) Found: Boolean;
    begin
        Found := ShipmentMethod(ShipmentMethod);
        ShipmentMethod.TranslateDescription(ShipmentMethod, LanguageCode);
    end;
    #endregion ShipmentMethod
    #region SalespersonPurchaser
    procedure SalespersonPurchaser(var SalespersonPurchaserFound: Record "Salesperson/Purchaser") Found: Boolean;
    var
        SalespersonPurchaserCode: Text;
        tableRelationCodes: Dictionary of [Integer, Text];
    begin
        readTableRelationCodes(tableRelationCodes);
        if tableRelationCodes.Get(SalespersonPurchaserFound.RecordId.TableNo, SalespersonPurchaserCode) then
            Found := (SalespersonPurchaserCode <> '') and SalespersonPurchaserFound.Get(SalespersonPurchaserCode);
    end;

    procedure SalespersonPurchaser() SalespersonPurchaser: Record "Salesperson/Purchaser";
    begin
        SalespersonPurchaser(SalespersonPurchaser);
    end;
    #endregion SalespersonPurchaser
    #region resolveTableRelation
    /// <summary>
    /// collect code vaues indexed by the related table id
    /// </summary>
    procedure readTableRelationCodes(var tableRelationCodes: Dictionary of [Integer, Text])
    var
        SalesHeader: Record "Sales Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        purchaseHeader: Record "Purchase Header";
        purchInvHeader: Record "Purch. Inv. Header";
        purchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        purchRcptHeader: Record "Purch. Rcpt. Header";
    begin
        case true of
            GetSalesHeader(SalesHeader, CurrRecordGlobal):
                begin
                    tableRelationCodes.Add(SalesHeader.Relation("Shipment Method Code"), SalesHeader."Shipment Method Code");
                    tableRelationCodes.Add(SalesHeader.Relation("Shipping Agent Code"), SalesHeader."Shipping Agent Code");
                    tableRelationCodes.Add(SalesHeader.Relation("Shipping Agent Service Code"), SalesHeader."Shipping Agent Service Code");
                    tableRelationCodes.Add(SalesHeader.Relation("Payment Terms Code"), SalesHeader."Payment Terms Code");
                    tableRelationCodes.Add(SalesHeader.Relation("Payment Method Code"), SalesHeader."Payment Method Code");
                    tableRelationCodes.Add(SalesHeader.Relation("Language Code"), SalesHeader."Language Code");
                    tableRelationCodes.Add(SalesHeader.Relation("Salesperson Code"), SalesHeader."Salesperson Code");
                end;
            GetSalesInvHeader(SalesInvHeader, CurrRecordGlobal):
                begin
                    tableRelationCodes.Add(SalesInvHeader.Relation("Shipment Method Code"), SalesInvHeader."Shipment Method Code");
                    tableRelationCodes.Add(SalesInvHeader.Relation("Shipping Agent Code"), SalesInvHeader."Shipping Agent Code");
                    tableRelationCodes.Add(SalesInvHeader.Relation("Payment Terms Code"), SalesInvHeader."Payment Terms Code");
                    tableRelationCodes.Add(SalesInvHeader.Relation("Payment Method Code"), SalesInvHeader."Payment Method Code");
                    tableRelationCodes.Add(SalesInvHeader.Relation("Language Code"), SalesInvHeader."Language Code");
                    tableRelationCodes.Add(SalesInvHeader.Relation("Salesperson Code"), SalesInvHeader."Salesperson Code");
                end;
            GetSalesCrMemoHeader(SalesCrMemoHeader, CurrRecordGlobal):
                begin
                    tableRelationCodes.Add(SalesCrMemoHeader.Relation("Shipment Method Code"), SalesCrMemoHeader."Shipment Method Code");
                    tableRelationCodes.Add(SalesCrMemoHeader.Relation("Shipping Agent Code"), SalesCrMemoHeader."Shipping Agent Code");
                    tableRelationCodes.Add(SalesCrMemoHeader.Relation("Shipping Agent Service Code"), SalesCrMemoHeader."Shipping Agent Service Code");
                    tableRelationCodes.Add(SalesCrMemoHeader.Relation("Payment Terms Code"), SalesCrMemoHeader."Payment Terms Code");
                    tableRelationCodes.Add(SalesCrMemoHeader.Relation("Payment Method Code"), SalesCrMemoHeader."Payment Method Code");
                    tableRelationCodes.Add(SalesCrMemoHeader.Relation("Language Code"), SalesCrMemoHeader."Language Code");
                    tableRelationCodes.Add(SalesCrMemoHeader.Relation("Salesperson Code"), SalesCrMemoHeader."Salesperson Code");
                end;
            GetSalesShptHeader(SalesShipmentHeader, CurrRecordGlobal):
                begin
                    tableRelationCodes.Add(SalesShipmentHeader.Relation("Shipment Method Code"), SalesShipmentHeader."Shipment Method Code");
                    tableRelationCodes.Add(SalesShipmentHeader.Relation("Shipping Agent Code"), SalesShipmentHeader."Shipping Agent Code");
                    tableRelationCodes.Add(SalesShipmentHeader.Relation("Shipping Agent Service Code"), SalesShipmentHeader."Shipping Agent Service Code");
                    tableRelationCodes.Add(SalesShipmentHeader.Relation("Payment Terms Code"), SalesShipmentHeader."Payment Terms Code");
                    tableRelationCodes.Add(SalesShipmentHeader.Relation("Payment Method Code"), SalesShipmentHeader."Payment Method Code");
                    tableRelationCodes.Add(SalesShipmentHeader.Relation("Language Code"), SalesShipmentHeader."Language Code");
                    tableRelationCodes.Add(SalesShipmentHeader.Relation("Salesperson Code"), SalesShipmentHeader."Salesperson Code");
                end;

            GetPurchaseHeader(purchaseHeader, CurrRecordGlobal):
                begin
                    tableRelationCodes.Add(purchaseHeader.Relation("Shipment Method Code"), purchaseHeader."Shipment Method Code");
                    tableRelationCodes.Add(purchaseHeader.Relation("Purchaser Code"), purchaseHeader."Purchaser Code");
                    tableRelationCodes.Add(purchaseHeader.Relation("Payment Terms Code"), purchaseHeader."Payment Terms Code");
                    tableRelationCodes.Add(purchaseHeader.Relation("Payment Method Code"), purchaseHeader."Payment Method Code");
                    tableRelationCodes.Add(purchaseHeader.Relation("Language Code"), purchaseHeader."Language Code");
                end;
            GetPurchaseInvHeader(purchInvHeader, CurrRecordGlobal):
                begin
                    tableRelationCodes.Add(purchInvHeader.Relation("Shipment Method Code"), purchInvHeader."Shipment Method Code");
                    tableRelationCodes.Add(purchInvHeader.Relation("Purchaser Code"), purchInvHeader."Purchaser Code");
                    tableRelationCodes.Add(purchInvHeader.Relation("Payment Terms Code"), purchInvHeader."Payment Terms Code");
                    tableRelationCodes.Add(purchInvHeader.Relation("Payment Method Code"), purchInvHeader."Payment Method Code");
                    tableRelationCodes.Add(purchInvHeader.Relation("Language Code"), purchInvHeader."Language Code");
                end;
            GetPurchCrMemoHeader(purchCrMemoHdr, CurrRecordGlobal):
                begin
                    tableRelationCodes.Add(purchCrMemoHdr.Relation("Shipment Method Code"), purchCrMemoHdr."Shipment Method Code");
                    tableRelationCodes.Add(purchCrMemoHdr.Relation("Purchaser Code"), purchCrMemoHdr."Purchaser Code");
                    tableRelationCodes.Add(purchCrMemoHdr.Relation("Payment Terms Code"), purchCrMemoHdr."Payment Terms Code");
                    tableRelationCodes.Add(purchCrMemoHdr.Relation("Payment Method Code"), purchCrMemoHdr."Payment Method Code");
                    tableRelationCodes.Add(purchCrMemoHdr.Relation("Language Code"), purchCrMemoHdr."Language Code");
                end;
            GetPurchRcpHeader(purchRcptHeader, CurrRecordGlobal):
                begin
                    tableRelationCodes.Add(purchRcptHeader.Relation("Shipment Method Code"), purchRcptHeader."Shipment Method Code");
                    tableRelationCodes.Add(purchRcptHeader.Relation("Purchaser Code"), purchRcptHeader."Purchaser Code");
                    tableRelationCodes.Add(purchRcptHeader.Relation("Payment Terms Code"), purchRcptHeader."Payment Terms Code");
                    tableRelationCodes.Add(purchRcptHeader.Relation("Payment Method Code"), purchRcptHeader."Payment Method Code");
                    tableRelationCodes.Add(purchRcptHeader.Relation("Language Code"), purchRcptHeader."Language Code");
                end;
            else
                Error('unhandled case');
        end;
    end;
    #endregion resolveTableRelation
    #region DocInfoPurchaseLine
    procedure TrackingSpecification(var tempTrackingSpecBuffer: Record "Tracking Specification" temporary) NoOfTrackingLinesFound: Integer
    var
        ItemTrackingDocManagement: Codeunit "Item Tracking Doc. Management";
        purchaseLine: Record "Purchase Line";
    begin
        if not GetPurchaseLine(purchaseLine, CurrRecordGlobal) then
            exit(0);
        NoOfTrackingLinesFound := ItemTrackingDocManagement.RetrieveDocumentItemTracking(tempTrackingSpecBuffer,
                                                               purchaseLine."Document No.",
                                                               Database::"Purchase Header",
                                                               purchaseLine."Document Type".AsInteger());
        tempTrackingSpecBuffer.SetRange("Source Ref. No.", purchaseLine."Line No.");
        NoOfTrackingLinesFound := tempTrackingSpecBuffer.Count;
    end;
    #endregion DocInfoPurchaseLine

    var
        CurrRecordGlobal: Variant;

    procedure Item(var item: Record Item) ItemFound: Boolean;
    var
        purchaseLine: Record "Purchase Line";
    begin
        if not GetPurchaseLine(purchaseLine, CurrRecordGlobal) then
            exit(false);
        ItemFound := not (false in [purchaseLine.Type = purchaseLine.Type::Item, purchaseLine."No." <> '', item.get(purchaseLine."No.")]);
    end;
}