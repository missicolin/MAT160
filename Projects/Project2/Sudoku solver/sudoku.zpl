param p := 3;

set L := { 1 .. p*p }; #create lineal elimination 1*9
set M := { 1 .. p}; #create square elimination 1*3


set F := { read "sudoku3.dat" as "<1n,2n,3n>"}; #read sudoku<"row","col","value"> 
var x[L * L * L] binary; #x[i,j,k] decision variable


#maximize cost: sum <i,j,k> in L*L*L : x[i,j,k]; objective

subto  bounds: sum <i,j,k> in L*L*L : x[i,j,k] == card(L*L); #not out-bounds
subto rows: forall <i,j> in L*L do sum <k> in L : x[i,j,k] == 1;
subto cols: forall <j,k> in L*L do sum <i> in L : x[i,j,k] == 1;
subto nums: forall <i,k> in L*L do sum <j> in L : x[i,j,k] == 1;

subto squares: forall <m,n,k> in M*M*L do 
   sum <i,j> in M*M : x[(m-1)*p+i,(n-1)*p+j,k] == 1;

#Fix the fixed values
subto fixed: forall <i,j,k> in F do x[i,j,k] == 1;
