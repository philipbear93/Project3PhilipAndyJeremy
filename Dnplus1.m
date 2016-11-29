function [ Dn1 ] = Dnplus1( Dn,Dpn,Dppn,Rn1,gamma,beta,M,K,dt )
% Dnplus1 solves for D at t + dt (Dn1) given: 
% D at t (Dn)
% D' at t (Dpn)
% D'' at t (Dppn)
% R at t + dt (Rn1)
% gamma
% beta
% Mass matrix (M)
% Stiffness matrix (K)
% time step (dt)
% Assume geometric damping C is 0

% Calculate Dtpdt
Part1=(1/(beta*dt^2))*M+K;
Part2=Rn1+M*((1/(beta*dt^2))*Dn+(1/(beta*dt))*Dpn+(1/(2*beta)-1)*Dppn);
Dn1=Part1\Part2;
end

