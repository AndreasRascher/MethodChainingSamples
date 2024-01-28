FindRelated	ForSalesHeader		SalesLines
					PaymentTerms|ShipmentMethod|SalespersonPurchaser
					SalesAddress	SellToAddress
							BillToAddress
							ShipToAddress
FindRelated	ForPurchaseHeader	PurchaseLines
					PaymentTerms|ShipmentMethod|SalespersonPurchaser
			     		DirectShipmentSalesOrder
					PurchAddress	BuyFromAddress
							PayToAddress
							ShipToAddress  
FindRelated	ForStandardText		FindExtendedTextLines
FindRelated	ForSalesLine		Item|TrackingSpecification
FindRelated	ForPurchaseLine		Item|TrackingSpecification
FindRelated	ForCustomer		PrimaryContact
