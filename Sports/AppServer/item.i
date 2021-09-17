
 /*------------------------------------------------------------------------
    File        : Item
    Purpose		:
    Syntax      : 
    Description :
    Author(s)   : Administrator
    Created     : Fri Jul 27 14:16:02 EDT 2018
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
  /** Dynamically generated schema file **/
   
@openapi.openedge.entity.primarykey (fields="Itemnum").
	
DEFINE TEMP-TABLE ttItem BEFORE-TABLE bttItem
FIELD Itemnum AS INTEGER INITIAL "0" LABEL "Item Num"
FIELD ItemName AS CHARACTER LABEL "Item Name"
FIELD Price AS DECIMAL INITIAL "0" LABEL "Price"
FIELD Onhand AS INTEGER INITIAL "0" LABEL "On Hand"
FIELD Allocated AS INTEGER INITIAL "0" LABEL "Allocated"
FIELD ReOrder AS INTEGER INITIAL "0" LABEL "Re Order"
FIELD OnOrder AS INTEGER INITIAL "0" LABEL "On Order"
FIELD CatPage AS INTEGER INITIAL "0" LABEL "Cat Page"
FIELD CatDescription AS CHARACTER LABEL "Cat-Description"
FIELD Category1 AS CHARACTER LABEL "Category1"
FIELD Category2 AS CHARACTER LABEL "Category2"
FIELD Special AS CHARACTER LABEL "Special"
FIELD Weight AS DECIMAL INITIAL "0" LABEL "Weight"
FIELD Minqty AS INTEGER INITIAL "0" LABEL "Min Qty"
INDEX CatDescription  CatDescription  ASCENDING 
INDEX Category2ItemName  Category2  ASCENDING  ItemName  ASCENDING 
INDEX CategoryItemName  Category1  ASCENDING  ItemName  ASCENDING 
INDEX ItemName  ItemName  ASCENDING 
INDEX ItemNum IS  PRIMARY  UNIQUE  Itemnum  ASCENDING . 


DEFINE DATASET dsItem FOR ttItem.