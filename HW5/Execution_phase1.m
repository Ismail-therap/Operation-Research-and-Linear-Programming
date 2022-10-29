cd C:\Users\TA-3\Desktop\OR\HW5\hw5files\hw5files


A=[1 -3 -1 2;1 2 0 -1];
b=[-1; 2];
c=[1; 1; 0;0];
u=1*ones(4,1);


epsilon1=1.0e-5;
epsilon2=1.0e-5;
epsilon3=1.0e-5;
const = 0;
pivotrule = 0;

% Selecting basis, nonbasis0, nonbasisu, c, u, m and n 
[A,basis,nonbasis0,nonbasisu,c,u,m,n]= phase_selection(A,b,c,u)
[basis,nonbasis0,nonbasisu,rn0,rnu,xb,ub,y,B,L,U,p] = phase_one(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2) 

%%Till this point everyting good


% Need to start from poivotselection function:

[enteringvar,leavingvar,increasingdecreasing,d,leavingbound,tlimit]= pivotselection(basis,nonbasis0,nonbasisu,xb,ub,y,rn0,rnu,A,u,B,L,U,p,epsilon1,epsilon2,epsilon3,pivotrule)


% Surprisingly while is working but not producing any results:

while (abs(rn0)>=epsilon1 & abs(rnu)<=epsilon1)
   [basis,nonbasis0,nonbasisu,rn0,rnu,xb,ub,y,B,L,U,p] = phase_one(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2) 
   if iteration >= 200*max(m,n/10)
        break
    end
end









