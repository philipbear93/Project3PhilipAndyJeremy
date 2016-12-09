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
global nodes

run wfem

%% Count number of elements
numofelem = size(nodes,1)-1;
dof = (size(nodes,1)*6)-9;
%% Pull Force Vector & Stiffness and Mass Matricies from wfem 
K = full(Kr);
M = full(Mr);
R = full(Fr);

%% Select an appropriate dt, gamma and beta
t = 0.02;
dt = .00002; %Delta t in seconds
teff = .01;

Gamma = [1/2 1/2 1/2];
Beta = [1/4 1/6 1/12];

%% Determine Damping matrix with Chosen Zeta value, K & M
    Zeta = .02; %Damping Ratio

    %Determine Mode Shapes and Eigenvalues
    [mode, lam ]= eig(K);
    w = sqrt(lam);

    lam_mat = 2*Zeta*w;

    C = (mode')^-1*lam_mat*mode^-1;
    

%% Newmark Method

i = 1;
for i=1:3
[POS,VEL,ACC,T] = NewmarkBetaSolver(K,C,M,R,Zeta,dt,t,teff,Gamma(i),Beta(i));

%% Plot 
figure(2)
fig_name1 = ['Position Plot Using Newmark Beta Method ',num2str(i),' for ',num2str(numofelem),' elements'];
plot(T(1,:),POS(:,dof,:))
grid on
ylabel('\Theta_{z50}  (rad)')
xlabel('t(s)')
title(fig_name1)
saveas(gcf,fig_name1,'jpg')

figure(3)
fig_name2 = ['Velocity Plot Using Newmark Beta Method ',num2str(i),' for ',num2str(numofelem),' elements'];
plot(T(1,:),VEL(:,dof,:))
grid on
ylabel('d\Theta_{z50}/dt  (rad/s)')
xlabel('t(s)')
title(fig_name2)
saveas(gcf,fig_name2,'jpg')

figure(4)
fig_name3 = ['Acceleration Plot Using Newmark Beta Method ',num2str(i),' for ',num2str(numofelem),' elements'];
plot(T(1,:),ACC(:,dof,:))
grid on
ylabel('d^{2}\Theta_{z50}/dt^{2}  (rad/s^{2})')
xlabel('t(s)')
title(fig_name3)
saveas(gcf,fig_name3,'jpg')
end