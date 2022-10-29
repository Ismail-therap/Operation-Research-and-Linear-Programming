% Phase1
function [basis,nonbasis0,nonbasisu,xb,ub,y, rn0,rnu,B,L,U,p]= phase_one(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2)

epsilon1=1.0e-5;
epsilon2=1.0e-5;
epsilon3=1.0e-5;
const = 0;
pivotrule = 0;

[B,L,U,p,cb,cn0,cnu,ub,un0,unu,xb,y,rn0,rnu,z]=updateB(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2)

if min(xb)<epsilon2
    fprintf("LP infeasible")
elseif min(xb)>epsilon2 && min(rn0)>epsilon2 && z~=0
    fprintf("LP infeasible")
else
   [enteringvar,leavingvar,increasingdecreasing,d,leavingbound,tlimit]= pivotselection(basis,nonbasis0,nonbasisu,xb,ub,y,rn0,rnu,A,u,B,L,U,p,epsilon1,epsilon2,epsilon3,pivotrule)
   
   if leavingvar == 0 
        if ismember(enteringvar, nonbasis0) == 1
            basis = basis
            nonbasisu = sort([nonbasisu enteringvar]);
            nonbasis0 = setdiff(nonbasis0, enteringvar);
        else
            basis = basis
            nonbasis0 = sort([nonbasis0 enteringvar]);
            nonbasisu = setdiff(nonbasisu, enteringvar);
        end
   elseif leavingvar ~=0
       nonbasis0 = setdiff(nonbasis0,enteringvar);
       if (leavingbound==0)
           nonbasis0 = [nonbasis0 leavingvar];
       else
           nonbasisu = [nonbasisu leavingvar];
       end
       basis = setdiff(basis,leavingvar);
       basis = sort([basis enteringvar]); 
   end  
end

end