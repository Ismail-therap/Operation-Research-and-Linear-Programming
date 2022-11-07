%
% Test the simplex solver.  This LP has an optimal solution with z=-4.
%
A=[2 -1 1 0; 1 2 0 1];
b=[2; 6];
c=[-1; -1; 0; 0];
u=+Inf*ones(4,1);
%
% Solve it.
%
[xstar,optobj,optbasis,nonbasis0,nonbasisu,totaliters,raystar,ystar,wstar,zstar]=solvelp(A,b,c,u,0,[],1);
%
% Check the results
%
xstar
ystar
wstar
zstar
Axb=A*xstar-b
cx=c'*xstar
optobj
