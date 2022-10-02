
%Phase-1

% Given Information
A = [1 2 1 -1 1 0;-3 1 1 3 0 1]
b = [7;9]
c = [1;-3;-6;1;0;0]
u = [1;5;8;1; Inf; Inf]

%Initial basis x5 and x6
basis = [5 6]
nonbasis0 = [1 2 3 4]
nonbasisu = []
basisupdateu

%x3 enters basis, by Dantzig's rule
enteringvar = 3

a = A(:,enteringvar)
d = solveBxb(L, U, p, a)

eps2 = 1.0e-4 ; eps3 = 1.0e-4

[tlimit,leavingvar,leavingbound] = ratiotestu(basis,xb,ub,d,u(enteringvar),eps2,eps3)


basis = [3 6]
nonbasis0= [1 2 4 5]
nonbasisu = []

basisupdateu

%x4 enters basis, by Dantzig's rule
enteringvar = 4

a = A(:,enteringvar)
d = solveBxb(L, U, p, a)

eps2 = 1.0e-4 ; eps3 = 1.0e-4

[tlimit,leavingvar,leavingbound] = ratiotestu(basis,xb,ub,d,u(enteringvar),eps2,eps3)

basis = [3 4]
nonbasis0= [1 2 5 6]
nonbasisu = []

basisupdateu

%LP is optimal and phase 1 complete. The starting basis for Phase 2 is x3
%and x4 (But I have confusion on that because the solution for x3 = -7 and 
% x4 = 9 1st iteration phase 2, so need to think from here to solve this problem)