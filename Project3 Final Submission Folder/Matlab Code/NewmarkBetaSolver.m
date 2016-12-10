function [ POS,VEL,ACC,T ] = NewmarkBetaSolver( K,M,Zeta,dt,t,teff,gamma,beta )
% NewmarkBetaSolver calculates D, Dp, and Dpp for t with dt spacing using
% the Newmark Beta method with parameters gamma and beta under the load R
% for duration teff.
% POS, VEL and ACC are the position, velocity and acceleration at time T
close all
clc

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
K = full(K);
K(stripdof,:) = [];
K(:,stripdof) = [];
K(bcs,:) = [];
K(:,bcs) = [];
M = full(M);
M(stripdof,:) = [];
M(:,stripdof) = [];
M(bcs,:) = [];
M(:,bcs) = [];

%% Determine Damping matrix with Chosen Zeta value, K & M
    Zeta = 0; %Damping Ratio

    %Determine Mode Shapes and Eigenvalues
    [mode, lam ]= eig(K);
    w = sqrt(lam);

    lam_mat = 2*Zeta*w;

    C = (mode')^-1*lam_mat*mode^-1;
    
R = zeros(size(K,1),1);
R(149,1) = 100000;

% Assume initial deflection and velocity are zero
Dn=zeros(size(K,1),1);
Dpn=zeros(size(K,1),1);

% Calculate Dppn0 using F=ma;
Dppn=M\R;

% Create force matrix for after teff
R0=zeros(size(R,1),size(R,2));

T=0:dt:t;
I=length(T);

% Loop over time
for i=1:I
    POS(:,i)=Dn(:);
    VEL(:,i)=Dpn(:);
    ACC(:,i)=Dppn(:);
    tc=T(i);
    % Calculate Dn1
    if tc <= teff
        Dn1=Dnplus1(Dn,Dpn,Dppn,R,gamma,beta,M,K,C,dt);
    else
        Dn1=Dnplus1(Dn,Dpn,Dppn,R0,gamma,beta,M,K,C,dt);
    end
    % Calculate Dpn1 and Dppn1
    Dpn1=Dpnplus1(Dn,Dpn,Dppn,Dn1,gamma,beta,dt);
    Dppn1=Dppnplus1(Dn,Dpn,Dppn,Dn1,beta,dt);
    Dn=real(Dn1);
    Dpn=real(Dpn1);
    Dppn=real(Dppn1);
end
POSITION=POS(121,:)
VELOCITY=VEL(121,:)
ACCELERATION=ACC(121,:)

%% Plot 
figure(1)
fig_name1 = ['Position Plot Using Hilber-Hughes-Taylor Method for 50 elements'];
plot(T,POSITION)
grid on
ylabel('\Theta_{z41}  (rad)')
xlabel('t(s)')
title(fig_name1)
saveas(gcf,fig_name1,'jpg')


figure(2)
fig_name2 = ['Velocity Plot Using Hilber-Hughes-Taylor Method for 50 Elements'];
plot(T, VELOCITY)
grid on
ylabel('d\Theta_{z41}/dt  (rad/s)')
xlabel('t(s)')
title(fig_name2)
saveas(gcf,fig_name2,'jpg')

figure(3)
fig_name3 = ['Acceleration Plot Using Hilber-Hughes-Taylor Method for 50 elements'];
plot(T, ACCELERATION)
grid on
ylabel('d^{2}\Theta_{z41}/dt^{2}  (rad/s^{2})')
xlabel('t(s)')
title(fig_name3)
saveas(gcf,fig_name3,'jpg')

pos_max = max(POSITION)
vel_max = max(VELOCITY)
acc_max = max(ACCELERATION)

end