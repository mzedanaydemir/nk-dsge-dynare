// NK model with habit - Task 1 IRFs

var y pi r eps_r eps_d eps_a;
varexo e_r e_d e_a;

parameters phipi phiy h sig beta eta rhor rhod rhoa theta kappa;

// Calibration
phipi = 1.50;
phiy  = 0.15;
h     = 0.40;
sig   = 1.5;
beta  = 0.99;
eta   = 1.5;
rhor  = 0.50;
rhod  = 0.85;
rhoa  = 0.90;
theta = 0.75;

// Phillips curve slope
kappa = (1-theta)*(1-beta)/theta;

model(linear);

// Taylor rule
r = phipi*pi + phiy*y + eps_r;

// Euler with habit
y = (1/(1+h))*y(+1) + (h/(1+h))*y(-1) - ((1-h)/(sig*(1+h)))*(r - pi(+1)) + eps_d;

// NK Phillips Curve
pi = beta*pi(+1) + kappa*( ((eta*(1-h) + sig)/(1-h))*y - (1+eta)*eps_a - (h*sig/(1-h))*y(-1) );

// Shock processes
eps_r = rhor*eps_r(-1) + e_r;
eps_d = rhod*eps_d(-1) + e_d;
eps_a = rhoa*eps_a(-1) + e_a;

end;

steady;
check;

shocks;
var e_r; stderr 1;
var e_d; stderr 1;
var e_a; stderr 1;
end;

stoch_simul(order=1, irf=20, nograph) y pi r eps_r eps_d eps_a;
