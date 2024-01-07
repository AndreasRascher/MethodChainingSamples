# Use of method chaining in Business Central
**Problem:** Method chaining is useful to structure common functionality. A Implementation in Business Central requires a lot of objects and therefor object IDs. This blocks many reuse scenarios.

**Idea:** 
The interface object type has no object ID. It is used to provide a subset of methods of an implementation codeunit. By chaining Interfaces and with just 2 Codeunits (One to define the starting point, the other for the chained methods) it becomes possible to implement complex method chaining structures. 

## DownloadMgt Module
Collect Files contained in TempBlobs in a zip file. Create textfiles on the fly. Download all files in a zip package.

![DownloadMgt_ComposeZipFile.png](DownloadMgt_ComposeZipFile.png)


## DocInfo Module

Objects                 | Description
------------------------|------------------------
Codeunit DocInfo        | Access to DocInfo functions
Codeunit DocInfoImpl    | all interface implementations
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
