%
% y=solveyBc(L,U,p,c)
%
% Solves the equation y'*B=c' for y, given the LU factorization L*U=B(p,:)
%
function y=solveyBc(L,U,p,c)
w=((U')\c);
v=((L')\w);
y=zeros(length(c),1);
y(p)=v;
