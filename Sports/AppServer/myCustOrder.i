
DEFINE TEMP-TABLE ttCustomer BEFORE-TABLE bttCustomer
    FIELD CustNum       AS INTEGER      INITIAL "0" LABEL "Cust Num"
    FIELD Name          AS CHARACTER    LABEL "Name"
    FIELD Address       AS CHARACTER    LABEL "Address"
    FIELD Address2      AS CHARACTER    LABEL "Address2"
    FIELD Balance       AS DECIMAL      INITIAL "0" LABEL "Balance"
    FIELD City          AS CHARACTER    LABEL "City"
    FIELD Contact       AS CHARACTER    LABEL "Contact"
    FIELD Country       AS CHARACTER    INITIAL "USA" LABEL "Country"
    FIELD CreditLimit   AS DECIMAL      INITIAL "1500" LABEL "Credit Limit"
    FIELD Discount      AS INTEGER      INITIAL "0" LABEL "Discount"
    FIELD EmailAddress  AS CHARACTER    LABEL "Email"
    FIELD Phone         AS CHARACTER    LABEL "Phone"
    
    INDEX CustNum IS UNIQUE CustNum.
      
        
DEFINE TEMP-TABLE ttOrder BEFORE-TABLE bttOrder
    FIELD Ordernum AS INTEGER 
    FIELD CustNum AS INTEGER 
    FIELD OrderDate AS DATE 
    FIELD SalesRep AS CHARACTER 
    FIELD OrderStatus AS CHARACTER INITIAL "Ordered" 
        
    INDEX CustOrderIdx IS UNIQUE  CustNum Ordernum 
    INDEX OrdernumIdx IS UNIQUE PRIMARY  Ordernum.


DEFINE DATASET dsCustomerOrder  
    FOR ttCustomer, ttOrder
    DATA-RELATION custOrdRel FOR ttCustomer, ttOrder
        RELATION-FIELDS (CustNum, CustNum).
        
