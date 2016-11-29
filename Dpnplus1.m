function [ Dpn1 ] = Dpnplus1( Dn,Dpn,Dppn,Dn1,gamma,beta,dt )
% Dpnplus1 returns the first derivative of D at t + dt (Dpn1) given:
% D at t (Dn)
% D' at t (Dpn)
% D'' at t (Dppn)
% D at t + dt (Dn1)
% gamma
% beta
% time step (dt)

% Calculate Dpn1
Part1=(gamma/(beta*dt))*(Dn1-Dn);
Part2=(gamma/beta-1)*Dpn;
Part3=dt*(gamma/(2*beta)-1)*Dppn;
Dpn1=Part1-Part2-Part3;

end

