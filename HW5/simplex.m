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
function [x,optobj,optbasis,nonbasis0,nonbasisu,totaliters,ray,y,w,z]=simplex(A,b,c,u,const,maxiters,printlevel)
%
% Zero tolerances.
%
epsilon1=1.0e-5;
epsilon2=1.0e-5;
epsilon3=1.0e-5;
%
% Get basic problem size data.
%
[m,n]=size(A);
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






%%%%%%%%%%%%%%%%%%%%%%%% My adjustment starts here %%%%%%%%%%%%%%%%

%%% Phase 1 %%%%%%

c =  [zeros(1,n-m) ones(1,m)]'   % Updating c for phase 1

% Initiate the basis, nonbasis0 and nonbasisu 
all_x = 1:n;
basis = all_x(end-m+1:end)
nonbasis0 = setdiff(all_x,basis)
nonbasisu = []

% Running the updateB to get initial value for rn0 and rnu
[B,L,U,p,cb,cn0,cnu,ub,un0,unu,xb,y,rn0,rnu,z]=updateB(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2);

iteration = 0 % counting the iteration
pivot = 0 %considering initial pivot 0

if length(rn0)>0 && length(rnu)>0
    while (abs(rn0)>=epsilon1 & abs(rnu)<=epsilon1) % (abs(rnu)<=epsilon1) when I am adding this getting error 
    iteration = iteration+1;
    
    [B,L,U,p,cb,cn0,cnu,ub,un0,unu,xb,y,rn0,rnu,z]=updateB(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2);
    
    % Here "LP Infeasible" if xb<0 [Not sure how to declare infeasibility
    % when updateB giving us an error?]
    
    [enteringvar,leavingvar,increasingdecreasing,d,leavingbound,tlimit]= pivotselection(basis,nonbasis0,nonbasisu,xb,ub,y,rn0,rnu,A,u,B,L,U,p,epsilon1,epsilon2,epsilon3,pivotrule)
    
    if enteringvar==leavingvar
        fprintf("Bounds flip") % Not sure how to flip the bounds?
    elseif leavingvar==0 && tlimit==+Inf 
        fprintf("LP Unbounded") % % This is not the final output, I am testing with the text output!
    else
        if enteringvar ~= leavingvar && tlimit < Inf
            
             pivot = pivot+1

             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             % I am mainly strugling in this section becasue when
             % leavingvar=0 I don't know for which basis variable it
             % producing leavingvar = 0 from the basis list. So, how can i
             % get the correct basis variable to put them in the nonbasisu
             % when leavingvar=0???
             
             nonbasis0 = setdiff(nonbasis0,enteringvar);
             if (leavingbound==0)
                  nonbasis0 = [nonbasis0 leavingvar];
             else
                 nonbasisu = [nonbasisu leavingvar];
             end

             basis = setdiff(basis,leavingvar);
             basis = sort([basis enteringvar]);
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
            fprintf("LP Optimal") % This is not the final output, I am testing with the text output!
        else
            
             nonbasis0 = setdiff(nonbasis0,enteringvar);
             if (leavingbound==0)
                  nonbasis0 = [nonbasis0 leavingvar];
             else
                 nonbasisu = [nonbasisu leavingvar];
             end

             basis = setdiff(basis,leavingvar);
             basis = sort([basis enteringvar]);
             fprintf("LP Optimal") % This is not the final output, I am testing with the text output!
        end    
    end
       
end
elseif length(rn0)>0 && length(rnu)==0 
    while (abs(rn0)>=epsilon1) % (abs(rnu)<=epsilon1) when I am adding this getting error 
    iteration = iteration+1;
    
    [B,L,U,p,cb,cn0,cnu,ub,un0,unu,xb,y,rn0,rnu,z]=updateB(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2);
    
    % Here "LP Infeasible" if xb<0 [Not sure how to declare infeasibility
    % when updateB giving us an error?]
    
    [enteringvar,leavingvar,increasingdecreasing,d,leavingbound,tlimit]= pivotselection(basis,nonbasis0,nonbasisu,xb,ub,y,rn0,rnu,A,u,B,L,U,p,epsilon1,epsilon2,epsilon3,0)
    
    if enteringvar==leavingvar
        fprintf("Bounds flip") % Not sure how to flip the bounds?
    elseif leavingvar==0 && tlimit==+Inf 
        fprintf("LP Unbounded") % % This is not the final output, I am testing with the text output!
    else
        if enteringvar ~= leavingvar && tlimit < Inf
            
             pivot = pivot+1

             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             % I am mainly strugling in this section becasue when
             % leavingvar=0 I don't know for which basis variable it
             % producing leavingvar = 0 from the basis list. So, how can i
             % get the correct basis variable to put them in the nonbasisu
             % when leavingvar=0???
             
             nonbasis0 = setdiff(nonbasis0,enteringvar);
             if (leavingbound==0)
                  nonbasis0 = [nonbasis0 leavingvar];
             else
                 nonbasisu = [nonbasisu leavingvar];
             end

             basis = setdiff(basis,leavingvar);
             basis = sort([basis enteringvar]);
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
            fprintf("LP Optimal") % This is not the final output, I am testing with the text output!
        else
            
             nonbasis0 = setdiff(nonbasis0,enteringvar);
             if (leavingbound==0)
                  nonbasis0 = [nonbasis0 leavingvar];
             else
                 nonbasisu = [nonbasisu leavingvar];
             end

             basis = setdiff(basis,leavingvar);
             basis = sort([basis enteringvar]);
             fprintf("LP Optimal") % This is not the final output, I am testing with the text output!
        end    
    end
       
end
else length(rnu)>0 && length(rn0)==0 
    while (abs(rnu)<=epsilon1) % (abs(rnu)<=epsilon1) when I am adding this getting error 
    iteration = iteration+1;
    
    [B,L,U,p,cb,cn0,cnu,ub,un0,unu,xb,y,rn0,rnu,z]=updateB(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2);
    
    % Here "LP Infeasible" if xb<0 [Not sure how to declare infeasibility
    % when updateB giving us an error?]
    
    [enteringvar,leavingvar,increasingdecreasing,d,leavingbound,tlimit]= pivotselection(basis,nonbasis0,nonbasisu,xb,ub,y,rn0,rnu,A,u,B,L,U,p,epsilon1,epsilon2,epsilon3,pivotrule)
    
    if enteringvar==leavingvar
        fprintf("Bounds flip") % Not sure how to flip the bounds?
    elseif leavingvar==0 && tlimit==+Inf 
        fprintf("LP Unbounded") % % This is not the final output, I am testing with the text output!
    else
        if enteringvar ~= leavingvar && tlimit < Inf
            
             pivot = pivot+1

             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             % I am mainly strugling in this section becasue when
             % leavingvar=0 I don't know for which basis variable it
             % producing leavingvar = 0 from the basis list. So, how can i
             % get the correct basis variable to put them in the nonbasisu
             % when leavingvar=0???
             
             nonbasis0 = setdiff(nonbasis0,enteringvar);
             if (leavingbound==0)
                  nonbasis0 = [nonbasis0 leavingvar];
             else
                 nonbasisu = [nonbasisu leavingvar];
             end

             basis = setdiff(basis,leavingvar);
             basis = sort([basis enteringvar]);
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
            fprintf("LP Optimal") %% This is not the final output, I am testing with the text output!
        else
            
             nonbasis0 = setdiff(nonbasis0,enteringvar);
             if (leavingbound==0)
                  nonbasis0 = [nonbasis0 leavingvar];
             else
                 nonbasisu = [nonbasisu leavingvar];
             end

             basis = setdiff(basis,leavingvar);
             basis = sort([basis enteringvar]);
             fprintf("LP Optimal") % This is not the final output, I am testing with the text output!
        end    
    end
       
    end
end

