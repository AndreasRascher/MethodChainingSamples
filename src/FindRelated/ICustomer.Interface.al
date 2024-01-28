interface ICustomer
{
    procedure BillToCustomer(var BillToCustomer: Record "Customer") Found: Boolean;
    procedure BillToCustomer() BillToCustomer: Record "Customer";
}