%% Newmark Beta Method
close all
clear all
clc

global K
global M
global F
global nodes

run wfem

%% Count number of elements
numofelem = size(nodes,1)-1;
dof = (size(nodes,1)*6)-9;
%% Pull Force Vector & Stiffness and Mass Matricies from wfem 

K = full(K);
M = full(M);
R = full(F);

Kr = K(1:size(nodes,1)*6,1:size(nodes,1)*6);
Mr = M(1:size(nodes,1)*6,1:size(nodes,1)*6);
Rr = R(1:size(nodes,1)*6);

bcs = [1 2 152];
K(stripdof,:) = [];
K(:,stripdof) = [];
K(bcs,:) = [];
K(:,bcs) = [];
M(stripdof,:) = [];
M(:,stripdof) = [];
M(bcs,:) = [];
M(:,bcs) = [];

%% Select an appropriate dt, gamma and beta
t = 0.15;
dt = .0001; %Delta t in seconds
teff = .01;

Gamma = [1/2 1/2 1/2];
Beta = [1/4 1/6 1/12];

%% Determine Damping matrix with Chosen Zeta value, K & M
    Zeta = .02; %Damping Ratio

    %Determine Mode Shapes and Eigenvalues
    [mode, lam ]= eig(Kr);
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