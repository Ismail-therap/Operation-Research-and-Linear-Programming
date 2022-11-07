%
% [x,optobj,optbasis,nonbasis0,nonbasisu,totaliters,ray,y,w,z]=simplex(A,b,c,u,const,maxiters,printlevel)
%
% Solves an LP of the form 
%
% min c'*x+const
%     Ax=b
%      x >= 0
%      x <= u          (upper bounds may be +Inf)  
%
% by the two-phase simplex method.
%
% Inputs:
%   A,b,c,u,const     Problem data.
%   maxiters          Maximum number of iterations, defaults to
%                     200*max(m,n/10)
%   printlevel        if 0, output nothing at all.
%                     if >0, output information every printlevel 
%                     iterations and at the start and end of each phase.
%                     e.g. "400: obj=27.2" if obj is 27.2 at the
%                     completion of the 400th iteration of phase I.
%                     Defaults to 0.
%
% Outputs:
%  1. If the LP has an optimal BFS,
%     x              optimal solution.
%     optobj         optimal objective value.
%     optbasis       row vector listing basic variables.
%     nonbasis0      row vector of variables nonbasic at 0.
%     nonbasisu      row vector of variables nonbasic at u.
%     totaliter      total phase I and phase II iterations.
%     ray            zeros(n,1)
%     y              optimal dual solution as a column vector
%     w              optimal dual solution as a column vector
%     z              optimal dual solution as a column vector
%
%  2. If the LP is infeasible,
%     x              NaN*ones(n,1)
%     optobj         NaN
%     optbasis       []
%     nonbasis0      []
%     nonbasisu      []
%     totaliters     Phase I iterations.
%     ray            NaN*ones(n,1)
%     y              NaN*ones(m,1)
%     w              NaN*ones(n,1)
%     z              NaN*ones(n,1)
%
%  3. If the LP is unbounded,
%     x              Last BFS.
%     optobj         -Inf
%     optbasis       Last basis
%     nonbasis0      Last nonbasis0
%     nonbasisu      Last nonbasisu
%     totaliters     total phase I and phase II iterations.
%     ray            optimal ray.  c*(x+t*ray) -> -infinity as
%                    t->infinity, A*(x+t*ray)=b, 0<=x+t*ray<=u.
%     y              NaN*ones(m,1)
%     w              NaN*ones(n,1)
%     z              NaN*ones(n,1)
%
%  4. If max iterations exceeded in either phase, exit with
%     error('max iterations exceeded')
%
function [xstar,optobj,optbasis,nonbasis0,nonbasisu,totaliters,ystar,wstar,zstar]=my_simplex(A,b,c,u,const,maxiters,printlevel)
% xstar,optobj,optbasis,nonbasis0,nonbasisu,totaliters,raystar,ystar,wstar,zstar
% Zero tolerances.
%
epsilon1=1.0e-5;
epsilon2=1.0e-5;
epsilon3=1.0e-5;
%
% Get basic problem size data.
%
[m,n]=size(A);
[old_m,old_n]=size(A);

%
% Set default parameters if needed.
%
if ((nargin < 6) | isempty(maxiters))
  maxiters=200*max(m,n/10);
end
if ((nargin < 7) | isempty(printlevel))
  printlevel=0;
end
%
% Set default parameters if needed.
%
if ((nargin < 6) | isempty(maxiters))
  maxiters=10*m;
end
if ((nargin < 7) | isempty(printlevel))
  printlevel=0;
end




% Step 1: My first method to update A, b, c, u to start the process
Original_A = A;
Original_c = c;
Original_u = u;

[A,basis,nonbasis0,nonbasisu,c,u,m,n]= update_a_b_c_u(A,b,c,u);


if n>old_n
    [A,c,u,optbasis,nonbasis0,nonbasisu,wstar,totaliters,xstar,ystar,zstar,optobj] = phase_1(A,b,c,u,0,basis,nonbasis0,nonbasisu,epsilon2)
    
    % Get back to original A, c and u
%     xstar;
%     wstar;
%     Iteration;
%     A = Original_A;
%     c = Original_c;
%     u = Original_u;
%     basis = basis;
%     nonbasis0 = [1:n]
%     nonbasis0 = setdiff(nonbasis0,basis);
%     nonbasisu = [];

if abs(wstar)~=0
    return
end
end


% Starting Phase II
[xstar,optobj,optbasis,nonbasis0,nonbasisu,totaliters,ray,ystar,wstar,zstar] = phase_2_new(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2)  









end



