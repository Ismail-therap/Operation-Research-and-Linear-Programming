% Given Information
A = [2 0 3 1 0;-1 2 0 0 1]
b = [6;4]
c = [-2;1;-1;0;0]
u = [Inf; Inf; Inf; Inf;Inf]


%Optimal basis for this problem is x2, x4

basis = [1 5]
nonbasis0 = [2 3 4]
nonbasisu = []
basisupdateu

% How far we decrease the coefficient of x2 in the objective function 
% OR we have to find the range for c(2)

c(2)-1 %[0 to Inf]


% What range values of the right hand side constant 6 in the first
% constraint would x1, x5 remain the optimal 


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

%b1 range [0 Inf]
