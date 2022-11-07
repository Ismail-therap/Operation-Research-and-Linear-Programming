function [xstar,optobj,optbasis,nonbasis0,nonbasisu,totaliters,raystar,ystar,wstar,zstar] = phase_1(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2)

epsilon1=1.0e-5;
epsilon2=1.0e-5;
epsilon3=1.0e-5;


[B,L,U,p,cb,cn0,cnu,ub,un0,unu,xb,y,rn0,rnu,z]=updateB(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2);




[m,n]=size(A);
Iteration = 0;

% Starting Phase I
fprintf('Starting Phase I\n');

x = zeros(n,1);
x(basis)= xb;
xu = u(nonbasisu);
x(nonbasisu)= xu;

optbasis = basis;
nonbasis0 = nonbasis0;
nonbasisu = nonbasisu;
optobj = z;
xstar = x;
ystar = y;
totaliters = Iteration;
w = -(c'*x);
wstar = w;
zstar= b'*y;

if w>epsilon1
    fprintf('LP is infeasible. w=%d\n',w);
    xstar= NaN*ones(n,1);
    optobj= NaN;
    optbasis= [];
    nonbasis0=[];
    nonbasisu=[];
    totaliters=Iteration;     %Phase I iterations.
    raystar=NaN*ones(n,1);
    ystar=NaN*ones(1,m);
    wstar=NaN*ones(1,n);
    zstar=NaN*ones(1,n);
    fprintf('Phase I finished in %d iterations\n', Iteration);
    return;
end


% Phase 1 while loop
while w<epsilon1 & (min(rn0) <-epsilon1 | max(rnu)> -epsilon1) 
    Iteration = Iteration+1
    
    if min(xb) > -epsilon1 && min(u-xb) > -epsilon1 && u>=-epsilon1
        [B,L,U,p,cb,cn0,cnu,ub,un0,unu,xb,y,rn0,rnu,z]=updateB(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2);
        [enteringvar,leavingvar,increasingdecreasing,d,leavingbound,tlimit]= pivotselection(basis,nonbasis0,nonbasisu,xb,ub,y,rn0,rnu,A,u,B,L,U,p,epsilon1,epsilon2,epsilon3,0);
        [basis,nonbasis0,nonbasisu]= update_all(basis,nonbasis0,nonbasisu,leavingbound,leavingvar,enteringvar,epsilon2,xb,rn0,z);
        
        
        x = zeros(n,1);
        x(basis)= xb;
        xu = u(nonbasisu);
        x(nonbasisu)= xu;
        w = c'*x
    else
        fprintf('LP is infeasible. w=%d\n',w);
        x= NaN*ones(n,1);
        optobj= NaN;
        optbasis= [];
        nonbasis0=[];
        nonbasisu=[];
        totaliters=Iteration;     %Phase I iterations.
        ray=NaN*ones(n,1);
        y=NaN*ones(1,m);
        w=NaN*ones(1,n);
        z=NaN*ones(1,n);
        fprintf('Iteration =%d, w= %d\n', Iteration, w);
        break;
        
    end
    
    
    if Iteration >= 200*max(m,n/10)
        break
    end
    
    optbasis = basis;
    nonbasis0 = nonbasis0;
    nonbasisu = nonbasisu;
    
    fprintf('Iteration =%d, w= %d\n', Iteration, w);
end

xstar = x;
optobj = optobj;
optbasis = basis;
nonbasis0 = nonbasis0;
nonbasisu = nonbasisu;
totaliters = Iteration;
raystar= ray;
ystar= y;
wstar = w ;
zstar = z;
end