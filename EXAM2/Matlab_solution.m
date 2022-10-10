cd C:\Users\TA-3\Desktop\OR\HW4

% Question 1. 

A = [1 5 16;0 4 5;2 2 4]
I3 = eye(3)

P1 = I3([3 2 1],:)
P1*A
L1 = I3; L1(2,1)=0; L1(3,1) = -.5
L1*P1*A

P2 = I3
P2*L1*P1*A
L2 = I3; L2(3,2) = -1
L2*P2*L1*P1*A

U = ans
P = P2*P1
L = P*inv(P1)*inv(L1)*inv(P2)*inv(L2)


P*A-L*U

%Looks a correct solution!


%Question 3:

%Phase-1

% Given Information
A = [1 -3 -1 2 -1 0;1 2 0 -1 0 1]
b = [-1;2]
c = [0;0;0;0;1;1]
u = [1;1;1;1; Inf; Inf]


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

%x5 leaving the basis and leaving bound 0, so x5 entering to nonbasis0
%group

basis = [2 6]
nonbasis0= [1 3 4 5]
nonbasisu = []

basisupdateu

%x1 enters basis, by Dantzig's rule
enteringvar = 1

a = A(:,enteringvar)
d = solveBxb(L, U, p, a)


[tlimit,leavingvar,leavingbound] = ratiotestu(basis,xb,ub,d,u(enteringvar),eps2,eps3)

%x6 leaving the basis and leaving bound 0, so x1 entering to nonbasis0
%group

basis = [1 2]
nonbasis0= [1 3 4 5 6]
nonbasisu = []
basisupdateu

% The LP is optimal and z = 0. So, we can use x1 and x2 as our initial
% basis for phase 2

% Phase 2:


% Given Information
A = [1 -3 -1 2;1 2 0 -1]
b = [-1;2]
c = [1;1;0;0]
u = [1;1;1;1]


%Initial basis x1 and x2
basis = [1 2]
nonbasis0 = [3 4]
nonbasisu = []
basisupdateu

% We got our optimal solution for this LP because reducedatzero(r) is non
% negative and x1 = 0.8 and x2 = 0.6.
