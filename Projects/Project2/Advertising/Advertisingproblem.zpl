
var T integer;
var N integer;
var P integer;
var A integer;

maximize profit: 
  5000 * T + 8500 * N + 2400 * P + 2800 * A;

subto radio_constraint:  
  290 * P + 380 * A <= 1800;

subto budget_constraint:
  800 * T + 925 * N + 290 * P + 380 * A <= 8000;

subto radio_size_constraint:  
  P + A >= 5;

subto tv_constraint:  
  T <= 12;

subto NP_constraint:  
  N <= 5;

subto RP_constraint:  
  P <= 25;

subto RA_constraint:  
  A <= 20;

