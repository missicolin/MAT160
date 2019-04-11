param spheres := 5;

set C := {1 .. spheres};
set P := {<i, j> in C * C with i < j };

#coordinates of squares
 

var R <= 100;
var x[C] ;
var y[C];


#minimize R
minimize R: R;

#sphere is in bounds of square
subto c1: forall <i> in C: -R + 1 <= x[i]; 
subto c2: forall <i> in C: x[i] <= R - 1 ;
subto c3: forall <i> in C: -R + 1  <= y[i];
subto c4: forall <i> in C: y[i] <= R - 1 ;

#the spheres not overlapping
subto c5: forall <i,j> in P do sqrt((x[i] - x[j])^2 + (y[i] - y[j])^2)  >= 2;

 
