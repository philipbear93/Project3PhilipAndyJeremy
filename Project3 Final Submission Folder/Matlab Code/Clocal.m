function [ Cloc ] = Clocal( Kloc,Mloc,Zeta )
% Clocal calculates the local damping value from the local mass,
% stiffness and damping ratio (Zeta)
Cloc=Zeta*(2*Mloc*sqrt(Kloc/Mloc));
end

