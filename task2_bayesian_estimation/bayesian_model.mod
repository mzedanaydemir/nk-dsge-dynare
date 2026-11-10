// Bayesian Estimation (Toy NK)
// Data: model_data.mat contains: y_obs, pi_obs, i_obs (and data matrix)

var y pi i y_obs pi_obs i_obs;
varexo eps_y eps_pi eps_i;

parameters beta kappa phi_pi phi_y rho_i;

beta   = 0.99;
kappa  = 0.10;
phi_pi = 1.50;
phi_y  = 0.50;
rho_i  = 0.80;

model;

// IS curve
y  = y(+1) - (i - pi(+1)) + eps_y;

// NK Phillips curve
pi = beta*pi(+1) + kappa*y + eps_pi;

// Taylor rule
i  = rho_i*i(-1) + (1-rho_i)*(phi_pi*pi + phi_y*y) + eps_i;

// Measurement equations (observed = model)
y_obs  = y;
pi_obs = pi;
i_obs  = i;

end;

// Observables (these are the data series names)
varobs y_obs pi_obs i_obs;

// Priors
estimated_params;

beta,   beta_pdf,   0.99, 0.002;
kappa,  gamma_pdf,  0.10, 0.05;
phi_pi, normal_pdf, 1.50, 0.25;
phi_y,  normal_pdf, 0.50, 0.20;
rho_i,  beta_pdf,   0.80, 0.10;

stderr eps_y,  inv_gamma_pdf, 0.10, 2;
stderr eps_pi, inv_gamma_pdf, 0.10, 2;
stderr eps_i,  inv_gamma_pdf, 0.10, 2;

end;

// Estimation settings
estimation(datafile=model_data, mode_compute=6, mh_replic=5000, mh_nblocks=2, mh_jscale=0.30);
