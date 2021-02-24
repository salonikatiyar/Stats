
***************************************;
*Wilcoxon rank sum test using SAS      ;
*CLASS---1: DOMINANT, 2--SEX-LINKED    ;
***************************************;

*read raw data;

data ranksum; input VAR1 $ VAR2;
datalines;
10.1	7.8
10.0	8.2
9.6 	8.1
9.3 	7.9
9.8 	7.7
9.5 	8.0
9.4 	8.1

;
run;

proc print data=ranksum; run;

***************************************************;
*Call SAS procedure NP1WAY to perform Wicoxon      ;
*rank sum test                                     ;
***************************************************;
proc npar1way  wilcoxon correct=yes  data = ranksum;
  class CLASS;
  var VA;
run;

*------------------------------------------------------------;
*Use ODS data set label to create desired output data set    ;
*Actual label name can be found from the SAS log file when   ;
*the ODS trace function is activated (ods trace on) when     ;
*option is specified                                         ;
*------------------------------------------------------------;

ods trace on;
ods output "Two-Sample Test"=Wtest;
ods output "Scores"=Wscore;
proc npar1way  wilcoxon correct=yes  data=ranksum;
  class CLASS;
  var VA;
run;
ods trace off;

proc print data=Wtest;
title1 "Wilcoxon Rank Sum Test---Test Statistic and P-value Output";
title2 "Using Outout Deliveray System (ODS)";
run;

proc print data=Wscore;
title1 "Wilcoxon Rank Sum Test---Score Output";
title2 "Using Outout Deliveray System (ODS)";
run;


*-----------------------------------------------------;
*ODS output table using ods output data set name      ;
*-----------------------------------------------------;
ods trace on;
proc npar1way  wilcoxon correct=yes  data=ranksum;
  class CLASS;
  var VA;
ods output WilcoxonScores=WL_Score WilcoxonTest=WL_test ;
run;
ods trace off;

proc print data=Wtest;
title1 "Wilcoxon Rank Sum Test---Test Statistic and P-value Output";
title2 "Using Outout Deliveray System (ODS)";
run;

proc print data=Wscore;
title1 "Wilcoxon Rank Sum Test---Score Output";
title2 "Using Outout Deliveray System (ODS)";
run;








