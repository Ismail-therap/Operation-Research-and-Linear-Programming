%
% [B,L,U,p,cb,cn0,cnu,ub,un0,unu,xb,y,rn0,rnu,z]=updateB(...
%         A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2)
%
function [B,L,U,p,cb,cn0,cnu,ub,un0,unu,xb,y,rn0,rnu,z]=updateB(...
         A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2)
%
% Update everything else. 
%
B=A(:,basis);
[L,U,p]=lu(B,'vector');
cb=c(basis);
cn0=c(nonbasis0);
cnu=c(nonbasisu);
ub=u(basis);
un0=u(nonbasis0);
unu=u(nonbasisu);
%
% Solve for xb.
%
if (length(nonbasisu)>0)
  xb=solveBxb(L,U,p,b)-solveBxb(L,U,p,A(:,nonbasisu)*unu);
else
  xb=solveBxb(L,U,p,b);
end
%
% Check xb for feasibility and stop immediately if it isn't
% feasible.  We increase the tolerance here because sometimes
% Round-offf errors result in xb being a bit further away from
% its limits.
%
if (min(xb) < -epsilon2*100)
  fprintf('Error, negative entry in xb=%e\n',min(xb));
  error('Stopping');
end
if (max(xb-ub) > epsilon2*100)
  fprintf('Error, max(xb-ub)=%e\n',max(xb-ub));
  error('Stopping');
end
%
% Check that xb is in range.
%
%
% Solve for y.
%
y=solveyBc(L,U,p,cb);
%
% Find the reduced costs.
%
if (length(nonbasis0) > 0)
  rn0=cn0'-y'*A(:,nonbasis0);
else
  rn0=[];
end
if (length(nonbasisu) > 0)
  rnu=cnu'-y'*A(:,nonbasisu);
else
  rnu=[];
end
if (length(nonbasisu)>0)
  z=y'*b+rnu*unu+const;
else
  z=y'*b+const;
end