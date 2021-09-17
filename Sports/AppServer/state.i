
 /*------------------------------------------------------------------------
    File        : State
    Purpose		:
    Syntax      : 
    Description :
    Author(s)   : Administrator
    Created     : Fri Jul 27 14:14:58 EDT 2018
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
  /** Dynamically generated schema file **/
   
@openapi.openedge.entity.primarykey (fields="State").
	
DEFINE TEMP-TABLE ttState BEFORE-TABLE bttState
FIELD State AS CHARACTER LABEL "State"
FIELD StateName AS CHARACTER LABEL "State Name"
FIELD Region AS CHARACTER LABEL "Region"
INDEX State IS  PRIMARY  UNIQUE  State  ASCENDING . 


DEFINE DATASET dsState FOR ttState.