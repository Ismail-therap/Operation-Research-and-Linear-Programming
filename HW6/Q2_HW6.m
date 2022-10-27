cd C:\Users\TA-3\Desktop\OR\HW6


% Given Information
A = [-1 -1 2 1 0;1 -1 -1 0 1]
b = [-1;-5]
c = [2;1;3;0;0]
u = [Inf; Inf; Inf; Inf;Inf]


%Optimal basis for this problem is x2, x4

basis = [2 4]
nonbasis0 = [1 3 5]
nonbasisu = []
basisupdateu


%Required values
xstar = xb
ystar = y
z



%Check the Ranging and sensitivity analysis of b(1)


ei = [1;0]

d = solveBxb(L,U,p,-ei)



eps2 = 1.0e-5; eps3 = 1.0e-5; 

%Upper limit for delb
[tlimit,leavingvar,leavingbound] = ratiotestu(basis,xb,ub,d,+Inf,eps2,eps3)
upperlimit = tlimit

%Lower limit for delb
[tlimit,leavingvar,leavingbound] = ratiotestu(basis,xb,ub,-d,+Inf,eps2,eps3)
lowerlimit = tlimit

%Limit of b1
[b(1)- lowerlimit b(1)+ upperlimit]


%Will be optimal because rn0 does not depend on b

% Sensitivity 

y1star = y(1)


%As y1star is 0; sensitivity will be 0 if we change b1 between -5 to Inf.



% Range for c1
%cj-rj =-1  (cj = 2, rj = 3)

% [-1 Inf]

% Sensitivity are 0 within the ranges, because c1 is nonbasis0.



