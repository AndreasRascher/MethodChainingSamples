interface DocInfoPurchaseLine
{
    procedure Item(var item: Record Item) ItemFound: Boolean
    procedure TrackingSpecification(var tempTrackingSpecBuffer: Record "Tracking Specification" temporary) NoOfTrackingLinesFound: Integer
}