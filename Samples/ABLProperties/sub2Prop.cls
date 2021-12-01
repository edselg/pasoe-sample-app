/* Derived (of derived) Class with updated logic via ABL Properties Overriding */

CLASS sub2Prop INHERITS subProp:

    DEFINE PUBLIC OVERRIDE PROPERTY discount AS DECIMAL

        // GET SUPER
        GET SUPER.

        
        // SET
        SET (INPUT pValue AS DECIMAL):

            // Discount must be at least 35%

            IF pValue < 35.0 THEN

            DO:

               pValue = 35.0.

            END.

            SUPER:discount = pValue.

        END SET.


END CLASS.
