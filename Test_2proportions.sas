

************************************************************;
*Test for two independent proportions using Chisquare test  ;
************************************************************;

data Prop;
length Group $12 Response $3;
input Group Response N;
datalines;
Men          Yes  30
Men          No   70
Women        Yes  45
Women        No   55
;
 
proc freq data=Prop order=data;
   weight N;
   tables Group*Response / chisq;
run;
