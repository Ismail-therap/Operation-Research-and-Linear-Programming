cd C:\Users\TA-3\Desktop\OR\HW5\hw5files\hw5files

A=[-2 1 0; -1 2 1];
b=[1; -1];
c=[-1; -1; -1];
u=+Inf*ones(3,1);







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



[m,n] = size(A);

% m = row; n = column
% So, we have m number of constraints and n mumber of variables

all_x = 1:n;
basis = all_x(end-m+1:end)
nonbasis0 = setdiff(all_x,basis)
nonbasisu = []



const = 0;
epsilon2 = 1.0e-5;


[B,L,U,p,cb,cn0,cnu,ub,un0,unu,xb,y,rn0,rnu,z]=updateB(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2)


