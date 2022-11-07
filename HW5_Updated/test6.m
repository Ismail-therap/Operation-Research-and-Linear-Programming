%
% Test the simplex solver.  Optimal value=-18.7519
%
load e226.mat
%
% Solve it. 
%
[xstar,optobj,optbasis,nonbasis0,nonbasisu,totaliters,raystar,ystar,wstar,zstar]=solvelp(A,b,c,u,const,[],100);
%
% Check the results
%
pfeas=norm(A*xstar-b)/norm(b)
cx=c'*xstar+const
optobj
dobj=ystar'*b-wstar'*u+const
dfeas=norm(ystar'*A-wstar'+zstar'-c')/norm(c)

