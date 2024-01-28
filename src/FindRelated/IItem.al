interface IItem
{
    procedure CountryRegionOfOrigin(var countryRegion: Record "Country/Region") Found: Boolean;
    procedure CountryRegionOfOrigin() countryRegion: Record "Country/Region";
    procedure findItemAttributeValue(var itemAttributeValue: Record "Item Attribute Value"; ItemAttributeID: Integer) Found: Boolean;
}