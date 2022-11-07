% [enteringvar,leavingvar,increasingdecreasing,d,leavingbound,tlimit]=...
%    pivotselection(basis,nonbasis0,nonbasisu,xb,ub,y,rn0,rnu,A,u,B,L,U, ...
%		   p,epsilon1,epsilon2,epsilon3,pivotrule)
%
% Pick the entering and leaving variables.  
% 
% 1. If enteringvar==leavingvar, then the variable flips bounds.
%
% 2. If leavingvar=0, tlimit=+Inf, then the LP is unbounded.  
%
% 3. If enteringvar ~= leavingvar and tlimit < Inf, we have a
% pivot.
%
function [enteringvar,leavingvar,increasingdecreasing,d,leavingbound,tlimit]=...
    pivotselection(basis,nonbasis0,nonbasisu,xb,ub,y,rn0,rnu,A,u,B,L,U,p,epsilon1,epsilon2,epsilon3,pivotrule)
%
% Force pivotrule=0 for now.
%
%
% Get the size of the problem.
%
[m,n]=size(A);
%
% Do the different pivot rules.
%
%
% 0. Dantzig's rule: the largest coefficient rule.
%
if (pivotrule==0)
%
% Get the minimum of rn0 and the maximum of rnu.
%
  if (length(nonbasis0)>0)
    [minrn0,minrn0index]=min(rn0);
  else
    minrn0=0;
    minrn0index=-1;
  end
  if (length(nonbasisu)>0)
    [maxrnu,maxrnuindex]=max(rnu);
  else
    maxrnu=0;
    maxrnuindex=-1;
  end
%
% Take the larger of -maxrn0 or minrnu.
%
  if (-minrn0 > maxrnu)
%
% The entering variable will increase.
%
    enteringvar=nonbasis0(minrn0index);
    increasingdecreasing=1;
    d=solveBxb(L,U,p,A(:,enteringvar));
    limitentering=u(enteringvar);
  else
%
% The entering variable will decrease from u.
%
    enteringvar=nonbasisu(maxrnuindex);
    increasingdecreasing=0;
    d=-solveBxb(L,U,p,A(:,enteringvar));
    limitentering=u(enteringvar);
  end
%
% Do the ratiotest to find the leaving variable.
%
  [tlimit,leavingvar,leavingbound]=ratiotestub(basis,xb,ub,d, ...
			       limitentering,epsilon2,epsilon3);
%
% We're done.
%
  return
end
