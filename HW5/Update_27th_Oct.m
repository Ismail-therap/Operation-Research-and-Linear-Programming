%%%%% Playing with test2.m %%%%%%%

% Test the simplex solver.  This LP has an optimal solution with z=-4.
%
A=[2 -1 1 0; 1 2 0 1];
b=[2; 6];
c=[-1; -1; 0; 0];
u=+Inf*ones(4,1);

%%%%%%%% Phase 1 %%%%%%%%%%%


[m,n] = size(A) % getting row and column
c =  [zeros(1,n-m) ones(1,m)]'   % Updating c for phase 1

% Initiate the basis, nonbasis0 and nonbasisu 
all_x = 1:n;
basis = all_x(end-m+1:end)
nonbasis0 = setdiff(all_x,basis)
nonbasisu = []

% Declare some important inputs
const = 0;
pivotrule=0;
epsilon1=1.0e-5;
epsilon2=1.0e-5;
epsilon3=1.0e-5;



[B,L,U,p,cb,cn0,cnu,ub,un0,unu,xb,y,rn0,rnu,z]=updateB(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2);

iteration = 0
pivot = 0

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
        fprintf("LP Unbounded") % I can set the output in this section easily.
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
        
            fprintf("LP Optimal")
        else
            
             nonbasis0 = setdiff(nonbasis0,enteringvar);
             if (leavingbound==0)
                  nonbasis0 = [nonbasis0 leavingvar];
             else
                 nonbasisu = [nonbasisu leavingvar];
             end

             basis = setdiff(basis,leavingvar);
             basis = sort([basis enteringvar]);
             fprintf("LP Optimal")
        end    
    end
       
end
elseif length(rn0)>0 && length(rnu)==0 
    while (abs(rn0)>=epsilon1) % (abs(rnu)<=epsilon1) when I am adding this getting error 
    iteration = iteration+1;
    
    [B,L,U,p,cb,cn0,cnu,ub,un0,unu,xb,y,rn0,rnu,z]=updateB(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2);
    
    % Here "LP Infeasible" if xb<0 [Not sure how to declare infeasibility
    % when updateB giving us an error?]
    
    [enteringvar,leavingvar,increasingdecreasing,d,leavingbound,tlimit]= pivotselection(basis,nonbasis0,nonbasisu,xb,ub,y,rn0,rnu,A,u,B,L,U,p,epsilon1,epsilon2,epsilon3,pivotrule)
    
    if enteringvar==leavingvar
        fprintf("Bounds flip") % Not sure how to flip the bounds?
    elseif leavingvar==0 && tlimit==+Inf 
        fprintf("LP Unbounded") % I can set the output in this section easily.
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
        
            fprintf("LP Optimal")
        else
            
             nonbasis0 = setdiff(nonbasis0,enteringvar);
             if (leavingbound==0)
                  nonbasis0 = [nonbasis0 leavingvar];
             else
                 nonbasisu = [nonbasisu leavingvar];
             end

             basis = setdiff(basis,leavingvar);
             basis = sort([basis enteringvar]);
             fprintf("LP Optimal")
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
        fprintf("LP Unbounded") % I can set the output in this section easily.
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
        
            fprintf("LP Optimal")
        else
            
             nonbasis0 = setdiff(nonbasis0,enteringvar);
             if (leavingbound==0)
                  nonbasis0 = [nonbasis0 leavingvar];
             else
                 nonbasisu = [nonbasisu leavingvar];
             end

             basis = setdiff(basis,leavingvar);
             basis = sort([basis enteringvar]);
             fprintf("LP Optimal")
        end    
    end
       
    end
end


% This code producing error:

%Array indices must be positive integers or logical values.

%Error in pivotselection (line 60)
%    enteringvar=nonbasisu(maxrnuindex);