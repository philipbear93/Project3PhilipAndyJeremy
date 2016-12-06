%% Newmark Beta Method
close all
clear all
clc

global Kr
global Mr
global Fr
global K
global M
global R

run wfem

%% Pull Force Vector & Stiffness and Mass Matricies from wfem 
K = full(Kr);
M = full(Mr);
R = full(Fr);

%% Select an appropriate dt, gamma and beta
t = 1;
dt = .01; %Delta t in seconds
teff = .01;

Gamma = 0.5;
Beta = 0.25;
%% Determine Damping matrix with Chosen Zeta value, K & M
    Zeta = .02; %Damping Ratio

    %Determine Mode Shapes and Eigenvalues
    [mode, lam ]= eig(K);
    w = sqrt(lam);

    lam_mat = 2*Zeta*w;

    C = (mode')^-1*lam_mat*mode^-1;

%% Newmark Method

[POS,VEL,ACC,T] = NewmarkBetaSolver(K,C,M,R,Zeta,dt,t,teff,Gamma,Beta);

%% Plot 

plot(T(1,:),ACC(:,27,:))
grid on