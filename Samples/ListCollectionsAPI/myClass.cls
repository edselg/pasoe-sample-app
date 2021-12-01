/* Class definition for ABL List Collections Demo */

CLASS myClass :

  DEFINE PUBLIC PROPERTY mystring AS CHARACTER INITIAL ""
  GET. 
  SET.

  CONSTRUCTOR myClass(INPUT mystr AS CHAR):
      mystring = mystr.
  END CONSTRUCTOR.

  METHOD PUBLIC CHARACTER MakeNoise():
      RETURN mystring.
  END METHOD.

END CLASS.
