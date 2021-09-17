



/** UpdateCustOrders.p **/

 {"myCustOrder.i"}
 
 
FUNCTION GetErrorMsg RETURNS CHAR:
        DEFINE VAR errMsg AS CHAR.
    
        IF ERROR-STATUS:NUM-MESSAGES >= 1 THEN
            errMsg = ERROR-STATUS:GET-MESSAGE(1).
        ELSE
            errMsg = RETURN-VALUE.
        
        IF errMsg EQ ? THEN
            errMsg = "Error occurred".
      
        RETURN errMsg.
END FUNCTION.

         
DEFINE INPUT-OUTPUT PARAMETER DATASET FOR dsCustomerOrder.
DEFINE OUTPUT PARAMETER statusMsg AS CHAR INIT ?.

    DEFINE DATA-SOURCE dsCust  FOR Customer.
    DEFINE DATA-SOURCE dsOrder FOR Order.
    
    BUFFER ttCustomer:ATTACH-DATA-SOURCE (DATA-SOURCE dsCust:HANDLE).
    BUFFER ttOrder:ATTACH-DATA-SOURCE (DATA-SOURCE dsOrder:HANDLE).

    FOR EACH bttCustomer:
          MESSAGE "UpdateCustOrders.p, UPDATING CustNum: " bttCustomer.Custnum.
          BUFFER bttCustomer:SAVE-ROW-CHANGES(1, "CustNum") NO-ERROR.
          IF BUFFER bttCustomer:ERROR THEN
            statusMsg = GetErrorMsg().
    END.
    
    FOR EACH bttOrder:
         BUFFER bttOrder:SAVE-ROW-CHANGES(1, "Ordernum") NO-ERROR.
         IF BUFFER bttOrder:ERROR THEN
            statusMsg = GetErrorMsg().
    END. 
    
    BUFFER bttCustomer:DETACH-DATA-SOURCE().
    BUFFER bttOrder:DETACH-DATA-SOURCE().
    
    IF statusMsg EQ ? THEN
        statusMsg = "Okay".
            
          
