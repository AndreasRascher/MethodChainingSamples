codeunit 50101 FindRelatedTest
{
    Subtype = Test;

    [Test]
    procedure FindRelatedTest_SalesHeader()
    var
        salesHeader: Record "Sales Header";
        salesline: Record "Sales Line";
        paymentTerms: Record "Payment Terms";
        shipmentMethod: Record "Shipment Method";
        salesperson: Record "Salesperson/Purchaser";
        AddrArray: array[8] of Text[100];
        customer: Record "Customer";
        item: Record Item;
    begin
        findCreateSampleSalesHeader(salesHeader);
        hasLines := FindRelated.ForSalesHeader(salesHeader).FilterSalesLines(salesline);

        found := FindRelated.ForSalesHeader(salesHeader).PaymentTerms(paymentTerms);
        paymentTerms.TestField(Code, salesHeader."Payment Terms Code");

        found := FindRelated.ForSalesHeader(salesHeader).ShipmentMethod(shipmentMethod);
        shipmentMethod.TestField(Code, salesHeader."Shipment Method Code");

        found := FindRelated.ForSalesHeader(salesHeader).Salesperson(salesperson);
        salesperson.TestField(Code, salesHeader."Salesperson Code");

        FindRelated.ForSalesHeader(salesHeader).SalesAddress().BillToAddress(AddrArray);
        FindRelated.ForSalesHeader(salesHeader).SalesAddress().SellToAddress(AddrArray);
        FindRelated.ForSalesHeader(salesHeader).SalesAddress().ShipToAddress(AddrArray);
        found := FindRelated.ForSalesHeader(salesHeader).BillToCustomer(customer);
        customer.TestField("No.", salesHeader."Bill-to Customer No.");
        found := FindRelated.ForSalesHeader(salesHeader).SellToCustomer(Customer);
        customer.TestField("No.", salesHeader."Sell-to Customer No.");
        FindRelated.ForSalesLine(salesline).Item()
    end;

    [Test]
    procedure FindRelatedTest_Customer()
    var
        customer, BillToCustomer : Record "Customer";
    begin
        customer.SetFilter("Bill-to Customer No.", '<>%1', '');
        customer.FindFirst();
        BillToCustomer := FindRelated.ForCustomer(customer).BillToCustomer();
        found := FindRelated.ForCustomer(customer).BillToCustomer(BillToCustomer);
        BillToCustomer.TestField("No.", customer."Bill-to Customer No.");
    end;

    [Test]
    procedure FindRelatedTest_Purchase()
    var
        Purchaseheader: Record "Purchase Header";
        Purchaseline: Record "Purchase Line";
        paymentTerms: Record "Payment Terms";
        shipmentMethod: Record "Shipment Method";
        Purchaser: Record "Salesperson/Purchaser";
        AddrArray: array[8] of Text[100];
    begin
        Purchaseheader.SetFilter("Payment Terms Code", '<>%1', '');
        Purchaseheader.SetFilter("Shipment Method Code", '<>%1', '');
        Purchaseheader.SetFilter("Purchaser Code", '<>%1', '');
        Purchaseheader.FindFirst();

        FindRelated.ForPurchaseHeader(PurchaseHeader).FilterPurchaseLines(Purchaseline);

        FindRelated.ForPurchaseHeader(Purchaseheader).PaymentTerms(paymentTerms);
        paymentTerms.TestField(Code, Purchaseheader."Payment Terms Code");

        FindRelated.ForPurchaseHeader(Purchaseheader).ShipmentMethod(shipmentMethod);
        shipmentMethod.TestField(Code, Purchaseheader."Shipment Method Code");

        FindRelated.ForPurchaseHeader(Purchaseheader).PurchasePerson(Purchaser);
        Purchaser.TestField(Code, Purchaseheader."Purchaser Code");

        FindRelated.ForPurchaseHeader(Purchaseheader).PurchaseAddress().BuyFromAddress(AddrArray);
        FindRelated.ForPurchaseHeader(Purchaseheader).PurchaseAddress().PayToAddress(AddrArray);
        FindRelated.ForPurchaseHeader(Purchaseheader).PurchaseAddress().ShipToAddress(AddrArray);
    end;

    [Test]
    procedure FindRelatedTest_Item()
    var
        item: Record Item;
        countryRegion: Record "Country/Region";
    begin
        findCreateSampleItem(item);
        Found := FindRelated.forItem(item).CountryRegionOfOrigin(countryRegion);
        countryRegion := FindRelated.ForItem(item).CountryRegionOfOrigin();
        countryRegion.TestField(Code, item."Country/Region of Origin Code");
    end;

    local procedure findCreateSampleSalesHeader(var salesHeader: Record "Sales Header")
    var
        paymentTerms: Record "Payment Terms";
        shipmentMethod: Record "Shipment Method";
        salesperson: Record "Salesperson/Purchaser";
        customer: Record "Customer";
    begin
        salesHeader.SetFilter("Payment Terms Code", '<>%1', '');
        salesHeader.SetFilter("Shipment Method Code", '<>%1', '');
        salesHeader.SetFilter("Salesperson Code", '<>%1', '');
        if not salesHeader.FindFirst() then begin
            paymentTerms.FindFirst();
            shipmentMethod.FindFirst();
            salesperson.FindFirst();
            salesHeader.Insert(true);
            customer.FindFirst();
            salesHeader.Validate("Sell-to Customer No.", customer."No.");
            salesHeader.Validate("Shipment Method Code", shipmentMethod.Code);
            salesHeader.Validate("Payment Terms Code", paymentTerms.Code);
            salesHeader.Validate("Salesperson Code", salesperson.Code);
            salesHeader.Modify(true)
        end;
    end;

    local procedure findCreateSampleItem(var item: Record Item)
    var
        countryRegion: Record "Country/Region";
    begin
        Clear(item);
        item.SetFilter("Country/Region of Origin Code", '<>%1', '');
        if not item.FindFirst() then begin
            countryRegion.FindFirst();
            item.Insert(true);
            item.Validate("Country/Region of Origin Code", countryRegion.Code);
            item.Modify(true)
        end;
    end;

    var
        FindRelated: Codeunit FindRelated;
        found, hasLines : Boolean;
}