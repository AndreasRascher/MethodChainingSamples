interface IPurchaseLine
{
    procedure Item(var Item: Record Item) Found: Boolean;
    procedure Item() IItem: Interface IItem;
}