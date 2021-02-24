***************************************;
*Wilcoxon rank sum test using SAS ;
*CLASS---1: C, 2---D ;
***************************************;
*read raw data;
data ranksum; input VISUAL $ CLASS;
datalines;
10.1 1
10.0 1
9.6 1
9.3 1
9.8 1
9.5 1
9.4 1
7.8 2
8.2 2
8.1 2
7.9 2
7.7 2
8.0 2
8.1 2
;
run;
proc print; run;
*prepare data for analysis;
data ranksum; set ranksum;
if visual ="10.1" then VA=13;
if visual ="10.0" then VA=12;
if visual ="9.6" then VA=10;
if visual ="9.3" then VA=7;
if visual ="9.8" then VA=11;
if visual ="9.5" then VA=9;
if visual ="9.4" then VA=8;
if visual ="7.8" then VA=2;
if visual ="8.2" then VA=6;
if visual ="8.1" then VA=5;
if visual ="7.9" then VA=3;
if visual ="7.7" then VA=1;
if visual ="8.0" then VA=4;
run;
proc print data=ranksum; run;
***************************************************;
*Call SAS procedure NP1WAY to perform Wicoxon ;
*rank sum test ;
***************************************************;

proc npar1way wilcoxon correct=yes data = ranksum;
class CLASS;
var VA;
run;
*------------------------------------------------------------;
*Use ODS data set label to create desired output data set ;
*Actual label name can be found from the SAS log file when ;
*the ODS trace function is activated (ods trace on) when ;
*option is specified ;
*------------------------------------------------------------;
ods trace on;
ods output "Two-Sample Test"=Wtest;
ods output "Scores"=Wscore;
proc npar1way wilcoxon correct=yes data=ranksum;
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
*ODS output table using ods output data set name ;
*-----------------------------------------------------;
ods trace on;
proc npar1way wilcoxon correct=yes data=ranksum;
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