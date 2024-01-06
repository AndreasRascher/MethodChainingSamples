# DocInfo Module


Objects                 | Description
------------------------|------------------------
Codeunit DocInfo        | Access to DocInfo functions
Codeunit DocInfoImpl    | implementation layer
multiple interfaces     | used to structure and chain methods

## Overview Available Method Chains

### Sales
* DocInfo.From(HeaderRecord)
    * SalesAddress
        * SellToAddress
        * BillToAddress
        * ShipToAddress
    * RelatedTables
        * PaymentTerms
        * ShipmentMethod
        * SalespersonPurchaser
### Purchase 
* DocInfo.From(HeaderRecord)
    * PurchAddress
        * BuyFromAddress
        * PayToAddress
        * ShipToAddress    
    * RelatedTables
        * PaymentTerms
        * ShipmentMethod
        * SalespersonPurchaser
* DocInfo.From(LineRecord)    
    * Item
    * TrackingSpecification
