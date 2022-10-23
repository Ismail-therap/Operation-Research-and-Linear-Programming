%
% Test the simplex solver.  This LP is unbounded.
%
A=[-1 1 1 0; -1 1 0 -1];
b=[1; -1];
c=[-1; 0; 0; 0];
u=+Inf*ones(4,1);
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
%
% Since this LP is unbounded, we've got a BFS and an optimal ray.
%
shouldbe0=A*raystar
