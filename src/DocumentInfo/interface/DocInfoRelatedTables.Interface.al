interface RelatedTables
{
    procedure PaymentTerms(var PaymentTermsFound: Record "Payment Terms") Found: Boolean;
    procedure PaymentTerms(var PaymentTerms: Record "Payment Terms"; LanguageCode: Code[10]) Found: Boolean;
    procedure PaymentTerms() PaymentTerms: Record "Payment Terms";
    procedure PaymentTerms(LanguageCode: Code[10]) PaymentTerms: Record "Payment Terms";

    procedure ShipmentMethods(var ShipmentMethodsFound: Record "Shipment Method") Found: Boolean;
    procedure ShipmentMethods(var ShipmentMethods: Record "Shipment Method"; LanguageCode: Code[10]) Found: Boolean;
    procedure ShipmentMethods() ShipmentMethods: Record "Shipment Method";
    procedure ShipmentMethods(LanguageCode: Code[10]) ShipmentMethods: Record "Shipment Method";

    procedure SalespersonPurchaser(var SalespersonPurchaserFound: Record "Salesperson/Purchaser") Found: Boolean;
    procedure SalespersonPurchaser() SalespersonPurchaser: Record "Salesperson/Purchaser";
}