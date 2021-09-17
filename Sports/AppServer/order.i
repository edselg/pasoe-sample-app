
 /*------------------------------------------------------------------------
    File        : Order
    Purpose		:
    Syntax      : 
    Description :
    Author(s)   : Administrator
    Created     : Fri Jul 27 14:16:21 EDT 2018
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
  /** Dynamically generated schema file **/
   
@openapi.openedge.entity.primarykey (fields="Ordernum").
	
DEFINE TEMP-TABLE ttOrder BEFORE-TABLE bttOrder
FIELD Ordernum AS INTEGER INITIAL "0" LABEL "Order Num"
FIELD CustNum AS INTEGER INITIAL "0" LABEL "Cust Num"
FIELD OrderDate AS DATE INITIAL "TODAY" LABEL "Ordered"
FIELD ShipDate AS DATE LABEL "Shipped"
FIELD PromiseDate AS DATE LABEL "Promised"
FIELD Carrier AS CHARACTER LABEL "Carrier"
FIELD Instructions AS CHARACTER LABEL "Instructions"
FIELD PO AS CHARACTER LABEL "PO"
FIELD Terms AS CHARACTER INITIAL "Net30" LABEL "Terms"
FIELD SalesRep AS CHARACTER LABEL "Sales Rep"
FIELD BillToID AS INTEGER INITIAL "0" LABEL "Bill To ID"
FIELD ShipToID AS INTEGER INITIAL "0" LABEL "Ship To ID"
FIELD OrderStatus AS CHARACTER INITIAL "Ordered" LABEL "Order Status"
FIELD WarehouseNum AS INTEGER INITIAL "0" LABEL "Warehouse Num"
FIELD Creditcard AS CHARACTER INITIAL "Visa" LABEL "Credit Card"
INDEX CustOrder IS  UNIQUE  CustNum  ASCENDING  Ordernum  ASCENDING 
INDEX OrderDate  OrderDate  ASCENDING 
INDEX OrderNum IS  PRIMARY  UNIQUE  Ordernum  ASCENDING 
INDEX OrderStatus  OrderStatus  ASCENDING 
INDEX SalesRep  SalesRep  ASCENDING . 


DEFINE DATASET dsOrder FOR ttOrder.