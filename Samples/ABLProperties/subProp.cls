/* Derived Class with updated logic via ABL Properties Overriding */

CLASS subProp INHERITS baseProp:

    DEFINE PUBLIC OVERRIDE PROPERTY discount AS DECIMAL
    

        // GET
        GET ():

            RETURN SUPER:discount.
            //RETURN discount.

        END GET.

        
        // SET
        SET (INPUT pValue AS DECIMAL):

            // Discount must be at least 25%
            IF pValue < 25.0 THEN

            DO:

               pValue = 25.0.

            END.

            SUPER:discount = pValue.
            //discount = pValue.

        END SET.
        
        
       // Final 
       DEFINE PUBLIC OVERRIDE FINAL PROPERTY fx AS INTEGER
       GET SUPER.
       
        

END CLASS.
