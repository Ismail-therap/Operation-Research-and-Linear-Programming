%
% Test the simplex solver.  This LP is infeasible with w=2.
%
A=[-2 1 0; -1 2 1];
b=[1; -1];
c=[-1; -1; -1];
u=+Inf*ones(3,1);
%
% Solve it.
%
[xstar,optobj,optbasis,nonbasis0,nonbasisu,totaliters,raystar,ystar,wstar,zstar]=solvelp(A,b,c,u,0,[],1);
