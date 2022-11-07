%
% Test the simplex solver.  This LP has an optimal solution with z=-13.
%
A=[2 3 1 1 0 0; 4 1 2 0 1 0; 3 4 2 0 0 1];
b=[5; 11; 8];
c=[-5; -4; -3; 0; 0; 0];
u=+Inf*ones(6,1);
%
% Solve it.
%
[xstar,optobj,optbasis,nonbasis0,nonbasisu,totaliters,raystar,ystar,wstar,zstar]=solvelp(A,b,c,u,0,[],1);
%
% Check the results
%
Axb=norm(A*xstar-b)
cx=c'*xstar
optobj

