cd C:\Users\TA-3\Desktop\OR\HW4

% Given Information
A = [1 2 1 0;2 3 0 1]
b = [2;4]
c = [-1;-1;0;0]
u = [1; 1; Inf; Inf]

%Initial basis x3 and x4
basis = [3 4]
nonbasis0 = [1 2]
nonbasisu = []
basisupdateu


%x1 enters basis, by Dantzig's rule
enteringvar = 1

a = A(:,enteringvar)
d = solveBxb(L, U, p, a)

eps2 = 1.0e-4 ; eps3 = 1.0e-4

[tlimit,leavingvar,leavingbound] = ratiotestu(basis,xb,ub,d,u(enteringvar),eps2,eps3);

basis = [3 4]
nonbasis0= [2]
nonbasisu = [1]

basisupdateu

%x2 enters, increasing
enteringvar=2

a = A(:,enteringvar)
d = solveBxb(L, U, p, a)

[tlimit,leavingvar,leavingbound] = ratiotestu(basis,xb,ub,d,u(enteringvar),eps2,eps3);
%x2 increase all the way to 0.5 and x3 is the leaving variable goes to 0

basis = [2 4]
nonbasisu = [1]
nonbasis0 = [3]
basisupdateu

%reducedatzero providing positive value so, if we increase x3 then it will
%also increase z and reducedatupper providing negative value corresponding
%to x1 as x1 is at nonbasisu, so if we decrease x1 then it will also
%increase z. 

%Checking:
A*x-b

%So, this LP is optimized. 





