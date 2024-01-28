interface IPurchaseHeader
{
    procedure FilterPurchaseLines(var PurchaseLines: Record "Purchase Line") HasLines: Boolean;
    procedure PaymentTerms(var PaymentTerms: Record "Payment Terms") Found: Boolean;
    procedure ShipmentMethod(var ShipmentMethod: Record "Shipment Method") Found: Boolean;
    procedure PurchasePerson(var Purchaseperson: Record "Salesperson/Purchaser") Found: Boolean;
    procedure PurchaseAddress() IPurchaseAddress: Interface IPurchaseAddress;
}

interface IPurchaseAddress
{
    procedure BuyFromAddress(var AddrArray: array[8] of Text[100]);
    procedure PayToAddress(var AddrArray: array[8] of Text[100]);
    procedure ShipToAddress(var AddrArray: array[8] of Text[100]);
}