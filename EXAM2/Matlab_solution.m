cd C:\Users\TA-3\Desktop\OR\Exam2

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