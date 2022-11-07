%
% Test the simplex solver.  Optimal value is 5.5018e+3
%
load 25fv47.mat
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

