% Phase-1


A = [1 -1 1 0 0 -1 0 0;-1 -1 0 1 0 0 -1 0;2 -1 0 0 1 0 0 1]
b = [-1;-3;2]
c = [0;0;0;0;0;1;1;1]

%Initial basis x6, x7, x8
basis = [6 7 8]
nonbasis = [1:5]
basisupdate

%by Dantzig's rule, x1 will enter the basis
% we want he coefficients of x1 from inv(B)*AN

a = A(:,1)
d = solveBxb(L,U,p,a)
xb

% we want to maximize t subject to [1;3;2] - t*[-1;1;2] >= 0
% x8 will decrease to 0 and leave the basis 
% New basis is x1, x6, x7

basis = [1 6 7]
nonbasis = [2 3 4 5 8]
basisupdate

%by Dantzig's rule, x2 will enter the basis
% we want he coefficients of x2 from inv(B)*AN


a = A(:,2)
d = solveBxb(L,U,p,a)
xb

% we want to maximize t subject to [1;2;2] - t*[-0.5;0.5;1.5] >= 0
% x7 will decrease to 0 and leave the basis 
% New basis is x1,x2, x6


basis = [1 2 6]
nonbasis = [3 4 5 7 8]
basisupdate

%by Dantzig's rule, x2 will enter the basis
% we want he coefficients of x2 from inv(B)*AN

a = A(:,5)
d = solveBxb(L,U,p,a)
xb

% we want to maximize t subject to [1.6667;1.3333;1.3333] - t*[0.3333;-0.3333;0.6667] >= 0
% x6 will decrease to 0 and leave the basis 
% New basis is x1,x2, x5

basis = [1 2 5]
nonbasis = [3 4 6 7 8]
basisupdate

% we have finished phase 1 because this an optimal solution with z = 0. So,
% for phase 2 we can consider x1, x2, x7 as the starting basis

% Phase 2

A = A(:,1:5)
c = [-3;-1;0;0;0]

basis = [1 2 5]
nonbasis = [3 4]

basisupdate

%by Dantzig's rule, x4 will enter the basis
% we want he coefficients of x4 from inv(B)*AN

a = A(:,4)
d = solveBxb(L,U,p,a)
xb

% we want to maximize t subject to [1;2;2] - t*[-0.5;-0.5;.5] >= 0
% x5 will decrease to 0 and leave the basis 
% New basis is x1,x2, x4

basis = [1 2 4]
nonbasis = [3 5]

basisupdate

%by Dantzig's rule, x3 will enter the basis
% we want he coefficients of x3 from inv(B)*AN

a = A(:,3)
d = solveBxb(L,U,p,a)
xb

% we want to maximize t subject to [3;4;4] - t*[-1;-2;-3] >= 0

% The LP is unbounded !!!