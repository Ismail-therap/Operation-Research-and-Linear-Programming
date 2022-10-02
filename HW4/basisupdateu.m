%
% Update B, AN, ... after a change in basis.
%
% Required inputs:
%   A, b, c, u                        Problem Data
%   basis, nonbasis0, nonbasisu       lists of basic and nonbasic variables.
%
% Outputs
%   B,cb,cn0,cnu,ub,unu               parts of the dictionary.
%   xb,xnu,x                          The basic solution.
%   y,rn0,rnu                         y and reduced costs.
%   z                                 The objective value
%   L,U,p                             LU factorization of B.
%
[m,n]=size(A);
B=A(:,basis);
cb=c(basis);
cn0=c(nonbasis0);
cnu=c(nonbasisu);
ub=u(basis);
unu=u(nonbasisu);
xnu=u(nonbasisu);
%
% Factor the basis.
%
[L,U,p]=lu(B,'vector');
%
% Now, use the LU factorization to compute xb.
%
if (length(nonbasisu) > 0)
  xb=solveBxb(L,U,p,b-A(:,nonbasisu)*xnu);
else
  xb=solveBxb(L,U,p,b);
end
%
% Compute the current basic solution.
%
x=zeros(n,1);
x(basis)=xb;
if (length(nonbasisu) > 0)
  x(nonbasisu)=xnu;
end
%
% Compute y and the reduced costs.
%
y=solveyBc(L,U,p,cb);
rn0=cn0'-y'*A(:,nonbasis0);
rnu=cnu'-y'*A(:,nonbasisu);
%
% Compute the current objective value.
%
if (length(nonbasisu) > 0)
  z=y'*b+rnu*xnu;
else
  z=y'*b;
end
%
% Output the new basic solution.
%
x
z
%
% Output the new reduced costs and nonbasis so that we can check optimality
% and pick a new entering variable.
%
reducedatzero=[rn0; nonbasis0]
reducedatupper=[rnu; nonbasisu]
