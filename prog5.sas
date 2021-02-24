data q5data;
input execu meth $ con_sc;
datalines;
1 comparison 9.2
2 comparison 14.4
3 comparison 16.5
4 comparison 17.6
5 comparison 15.5
1 utility 1.3
2 utility 2.5
3 utility 7.2
4 utility 6.8
5 utility 12.6
1 worry 4.8
2 worry 6.9
3 worry 9.1
4 worry 13.2
5 worry 13.6
;
run;
proc glm data=q5data;
class execu meth;
model con_sc=execu meth / ss1;
run;
proc glm data=q5data;
class execu meth;
model con_sc=execu meth /ss1;
contrast 'equality of confidance rating betwen comparison and utility' meth 1 -1 0;
contrast 'equality of confidance rating betwen comparison and worry' meth 1 0 -1;
contrast 'equality of confidance rating betwen utility and worry' meth 0 1 -1;
contrast 'equality of confidance rating betwen 1st and 2nd executive' execu 1 -1 0 0 0;
contrast 'equality of confidance rating betwen 1st and 3rd executive' execu 1 0 -1 0 0;
contrast 'equality of confidance rating betwen 1st and 4th executive' execu 1 0 0 -1 0;
contrast 'equality of confidance rating betwen 1st and 5th executive' execu 1 0 0 0 -1;
contrast 'equality of confidance rating betwen 2nd and 3rd executive' execu 0 1 -1 0 0;
contrast 'equality of confidance rating betwen 2nd and 4th executive' execu 0 1 0 -1 0;
contrast 'equality of confidance rating betwen 2nd and 5th executive' execu 0 1 0 0 -1;
contrast 'equality of confidance rating betwen 3rd and 4th executive' execu 0 0 1 -1 0;
contrast 'equality of confidance rating betwen 3rd and 5th executive' execu 0 0 1 0 -1;
contrast 'equality of confidance rating betwen 4th and 5th executive' execu 0 0 0 1 -1;
title 'two way annova for test methods and executive effects';
run;
proc print;
run;