

/** GetCustOrders.p **/

{"myCustOrder.i"}


DEFINE INPUT PARAMETER whereStr AS CHAR.         
DEFINE OUTPUT PARAMETER DATASET-HANDLE Hdl.


DEFINE VAR prepareExp  AS CHAR   NO-UNDO.
DEFINE VAR orderCnt    AS INT    INIT 0.

DEF    VAR retok       AS LOG.
DEF    VAR hCustOrders AS HANDLE.
DEF    VAR hqCust      AS HANDLE.
DEF    VAR sError      AS CHAR.

DEFINE QUERY qCust FOR Customer.
hqCust = QUERY qCust:HANDLE.
    
prepareExp = "FOR EACH Customer".
    
IF whereStr BEGINS "WHERE " THEN
    prepareExp = prepareExp + " " + whereStr.
ELSE IF whereStr NE "" THEN
        prepareExp = prepareExp + " WHERE " + whereStr.
        
MESSAGE "GetCustOrders.p: prepareExp is: " prepareExp.
    
retok = hqCust:QUERY-PREPARE(prepareExp).


IF NOT retok THEN 
DO:
        // sError = "QUERY-PREPARE failed" .
    RETURN.
END.

DEFINE DATA-SOURCE dsCust FOR QUERY qCust.
DEFINE DATA-SOURCE dsOrder  FOR Order.

DATASET dsCustomerOrder:EMPTY-DATASET().

BUFFER ttCustomer:HANDLE:ATTACH-DATA-SOURCE(DATA-SOURCE dsCust:HANDLE,?,?,?).

BUFFER ttOrder:HANDLE:ATTACH-DATA-SOURCE(DATA-SOURCE dsOrder:HANDLE,?,?,?). 

retok = DATASET dsCustomerOrder:FILL().

Hdl = DATASET dsCustomerOrder:HANDLE.


