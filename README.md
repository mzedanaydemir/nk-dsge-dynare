# New Keynesian DSGE model in Dynare

Two-person course assignment for DSGE Modelling, M.Sc. International Economic Policy, University of Würzburg.

## Task 1: impulse responses

`task1_impulse_responses/NK_Task1_IRF.mod` solves a New Keynesian model with habit formation and three shocks (monetary policy, demand, technology). `plot_task1_irf.m` plots the impulse responses.

```matlab
dynare NK_Task1_IRF.mod noclearall
run('plot_task1_irf.m')
```

## Task 2: Bayesian estimation

`task2_bayesian_estimation/bayesian_model.mod` estimates a three-equation New Keynesian model (IS curve, Phillips curve, Taylor rule) on US data with the Metropolis-Hastings algorithm.

`prepare_data.m` builds the observables from three FRED series included here: real GDP (`GDPC1`), consumer prices (`CPIAUCSL`) and the federal funds rate (`FEDFUNDS`).

```matlab
run('prepare_data.m')
dynare bayesian_model.mod
```

## Requirements

MATLAB with Dynare 5 or newer.
