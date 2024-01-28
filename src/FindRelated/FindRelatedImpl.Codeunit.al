codeunit 50103 FindRelatedImpl implements ISalesHeader,
                                          ISalesAddress,
                                          ISalesLine,
                                          IPurchaseHeader,
                                          IPurchaseLine,
                                          IPurchaseAddress,
                                          ICustomer,
                                          IStandardText,
                                          IItem
{
    #region GetSetMethods
    var
        StartPointVariant: Variant;
        // RelatedToTableID, RelationFieldNo, FieldName, FieldValue
        RelationDataGlobal: Dictionary of [Integer/*RelatedToTableID*/, Dictionary of [Integer/*RelationFieldNo*/, List of [Text]]];

    procedure SetStartPointRec(StartPointVariantNew: Variant);
    begin
        Clear(RelationDataGlobal);
        StartPointVariant := StartPointVariantNew;
        SetTableRelationCodes();
    end;

    local procedure SetTableRelationCodes();
    var
        RecRef: RecordRef;
        i: Integer;
        relatedToTableID: Integer;
        relatedTableRef: RecordRef;
        relationFieldContent: Text;
        fieldRelations: Dictionary of [Integer, List of [Text]]; // Integer=Field No, List1: Field Name List2: Value
        fieldInfo: List of [Text]; // 1: Field Name 2: Value
    begin
        RecRef.GetTable(StartPointVariant);
        for i := 1 to RecRef.FieldCount do begin
            Clear(fieldInfo);
            Clear(fieldRelations);
            relatedToTableID := RecRef.FieldIndex(i).Relation;
            if relatedToTableID <> 0 then begin
                relatedTableRef.Open(relatedToTableID);
                // only table relations with matching field types are considered
                if relatedTableRef.KeyIndex(1).FieldIndex(1).Type = RecRef.FieldIndex(i).Type then begin

                    relationFieldContent := Format(RecRef.FieldIndex(i).Value, 0, 9);
                    fieldInfo.Add(RecRef.FieldIndex(i).Name);
                    fieldInfo.Add(relationFieldContent);

                    if not RelationDataGlobal.Get(relatedToTableID, fieldRelations) then;
                    fieldRelations.Add(RecRef.FieldIndex(i).Number, fieldInfo);
                    RelationDataGlobal.Set(relatedToTableID, fieldRelations);
                end;
                relatedTableRef.Close();
            end;
        end;
    end;

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

    local procedure GetCustomer(var Customer: Record Customer; RecVariant: Variant) OK: Boolean
    var
        recRef: RecordRef;
    begin
        recRef.GetTable(RecVariant);
        OK := (recRef.Name = Customer.TableName);
        if OK then
            recRef.SetTable(Customer);
    end;

    local procedure RelationData_GetFirstForTable(TableNo: Integer) Value: Text
    var
        fieldRelations: Dictionary of [Integer, List of [Text]]; // Integer=Field No, List1: Field Name List2: Value
        fieldInfo: List of [Text]; // 1: Field Name 2: Value
    begin
        fieldRelations := RelationDataGlobal.Get(TableNo);
        fieldInfo := fieldRelations.Get(fieldRelations.Keys.Get(1));
        Value := fieldInfo.Get(2);
    end;

    local procedure RelationData_GetForTableAndField(TableNo: Integer; FromRelationFieldNo: Integer) Value: Text
    var
        fieldRelations: Dictionary of [Integer, List of [Text]]; // Integer=Field No, List1: Field Name List2: Value
        fieldInfo: List of [Text]; // 1: Field Name 2: Value
    begin
        fieldRelations := RelationDataGlobal.Get(TableNo);
        fieldInfo := fieldRelations.Get(FromRelationFieldNo);
        Value := fieldInfo.Get(2);
    end;
    #endregion GetSetMethods

    #region ISalesHeader Members
    procedure FilterSalesLines(var salesLines: Record "Sales Line") HasLines: Boolean;
    var
        salesHeader: Record "Sales Header";
    begin
        salesHeader := StartPointVariant;
        if salesHeader."No." = '' then
            exit(false);
        salesLines.SetRange("Document Type", salesHeader."Document Type");
        salesLines.SetRange("Document No.", salesHeader."No.");
        HasLines := not salesLines.IsEmpty();
    end;

    procedure PaymentTerms(var PaymentTerms: Record "Payment Terms") Found: Boolean;
    begin
        if RelationDataGlobal.ContainsKey(PaymentTerms.RecordId.TableNo) then
            Found := PaymentTerms.Get(RelationData_GetFirstForTable(PaymentTerms.RecordId.TableNo));
    end;

    procedure ShipmentMethod(var ShipmentMethod: Record "Shipment Method") Found: Boolean;
    begin
        if RelationDataGlobal.ContainsKey(ShipmentMethod.RecordId.TableNo) then
            Found := ShipmentMethod.Get(RelationData_GetFirstForTable(ShipmentMethod.RecordId.TableNo));
    end;

    procedure Salesperson(var Salesperson: Record "Salesperson/Purchaser") Found: Boolean;
    begin
        if RelationDataGlobal.ContainsKey(Salesperson.RecordId.TableNo) then
            Found := Salesperson.Get(RelationData_GetFirstForTable(Salesperson.RecordId.TableNo));
    end;

    procedure BillToCustomer(var billToCustomer: Record Customer) Found: Boolean;
    var
        salesHeader: Record "Sales Header";
        customer: Record Customer;
    begin
        case true of
            getSalesHeader(salesHeader, StartPointVariant):
                Found := billToCustomer.get(salesHeader."Bill-to Customer No.");
            GetCustomer(customer, StartPointVariant):
                Found := billToCustomer.get(customer."Bill-to Customer No.");
            else
                Error('unhandled case');
        end;
    end;

    procedure SellToCustomer(var SellToCustomer: Record Customer) Found: Boolean;
    var
        salesHeader: Record "Sales Header";
    begin
        salesHeader := StartPointVariant;
        Found := billToCustomer.get(salesHeader."Sell-to Customer No.");
    end;

    procedure SalesAddress() ISalesAddress: Interface ISalesAddress;
    var
        FindRelatedImpl: Codeunit FindRelatedImpl;
    begin
        FindRelatedImpl.SetStartPointRec(StartPointVariant);
        exit(FindRelatedImpl);
    end;
    #endregion ISalesHeader Members

    #region ISalesAddress Members
    procedure SellToAddress(var AddrArray: array[8] of Text[100]);
    var
        formatAddr: Codeunit "Format Address";
        SalesHeader: Record "Sales Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        salesHeader := StartPointVariant;
        begin
            case true of
                GetSalesHeader(SalesHeader, StartPointVariant):
                    formatAddr.SalesHeaderSellTo(AddrArray, salesHeader);
                GetSalesInvHeader(SalesInvHeader, StartPointVariant):
                    formatAddr.SalesInvSellTo(AddrArray, SalesInvHeader);
                GetSalesCrMemoHeader(SalesCrMemoHeader, StartPointVariant):
                    formatAddr.SalesCrMemoSellTo(AddrArray, SalesCrMemoHeader);
                GetSalesShptHeader(SalesShipmentHeader, StartPointVariant):
                    formatAddr.SalesShptSellTo(AddrArray, SalesShipmentHeader);
                else
                    Error('unhandled case');
            end;
        end;
    end;

    procedure BillToAddress(var AddrArray: array[8] of Text[100]);
    begin

    end;
    #endregion ISalesAddress Members

    #region ISalesLine Members
    procedure Item(var Item: Record Item) Found: Boolean;
    begin

    end;

    #endregion ISalesLine Members

    #region IPurchaseHeader Members
    procedure FilterPurchaseLines(var PurchaseLines: Record "Purchase Line") HasLines: Boolean;
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader := StartPointVariant;
        if PurchaseHeader."No." = '' then
            exit(false);
        PurchaseLines.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLines.SetRange("Document No.", PurchaseHeader."No.");
        HasLines := not PurchaseLines.IsEmpty();
    end;

    procedure PurchasePerson(var Purchaseperson: Record "Salesperson/Purchaser") Found: Boolean;
    begin
        if RelationDataGlobal.ContainsKey(Purchaseperson.RecordId.TableNo) then
            Found := Purchaseperson.Get(RelationData_GetFirstForTable(Purchaseperson.RecordId.TableNo));
    end;

    procedure PurchaseAddress() IPurchaseAddress: Interface IPurchaseAddress;
    var
        FindRelatedImpl: Codeunit FindRelatedImpl;
    begin
        FindRelatedImpl.SetStartPointRec(StartPointVariant);
        exit(FindRelatedImpl);
    end;

    #endregion IPurchaseHeader Members

    #region IPurchaseAddress Members
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
                GetPurchaseHeader(purchaseHeader, StartPointVariant):
                    formatAddr.PurchHeaderBuyFrom(AddrArray, purchaseHeader);
                GetPurchaseInvHeader(purchInvHeader, StartPointVariant):
                    formatAddr.PurchInvBuyFrom(AddrArray, purchInvHeader);
                GetPurchCrMemoHeader(purchCrMemoHdr, StartPointVariant):
                    formatAddr.PurchCrMemoBuyFrom(AddrArray, purchCrMemoHdr);
                GetPurchRcpHeader(purchRcptHeader, StartPointVariant):
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
                GetPurchaseHeader(purchaseHeader, StartPointVariant):
                    formatAddr.PurchHeaderPayTo(AddrArray, purchaseHeader);
                GetPurchaseInvHeader(purchInvHeader, StartPointVariant):
                    formatAddr.PurchInvPayTo(AddrArray, purchInvHeader);
                GetPurchCrMemoHeader(purchCrMemoHdr, StartPointVariant):
                    formatAddr.PurchCrMemoPayTo(AddrArray, purchCrMemoHdr);
                GetPurchRcpHeader(purchRcptHeader, StartPointVariant):
                    formatAddr.PurchRcptPayTo(AddrArray, purchRcptHeader);
                else
                    Error('unhandled case');
            end;
        end;
    end;

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
                GetSalesHeader(salesHeader, StartPointVariant):
                    formatAddr.SalesHeaderShipTo(AddrArray, AddrArray2, salesHeader);
                GetSalesInvHeader(salesInvHeader, StartPointVariant):
                    formatAddr.SalesInvShipTo(AddrArray, AddrArray2, salesInvHeader);
                GetSalesCrMemoHeader(salesCrMemoHeader, StartPointVariant):
                    formatAddr.SalesCrMemoShipTo(AddrArray, AddrArray2, salesCrMemoHeader);
                GetSalesShptHeader(salesShipmentHeader, StartPointVariant):
                    formatAddr.SalesShptShipTo(AddrArray, salesShipmentHeader);
                GetPurchaseHeader(purchaseHeader, StartPointVariant):
                    formatAddr.PurchHeaderShipTo(AddrArray, purchaseHeader);
                GetPurchaseInvHeader(purchInvHeader, StartPointVariant):
                    formatAddr.PurchInvShipTo(AddrArray, purchInvHeader);
                GetPurchCrMemoHeader(purchCrMemoHdr, StartPointVariant):
                    formatAddr.PurchCrMemoShipTo(AddrArray, purchCrMemoHdr);
                GetPurchRcpHeader(purchRcptHeader, StartPointVariant):
                    formatAddr.PurchRcptShipTo(AddrArray, purchRcptHeader);
                else
                    Error('unhandled case');
            end;
        end;
    end;
    #endregion IPurchaseAddress Members

    #region ICustomer Members
    //procedure BillToCustomer(var BillToCustomer: Record Customer) Found: Boolean;
    //-> Defined in IsalesHeader
    procedure BillToCustomer() BillToCustomer: Record Customer;
    begin

    end;
    #endregion ICustomer Members

    #region IStandardText Members
    procedure ExtTextLines(var ExtTextLines: Record "Extended Text Line"; LanguageCode: Code[10]);
    begin

    end;

    procedure Item() IItem: Interface IItem;
    begin

    end;
    #endregion IStandardText Members

    #region IItem Members
    procedure CountryRegionOfOrigin(var countryRegion: Record "Country/Region") Found: Boolean;
    var
        item: Record Item;
    begin
        if RelationDataGlobal.ContainsKey(countryRegion.RecordId.TableNo) then
            Found := countryRegion.Get(RelationData_GetForTableAndField(countryRegion.RecordId.TableNo, item.FieldNo("Country/Region of Origin Code")));
    end;

    procedure CountryRegionOfOrigin() countryRegion: Record "Country/Region";
    begin
        CountryRegionOfOrigin(countryRegion);
    end;

    procedure findItemAttributeValue(var itemAttributeValue: Record "Item Attribute Value"; ItemAttributeID: Integer) Found: Boolean;
    begin

    end;
    #endregion IItem Members
}