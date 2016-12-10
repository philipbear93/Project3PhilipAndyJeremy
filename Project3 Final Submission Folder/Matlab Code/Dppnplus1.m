function [ Dppn1 ] = Dppnplus1( Dn,Dpn,Dppn,Dn1,beta,dt )
% Dppnplus1 returns the second derivative of D at t + dt (Dpn1) given:
% D at t (Dn)
% D' at t (Dpn)
% D'' at t (Dppn)
% D at t + dt (Dn1)
% beta
% time step (dt)

% Calculate Dppn1
Part1=(1/(beta*dt^2))*(Dn1-Dn-dt*Dpn);
Part2=(1/(2*beta)-1)*Dppn;
Dppn1=real(Part1-Part2);

end

