
%
% Update B, AN, ... after a change in basis.
%
B=A(:,basis);
AN=A(:,nonbasis);
cb=c(basis);
cn=c(nonbasis);
%
% Compute the LU factorization of B.  Use the vector form of the
% permutation.  
%
[L,U,p]=lu(B,'vector');
%
% Calculate y'=cb'*inv(B).  
%
y=solveyBc(L,U,p,cb)
%
% Update the reduced costs.
%
rn=cn'-y'*AN;
%
% Calculate the new basic solution.
%
xb=solveBxb(L,U,p,b);
x=zeros(length(c),1);
x(basis)=xb
%
% Compute the new objective value.
%
z=y'*b
%
% Output the new reduced costs and nonbasis so that we can check optimality
% and pick a new entering variable.
%
[rn; nonbasis]
