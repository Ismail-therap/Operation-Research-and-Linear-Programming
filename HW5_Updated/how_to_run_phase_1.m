A=[-2 1 0; -1 2 1];
b=[1; -1];
c=[-1; -1; -1];
u=+Inf*ones(3,1);

epsilon1=1.0e-5;
epsilon2=1.0e-5;
epsilon3=1.0e-5;

[A,basis,nonbasis0,nonbasisu,c,u,m,n]= update_a_b_c_u(A,b,c,u);
[A,c,u,basis,nonbasis0,nonbasisu,wstar,Iteration] = phase_1(A,b,c,u,0,basis,nonbasis0,nonbasisu,epsilon2);