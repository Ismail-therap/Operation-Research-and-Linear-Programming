A = [-1 -1 2 1 0;1 -1 -1 0 1]
b = [-1;-5]
c = [2;1;3;0;0]
u = Inf*ones(1,5) 


basis = [4 5]
nonbasis0 = [1 2 3]
nonbasisu = []

basisupdateu

%x5 leaves and k = 2

ek = [0;1]
v = ek'*inv(B)*A(:,nonbasis0)
ratios = v./rn0

%x2 enters

basis = [2 4]
nonbasis0 = [1 3 5]
basisupdateu

% So, we got our optimal solution. Checking:

A'*y-c % all are less than or equal 0 .... we are done!

