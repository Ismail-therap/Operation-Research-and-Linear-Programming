
A = [1 2 3 1 1 0;1 1 2 3 0 1];
b=[5; 3];
c = [-5;-6;-9;-8;0;0];

% Initial basis = x5, x6
basis = [5 6];
nonbasis = [1:4];

basisupdate

%by Dantzig's rule, x3 will enter the basis
% we want he coefficients of x3 from inv(B)*AN

a = A(:,3);
d = solveBxb(L,U,p,a);
xb

% we want to maximize t subject to [5;3] - t*[3;2] >= 0
% x6 will decrease to 0 and leave the basis 
% New basis is x3, x5

basis = [3 5];
nonbasis = [1 2 4 6];
basisupdate

% x2  enter by Dantzig's rule
a = A(:,2);
d = solveBxb(L,U,p,a);
xb


% we want to maximize t subject to [1.5;0.5] - t*[0.5;0.5] >= 0
% x5 will decrease to 0 and leave the basis
% New basis is x2, x3


basis = [2 3];
nonbasis = [1 4 5 6];
basisupdate

% x4  enter by Dantzig's rule
a = A(:,4);
d = solveBxb(L,U,p,a);
xb

% we want to maximize t subject to [1;1] - t*[-7;5] >= 0
% x3 will decrease to 0 and leave the basis
% New basis is x2, x4

basis = [2 4];
nonbasis = [1 3 5 6];
basisupdate

% x1  enter by Dantzig's rule
a = A(:,1);
d = solveBxb(L,U,p,a);
xb


% we want to maximize t subject to [2.4;.2] - t*[.4;.2] >= 0
% x4 will decrease to 0 and leave the basis
% New basis is x1,x2

basis = [1 2];
nonbasis = [3 4 5 6];
basisupdate


% so found our optimal solution for basis = x1 and x2. x = -17. 