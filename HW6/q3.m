cd \\acad-filebox\u_drive\900358056\AD-Profile\Desktop\Ismail\HW4


A = [-1 -1 0 1 0;1 -1 -1 0 1]
b = [-2;-3]
c = [5;3;2;0;0]
u = Inf*ones(1,5) 


basis = [4 5]
nonbasis0 = [1 2 3]
nonbasisu = []

basisupdateu
pause

%x5 leaves the basis becasue it's the most negative one. As all reduced
%atzero are greater than 0 then we use dual simplex method
% k = 2 

ek = [0;1]
v = ek'*inv(B)*A(:,nonbasis0)
ratios = v./rn0

%x3 going to enter the basis becasue it's ratio is most negative

basis=[3 4]
nonbasis0 = [1 2 5]
basisupdateu

%x4 going to leave, k  = 2

v = ek'*inv(B)*A(:,nonbasis0)
ratios = v./rn0

%x2 going to enter 
basis=[2 3]
nonbasis0 = [1 4 5]
basisupdateu

% Checking 

A'*y-c

% As all entry less than or equal to 0 ... we are fine. Optimal solution z
% = 8.




