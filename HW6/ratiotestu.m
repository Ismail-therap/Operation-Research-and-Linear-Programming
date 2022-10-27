%
% [tlimit,leavingvar,leavingbound]=ratiotestu(basis,xb,ub,d, ...
%                                            limitentering,epsilon2,epsilon3)
%
% Finds the leaving basic variable in the simplex method by solving 
%
%   max t
%       0 <= xb-t*d <= ub
%             t     <= limitentering
%
% With tolerance epsilon3 on xb with respect to lower bound of 0
% and upper bound of ub, and 0 tolerance epsilon2 on
% entries of d. 
%
% Inputs:
%     xb               Current basic variable values.
%     ub               Upper bounds on current basic variables.
%     d                Coefficients of the entering variable 
%     limitentering    Initial limit on t, normally u(enteringvar)
%     eps2             0 tolerance for entries of xb.
%     eps3             0 tolerance for entries of d.
%
% Outputs:
%    tlimit            Limit on t.  +Inf if unbounded.
%    leavingvar        Number of the varaible that will leave the basis.
%    leavingbound      0 if leaving at 0, 1 if leaving at ub.
%
% For an entering variable that is increasing, use d=B\a.  If the variable
% is decreasing from its upper bound, use -d.
%
% In the case that a variable is flipping from its upper bound to
% lower bound or vice versa, leavingvar=0, leavingbound=1, and
% tlimit=u(var).  You will need to determine whether the variable
% was increasing or decreasing to see which part of the nonbasis it
% should switch to.
%
function [tlimit,leavingvar,leavingbound]=ratiotestu(basis,xb,ub,d,limitentering,eps2,eps3)
%
% Get the size of the basis.
%
m=length(basis);
%
% Default values in case there is no limit.  These values will be
% returned if nothing else stops t from increasing.
%
tlimit=limitentering;
leavingbound=1;
leavingvar=0;
%
% Loop over entries in xb(1:m).
%
for k=1:m
%
% First check for a basic variable already at 0.
%
  if (xb(k) <= eps2)
%
% xb(k) is currently effectively 0.
%
%
% Check whether d(k) > 0 or not.
%
    if (d(k) > eps3)
      %
      % We've got a degenerate pivot.  Always take this.
      % 
      leavingvar=basis(k);
      tlimit=0;
      leavingbound=0;
      return
    else
      %
      % Check to see if d(k) < 0.  This variable could increase to
      % its upper bound.
      % 
      if (d(k) < -eps3)
	%
	% Now check to see if this imposes a tighter limit on t.
	%
	if (ub(k)/(-d(k)) < tlimit)
	  tlimit=ub(k)/(-d(k));
	  leavingvar=basis(k);
	  leavingbound=1;
	end
	%
	% Keep looking for other, even tigheter, limits on t.
	%
	continue
      end % d(k) < -eps3
    end % d(k) > eps3
  end % xb(k) is effectively 0.

%
% Next check for a basic variable already at upper bound.
%
  if ((ub(k)-xb(k)) <= eps2)
%
% xb(k) is currently at its upper bound.
%
%
% Check whether d(k) < 0 or not.
%
    if (d(k) <- eps3)
      %
      % We've got a degenerate pivot.  Always take this.
      % 
      leavingvar=basis(k);
      tlimit=0;
      leavingbound=1;
      return
    else
      %
      % Check to see if d(k) > 0.  This variable could decrease to 0.
      % 
      if (d(k) > eps3)
	%
	% Check to see if this gives a new limit on the max t.
	%
	if (ub(k)/d(k) < tlimit)
	  tlimit=ub(k)/d(k);
	  leavingvar=basis(k);
	  leavingbound=0;
	end
	continue
      end
    end
  end % xb(k) is at ub(k).

%
% xb(k) is strictly within its bounds.  Note that we don't need an
% if condition here, since we will have used "break" or "continue" 
% if xb(k) were at 0 or its upper bound.  
%
%
% Check to see if the entry in d is effectively 0.  If so, then
% this won't be limiting, so go on to the next entry in xb.
%
  if (abs(d(k)) < eps3)
    continue;
  end
%
% Now, d(k) must either be effectively positive or
% effectively negative.
%
  if (d(k) >= eps3)  
    %
    % We've got a regular pivot.  This may or may not
    % end up being our actual limit, so we'll adjust tlimit and keep
    % checking.
    % 
    if (xb(k)/d(k) < tlimit)
      %
      % This sets a new limit on t.
      %
      tlimit=xb(k)/d(k);
      leavingvar=basis(k);
      leavingbound=0;
      continue;
    end
  else
    %
    % d(k) must be effectively negative.  We could be limited by
    % xb(k)'s upper bound.
    %
    if ((xb(k)-ub(k))/d(k) < tlimit)
      %
      % This sets a new limit on t.
      %
      tlimit=(xb(k)-ub(k))/d(k);
      leavingvar=basis(k);
      leavingbound=1;
      continue;
    end
  end
end
%
% make sure that tlimit is reasonable.
%
if (tlimit < 0)
  fprintf('tlimit=%e\n',tlimit);
  error('tlimit is negative!');
end