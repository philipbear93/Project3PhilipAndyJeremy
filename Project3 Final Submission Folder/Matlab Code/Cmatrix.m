function [ Cmat ] = Cmatrix( Kmat,Mmat,Zeta )
% Cmatrix calculates the global damping matrix from the stiffness and mass
% matrices and damping ratio Zeta
A=size(Kmat,1);
B=size(Kmat,2);
Cmat=zeros(A,B);
for i=1:A
    for j=1:B
        Cmat(i,j)=Clocal(Kmat(i,j),Mmat(i,j),Zeta);
    end
end
end

