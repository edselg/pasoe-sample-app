
 /*------------------------------------------------------------------------
    File        : Salesrep
    Purpose		:
    Syntax      : 
    Description :
    Author(s)   : Administrator
    Created     : Fri Jul 27 14:15:22 EDT 2018
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
  /** Dynamically generated schema file **/
   
@openapi.openedge.entity.primarykey (fields="SalesRep").
	
DEFINE TEMP-TABLE ttSalesrep BEFORE-TABLE bttSalesrep
FIELD SalesRep AS CHARACTER LABEL "Sales Rep"
FIELD RepName AS CHARACTER LABEL "Rep Name"
FIELD Region AS CHARACTER LABEL "Region"
FIELD MonthQuota AS INTEGER EXTENT 12 INITIAL "0" LABEL "Month Quota"
INDEX SalesRep IS  PRIMARY  UNIQUE  SalesRep  ASCENDING . 


DEFINE DATASET dsSalesrep FOR ttSalesrep.