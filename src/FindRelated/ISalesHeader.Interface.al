interface ISalesHeader
{
    procedure FilterSalesLines(var SalesLines: Record "Sales Line") HasLines: Boolean;
    procedure PaymentTerms(var PaymentTerms: Record "Payment Terms") Found: Boolean;
    procedure ShipmentMethod(var ShipmentMethod: Record "Shipment Method") Found: Boolean;
    procedure Salesperson(var Salesperson: Record "Salesperson/Purchaser") Found: Boolean;
    procedure BillToCustomer(var BillToCustomer: Record "Customer") Found: Boolean;
    procedure SellToCustomer(var SellToCustomer: Record "Customer") Found: Boolean;
    procedure SalesAddress() ISalesAddress: Interface ISalesAddress;
}