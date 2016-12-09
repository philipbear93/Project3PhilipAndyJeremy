%% Newmark Beta Method
close all
clear all
clc


run wfem

%% Count number of elements
numofelem = size(nodes,1)-1;
dof = 237;%(size(nodes,1)*6)-9;
%% Pull Force Vector & Stiffness and Mass Matricies from wfem 
K = full(K);
M = full(M);

stripdof = [3 4 5];
nodes = 50;

for i = 1:nodes
    strip1 = stripdof(1)+6*i;
    strip2 = strip1+1;
    strip3 = strip2+1;
    strip = [strip1 strip2 strip3];
    stripdof = [stripdof strip];    
end

bcs = [1 2 152];
K(stripdof,:) = [];
K(:,stripdof) = [];
K(bcs,:) = [];
K(:,bcs) = [];
M(stripdof,:) = [];
M(:,stripdof) = [];
M(bcs,:) = [];
M(:,bcs) = [];

R = zeros(size(K,1),1);
R(149,1) = 100000;

%% Select an appropriate dt, gamma and beta
t = 0.1;
dt = .0001; %Delta t in seconds
teff = .01;

Gamma = [1/2 1/2 1/2];
Beta = [1/4 1/6 1/12];

%% Determine Damping matrix with Chosen Zeta value, K & M
    Zeta = 0; %Damping Ratio

    %Determine Mode Shapes and Eigenvalues
    [mode, lam ]= eig(K);
    w = sqrt(lam);

    lam_mat = 2*Zeta*w;

    C = (mode')^-1*lam_mat*mode^-1;
    

%% Newmark Method
[POS,VEL,ACC,T] = NewmarkBetaSolver(K,C,M,R,Zeta,dt,t,teff,Gamma(1),Beta(1));
%% Plot 
figure(2)
fig_name1 = ['Position Plot Using Newmark Beta Method 1 for 50 elements'];
plot(T(1,:),POS(:,121,:))
grid on
ylabel('\Theta_{z50}  (rad)')
xlabel('t(s)')
title(fig_name1)
saveas(gcf,fig_name1,'jpg')

% i = 1;
% for i=1:3
% [POS,VEL,ACC,T] = NewmarkBetaSolver(K,C,M,R,Zeta,dt,t,teff,Gamma(i),Beta(i));
% 
% %% Plot 
% figure(2)
% fig_name1 = ['Position Plot Using Newmark Beta Method ',num2str(i),' for ',num2str(numofelem),' elements'];
% plot(T(1,:),POS(:,dof,:))
% grid on
% ylabel('\Theta_{z50}  (rad)')
% xlabel('t(s)')
% title(fig_name1)
% saveas(gcf,fig_name1,'jpg')
% 
% figure(3)
% fig_name2 = ['Velocity Plot Using Newmark Beta Method ',num2str(i),' for ',num2str(numofelem),' elements'];
% plot(T(1,:),VEL(:,dof,:))
% grid on
% ylabel('d\Theta_{z50}/dt  (rad/s)')
% xlabel('t(s)')
% title(fig_name2)
% saveas(gcf,fig_name2,'jpg')
% 
% figure(4)
% fig_name3 = ['Acceleration Plot Using Newmark Beta Method ',num2str(i),' for ',num2str(numofelem),' elements'];
% plot(T(1,:),ACC(:,dof,:))
% grid on
% ylabel('d^{2}\Theta_{z50}/dt^{2}  (rad/s^{2})')
% xlabel('t(s)')
% title(fig_name3)
% saveas(gcf,fig_name3,'jpg')
% end