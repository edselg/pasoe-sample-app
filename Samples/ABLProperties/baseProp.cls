/* Base class with two properties */

CLASS baseProp:

    DEFINE PUBLIC PROPERTY discount AS DECIMAL

        // GET
        GET ():

            RETURN discount.

        END GET.

        
        // SET
        SET (INPUT pValue AS DECIMAL):

            discount = pValue.

        END SET.
        
        
     // Final   
     DEFINE PUBLIC PROPERTY fx AS INTEGER
     GET.
     

END CLASS.
