function [ POS,VEL,ACC,T ] = NewmarkBetaSolver( K,M,R,Zeta,dt,t,teff,gamma,beta )
% NewmarkBetaSolver calculates D, Dp, and Dpp for t with dt spacing using
% the Newmark Beta method with parameters gamma and beta under the load R
% for duration teff.
% POS, VEL and ACC are the position, velocity and acceleration at time T

% Calculate C from K, M and a given Zeta
C=Cmatrix(K,M,Zeta);

% Assume initial deflection and velocity are zero
Dn=zeros(size(K,1),size(K,2));
Dpn=zeros(size(K,1),size(K,2));

% Calculate Dppn0 using F=ma;
Dppn=R./M;

% Create force matrix for after teff
R0=zeros(size(R,1),size(R,2));

T=0:dt:t;
I=size(T,1);

% Loop over time
for i=1:I
    POS(i,:,:)=Dn(:,:);
    VEL(i,:,:)=Dpn(:,:);
    ACC(i,:,:)=Dppn(:,:);
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
POS(I,:,:)=Dn(:,:);
VEL(I,:,:)=Dpn(:,:);
ACC(I,:,:)=Dppn(:,:);

end