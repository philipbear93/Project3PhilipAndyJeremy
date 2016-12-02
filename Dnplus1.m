function [ Dn1 ] = Dnplus1( Dn,Dpn,Dppn,Rn1,gamma,beta,M,K,C,dt )
% Dnplus1 solves for D at t + dt (Dn1) given: 
% D at t (Dn)
% D' at t (Dpn)
% D'' at t (Dppn)
% R at t + dt (Rn1)
% gamma
% beta
% Mass matrix (M)
% Stiffness matrix (K)
% Damping Matrix (C)
% time step (dt)
% Assume geometric damping C is 0

% Calculate Dtpdt
Part1=(1/(beta*dt^2))*M+(gamma/(beta*dt))*C+K;
Part2=Rn1+M*((1/(beta*dt^2))*Dn+(1/(beta*dt))*Dpn+(1/(2*beta)-1)*Dppn);
Part3=C*((gamma/(beta*dt))*Dn+(gamma/beta-1)*Dpn+(gamma/beta-2)*(dt/2)*Dppn);
Dn1=Part1\(Part2+Part3);
end

