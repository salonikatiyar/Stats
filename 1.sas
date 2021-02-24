*---------------------------------------------------------------------;
*Wilcoxon Signed Rank test can be carried out in SAS PROC UNIVARIATE. ;
*The following code does the analysis for paired sample               ;
*The 95% confidence intervals for the t-test and median               ;
*(quantile=0.5) can be produced using the options:                    ;  
*CIPCTLDF(ALPHA=0.05).                                                ;
*---------------------------------------------------------------------; 

DATA examp1;
INPUT first second;
difference=second-first;
CARDS;
 186 188																			
 171 177
 177 176
 168 169
 191 196
 172 172
 177 165
 191 190
 170 166
 171 180	
 188 181
 187 172
;

proc print data=examp1; 
run;

ods trace on;
ods output "Tests For Location"=LocationTest; 
ods output "Quantiles"=Quantile;
ods output "Moments"=Moments;
ods output "Basic Measures of Location and Variability"=Location;
ods output "Extreme Observations"=Extreme;

PROC UNIVARIATE DATA=examp1 LOCATION=0 CIPCTLDF(ALPHA=0.05);
VAR difference;
RUN;
ods trace off;

*---------------------------------;
*Some output data sets from ODS   ;
*---------------------------------;
proc print data=Moments;
title "Moments Data";
proc print data=Location;
title "Location Data";
proc print data=Extreme;
title "Extreme";
run; 

*------------------------------------------------------;
*Prepare Wilcoxon Sined Rank Test output data set      ;
*------------------------------------------------------;

data WL_test; set LocationTest;
if test="Signed Rank";
run;

title "test for location";
proc print data = WL_test;
run;

*-----------------------------------------------;
*Output data set of median rank and its 95% CI  ;
*-----------------------------------------------;

data MedianCI; set quantile;
if quantile="50% Median";                            
keep Name Quantile Estimate LCLRank UCLRank;
run;

title "Quantiles and 95% CIs for quantiles";
proc print data=MedianCI;
run;

*--------------------------------------------------;
*Example 9.12, Page337                             ;
*Note that the total rank is 420                   ;
*Proc univariate compute the smaller of the        ; 
*positive rank sum and negative rank sum.          ;
*The total rank sum =410 and the small rank       ;
*sum=162. The large rank sum=410-162=248.          ;
*--------------------------------------------------;
data sign; input diff rep $;
cards;
-15 1
-12 2
-7  3
-5  4
-4  5
-1  6
-1  ''
 0  7
 2  8
 5  9
 6  10
 9  11
;  
run;

proc print data=sign; 
run;



PROC UNIVARIATE DATA=sign LOCATION=0;
VAR diff;
output out=outputdata median=median  SIGNRANK=signrank_statistic PROBS=P_Value_Median PROBN=P_Value_Normality; 
RUN;

proc print data=outputdata; 
title "Wicoxon Signed Rank Test for Median=0 (Paried two-sample nonparametric test)";
run;

