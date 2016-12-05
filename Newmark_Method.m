%% Newmark Beta Method
close all
clear all
clc

global Kr
global Mr
global Fr

run wfem

Zeta = .02; %Damping Ratio

K = full(Kr)
M = full(Mr)
R = K\full(Fr)

% Select an appropriate dt, gamma and beta
t = 1;
dt = .01; %Delta t in seconds
teff = .01;

Gamma = 0.5;
Beta = 0.25;

%% Newmark

[POS,VEL,ACC,T] = NewmarkBetaSolver(K,M,R,Zeta,dt,t,teff,Gamma,Beta);


%% Plot 
