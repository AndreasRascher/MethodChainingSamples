interface ISalesAddress
{
    procedure SellToAddress(var AddrArray: array[8] of Text[100]);
    procedure BillToAddress(var AddrArray: array[8] of Text[100]);
    procedure ShipToAddress(var AddrArray: array[8] of Text[100]);
}