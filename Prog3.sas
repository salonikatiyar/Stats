
data example7; input var1 var2 count;
cards;
1 1 125 
1 2 59 
1 3 21 
2 1 101 
2 2 79
2 3 16 

;
run

proc print data=example7; 
title "2*3 contingency table--count data input";
run;

title;
proc freq data=example7;
tables var1*var2/ nocol norow nopercent chisq expect;
weight count;
run;
