cd C:\Users\TA-3\Desktop\OR\HW4

%Phase-1

% Given Information
A = [1 2 1 -1 1 0;-3 1 1 3 0 1]
b = [7;9]
c = [0;0;0;0;1;1]
u = [1;5;8;1; Inf; Inf]

%Initial basis x5 and x6
basis = [5 6]
nonbasis0 = [1 2 3 4]
nonbasisu = []
basisupdateu

%x2 enters basis, by Dantzig's rule
enteringvar = 2

a = A(:,enteringvar)
d = solveBxb(L, U, p, a)

eps2 = 1.0e-4 ; eps3 = 1.0e-4

[tlimit,leavingvar,leavingbound] = ratiotestu(basis,xb,ub,d,u(enteringvar),eps2,eps3)


basis = [2 6]
nonbasis0= [1 3 4 5]
nonbasisu = []

basisupdateu

%x4 enters basis, by Dantzig's rule
enteringvar = 4

a = A(:,enteringvar)
d = solveBxb(L, U, p, a)


[tlimit,leavingvar,leavingbound] = ratiotestu(basis,xb,ub,d,u(enteringvar),eps2,eps3)

% as non of the basis is becomem 0 if we increase x4 to it's highest limit.
% x4 enters the nonbasisu

basis = [2 6]
nonbasis0= [1 3 5]
nonbasisu = [4]

basisupdateu


%x3 enters basis, by Dantzig's rule
enteringvar = 3

a = A(:,enteringvar)
d = solveBxb(L, U, p, a)


[tlimit,leavingvar,leavingbound] = ratiotestu(basis,xb,ub,d,u(enteringvar),eps2,eps3)

basis = [2 3]
nonbasis0= [1 6 5]
nonbasisu = [4]

basisupdateu

% The LP is optimal and z = 0. So, we can use x2 and x3 as our initial
% basis for phase 2


% Given Information
A = [1 2 1 -1;-3 1 1 3]
b = [7;9]
c = [1;-3;-6;1]
u = [1;5;8;1]


%Initial basis x2 and x3
basis = [2 3]
nonbasis0 = [1]
nonbasisu = [4]
basisupdateu

%x1 enters basis, by Dantzig's rule
enteringvar = 1

a = A(:,enteringvar)
d = solveBxb(L, U, p, a)


[tlimit,leavingvar,leavingbound] = ratiotestu(basis,xb,ub,d,u(enteringvar),eps2,eps3)

basis = [1 3]
nonbasis0 = [2]
nonbasisu = [4]
basisupdateu

%The sign of x4 is positive, so if we reduce x4 then objective function
%should decrease. 

enteringvar = 4

a = A(:,enteringvar)
d = solveBxb(L, U, p, a)


[tlimit,leavingvar,leavingbound] = ratiotestu(basis,xb,ub,-d,u(enteringvar),eps2,eps3)


basis = [4 3]
nonbasis0 = [1 2]
nonbasisu = []
basisupdateu


% So, we found an optimal solution for the LP.