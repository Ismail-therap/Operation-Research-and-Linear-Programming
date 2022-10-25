% Test the simplex solver.  This LP is infeasible with w=2.
%
A=[-2 1 0; -1 2 1];
b=[1; -1];
c=[-1; -1; -1];
u=+Inf*ones(3,1);




[m,n] = size(A)
c =  [zeros(1,n-m) ones(1,m)]'


all_x = 1:n;
basis = all_x(end-m+1:end)
nonbasis0 = setdiff(all_x,basis)
nonbasisu = []


const = 0;
pivotrule=0;
epsilon1=1.0e-5;
epsilon2=1.0e-5;
epsilon3=1.0e-5;




[B,L,U,p,cb,cn0,cnu,ub,un0,unu,xb,y,rn0,rnu,z]=updateB(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2)
[enteringvar,leavingvar,increasingdecreasing,d,leavingbound,tlimit]= pivotselection(basis,nonbasis0,nonbasisu,xb,ub,y,rn0,rnu,A,u,B,L,U,p,epsilon1,epsilon2,epsilon3,pivotrule)

% Updating nonbasis0, nonbasisu and basis elements

nonbasis0 = setdiff(nonbasis0,enteringvar);
if (leavingbound==0)
    nonbasis0 = sort([nonbasis0 leavingvar]);
else
    nonbasisu = sort([nonbasisu leavingvar]);
end

basis = setdiff(basis,leavingvar);
basis = sort([basis enteringvar]);










