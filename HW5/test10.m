%
% Test the simplex solver.  Optimal value is -6.8464293e+04
%
load fit2d.mat
%
% Solve it.
%
[xstar,optobj,optbasis,nonbasis0,nonbasisu,totaliters,raystar,ystar,wstar,zstar]=solvelp(A,b,c,u,const,[],100);
%
% Check the results.  For this problem only, norm(b)=0, so we add 1
% in the denominator of pfeas.
%
pfeas=norm(A*xstar-b)/(1+norm(b))
cx=c'*xstar+const
optobj
dobj=ystar'*b-wstar'*u+const
dfeas=norm(ystar'*A-wstar'+zstar'-c')/norm(c)


