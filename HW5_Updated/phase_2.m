function [xstar,optobj,optbasis,nonbasis0,nonbasisu,totaliters,raystar,ystar,wstar,zstar] = phase_2(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2)


epsilon1=1.0e-5;
epsilon2=1.0e-5;
epsilon3=1.0e-5;
[m,n]=size(A);
pivot = 0;
w = 0;

% Starting Phase II
fprintf('Starting Phase II\n');
Iteration = 0



[B,L,U,p,cb,cn0,cnu,ub,un0,unu,xb,y,rn0,rnu,z]=updateB(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2);


if min(xb) < epsilon2
    fprintf('LP is negative entry in xb=%e\n',min(xb));
    xstar = NaN*ones(n,1);
    optobj= NaN;
    optbasis= [];
    nonbasis0=[];
    nonbasisu=[];
    totaliters=Iteration;     
    raystar=NaN*ones(n,1);
    ystar=NaN*ones(1,m);
    wstar=NaN*ones(1,n);
    zstar=NaN*ones(1,n);
    fprintf('Phase I finished in %d iterations\n', Iteration);
    return;
end
   
Iteration2 = 0;
while min(rn0) <-epsilon2 | max(rnu) > -epsilon2
        
        Iteration2 = Iteration2+1;
        [enteringvar,leavingvar,increasingdecreasing,d,leavingbound,tlimit]= pivotselection(basis,nonbasis0,nonbasisu,xb,ub,y,rn0,rnu,A,u,B,L,U,p,epsilon1,epsilon2,epsilon3,0);
        
        if leavingvar==0 && tlimit==+Inf
            fprintf('LP is unbounded at phase II');
                x=zeros(n,1);
                x(basis)=xb;
                x(nonbasisu)=u(nonbasisu);
                optobj= +Inf
                basis=sort(basis);
                optbasis= basis;
                nonbasis0=sort(nonbasis0);
                nonbasis0=nonbasis0;
                nonabasisu=sort(nonbasisu);
                nonbasisu=nonbasisu;
                totaliters=Iteration+Iteration2; 
                t=enteringvar;
                ray=zeros(n,1);
                ray1=rref(A);
                ray(t)=1;
                ray(basis)=-ray1(:,t);
                y=NaN*ones(1,m);
                w=NaN*ones(1,n);
                z=NaN*ones(1,n);
        elseif enteringvar ~= leavingvar && tlimit < Inf
            pivot = pivot+1
                [basis,nonbasis0,nonbasisu]= update_all(basis,nonbasis0,nonbasisu,leavingbound,leavingvar,enteringvar,epsilon2,xb,rn0,z);
                [B,L,U,p,cb,cn0,cnu,ub,un0,unu,xb,y,rn0,rnu,z]=updateB(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2);
                    
                fprintf('LP is optimal. solution is z=%d\n',z); 
                x= zeros(n,1);%optimal solution.
                x(basis)=xb;
                xu=u(nonbasisu);
                x(nonbasisu)=xu;
                for i=1:n
                    if ismember(i,basis)==1
                        wstar(i)=0;
                        zstar(i)=0;
                    elseif ismember(i,nonbasis0)==1
                        wstar(i)=0;
                        [position]=find(nonbasis0==i);
                        zstar(i)=rn0(position);
                    else 
                        zstar(i)=0;
                        [position]=find(nonbasisu==i);
                        wstar(i)=rnu(position);
                    end
                 end
                 if isempty(nonbasisu)==0
                     optobj=full(y'*b+rnu*unu);
                 else
                     optobj=full(y'*b);
                 end
                 basis=sort(basis);
                 optbasis=basis; 
                 nonbasis0=sort(nonbasis0);
                 nonbasis0=nonbasis0;
                 nonbasisu=sort(nonbasisu);
                 nonbasisu=nonbasisu;
                 totaliters=Iteration+Iteration2; 
                 ray=zeros(n,1);
                 y=y; 
                 w=w;
                 z=c'*x+const; 
        else
            [basis,nonbasis0,nonbasisu]= update_all(basis,nonbasis0,nonbasisu,leavingbound,leavingvar,enteringvar,epsilon2,xb,rn0,z);
                [B,L,U,p,cb,cn0,cnu,ub,un0,unu,xb,y,rn0,rnu,z]=updateB(A,b,c,u,const,basis,nonbasis0,nonbasisu,epsilon2);
                    
                fprintf('LP is optimal. solution is z=%d\n',z); 
                x= zeros(n,1);%optimal solution.
                x(basis)=xb;
                xu=u(nonbasisu);
                x(nonbasisu)=xu;
                for i=1:n
                    if ismember(i,basis)==1
                        wstar(i)=0;
                        zstar(i)=0;
                    elseif ismember(i,nonbasis0)==1
                        wstar(i)=0;
                        [position]=find(nonbasis0==i);
                        zstar(i)=rn0(position);
                    else 
                        zstar(i)=0;
                        [position]=find(nonbasisu==i);
                        wstar(i)=rnu(position);
                    end
                 end
                 if isempty(nonbasisu)==0
                     optobj=full(y'*b+rnu*unu);
                 else
                     optobj=full(y'*b);
                 end
                 basis=sort(basis);
                 optbasis=basis; 
                 nonbasis0=sort(nonbasis0);
                 nonbasis0=nonbasis0;
                 nonbasisu=sort(nonbasisu);
                 nonbasisu=nonbasisu;
                 totaliters=Iteration+Iteration2; 
                 ray=zeros(n,1);
                 y=y; %optimal dual solution
                 w=w; %optimal dual solution
                 z=c'*x+const; %optimal dual solution 
        
        end   
        
        if totaliters >= 200*max(m,n/10)
        break
        end
   
end

xstar = x
optobj = optobj
optbasis = optbasis
nonbasis0 = nonbasis0
nonbasisu = nonbasisu
totaliters = totaliters
raystar = ray
ystar = y
wstar = w
zstar = z

end