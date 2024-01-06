interface DocInfoPurchAddress
{
    procedure BuyFromAddress(var AddrArray: array[8] of Text[100]);
    procedure PayToAddress(var AddrArray: array[8] of Text[100]);
    procedure ShipToAddress(var AddrArray: array[8] of Text[100]);
}