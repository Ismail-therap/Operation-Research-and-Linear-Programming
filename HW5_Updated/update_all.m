
function [basis,nonbasis0,nonbasisu]= update_all(basis,nonbasis0,nonbasisu,leavingbound,leavingvar,enteringvar,epsilon2,xb,rn0,z)

if min(xb)<epsilon2
    fprintf("LP infeasible");
elseif min(xb)>epsilon2 && min(rn0)>epsilon2 && z~=0
    fprintf("LP infeasible");
else
    
   %[B,L,U,p,cb,cn0,cnu,ub,un0,unu,xb,y,rn0,rnu,z]=updateB(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2)
   %[enteringvar,leavingvar,increasingdecreasing,d,leavingbound,tlimit]= pivotselection(basis,nonbasis0,nonbasisu,xb,ub,y,rn0,rnu,A,u,B,L,U,p,epsilon1,epsilon2,epsilon3,pivotrule)
   %I am confused here I have to use basisupdateu function or this
   %pivotselection function
   if leavingvar == 0 
        if ismember(enteringvar, nonbasis0) == 1
            basis = basis;
            nonbasisu = sort([nonbasisu enteringvar]);
            nonbasis0 = setdiff(nonbasis0, enteringvar);
        else
            basis = basis;
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
       
   elseif enteringvar==leavingvar
       if ismember(entering,nonbasis0) == 1
           nonbasisu = sort([nonbasisu entering]);
           nonbasis0 = setdiff(nonbasis0,nonbasisu);
       else
           nonbasis0 = sort([nonbasis0 entering]);
           nonbasisu = setdiff(nonbasis0,nonbasisu);
       end
   end 
   basis = basis;
   nonbasis0 = nonbasis0;
   nonbasisu = nonbasisu;
end



end