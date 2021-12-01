/* ABL Procedure validating Overriding Properties feature. i.e., properties from different ABL Classes are modified via this ABL Procedure.

Also, sample snippet demonstrating the isFinal() reflection API on ABL Properties is shown here */ 

VAR Progress.Lang.Class myplc.
VAR CHAR  pbc = "subProp", propName = "discount", propName1 = "fx" .
VAR baseProp X = NEW baseProp().
VAR subProp Y = NEW subProp().
VAR sub2Prop z = NEW sub2Prop().

// From baseProp
X:discount = 45.
MESSAGE "From baseProp GET : " X:discount VIEW-AS ALERT-BOX.

// From subProp
Y:discount = 30.
MESSAGE "From subProp GET : " Y:discount VIEW-AS ALERT-BOX.

// From sub2Prop
Z:discount = 50.
MESSAGE "From sub2Prop GET : " z:discount VIEW-AS ALERT-BOX.

// isFinal check
MESSAGE "Class Name: " pbc VIEW-AS ALERT-BOX.
myplc = Progress.Lang.Class:GetClass(pbc).

MESSAGE propName "property is FINAL? :" myplc:GetProperty(propName):IsFinal
VIEW-AS ALERT-BOX.

MESSAGE propName1 "property is FINAL? :" myplc:GetProperty(propName1):IsFinal
VIEW-AS ALERT-BOX.
   
   