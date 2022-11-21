%
% x=newtonnneg(fname,Jname,x0,maxiter,tol)
%
% Uses Newton's method to solve F(x)=0, keeping x>=0 throughout the process.
%
function x=newtonnneg(fname,Jname,x0,maxiter,tol)
%
% Use x0 as our starting point.
%
x=x0;
%
% Check x0 for nonnegativity.
%
if (min(x) < 0)
  error('x0 is not >= 0');
end
%
% Evaluate F and J at the starting point.
%
F=feval(fname,x);
J=feval(Jname,x);
iter=0;
%
% Main loop.  Perform Newton iterations until either maxiter or 
% norm(F)<=tol.
%
while ((iter < maxiter) & (norm(F)>tol)),
    deltax=(J)\(-F);
%
% Figure out how far we can move in this direction and keep x>=0.
%
    alpha=1/0.95;
    for i=1:length(x)
      if ((deltax(i)<0) && (-x(i)/deltax(i) < alpha))
        alpha=-x(i)/deltax(i);
      end
    end
%
% Take the step.  Note that we only go 0.95 of the way to the boundary.
%
    0.95*alpha;
    x=x+0.95*alpha*deltax;
%
% Setup for the next iteration by updating F and J.
%
    F=feval(fname,x);
    J=feval(Jname,x);
    iter=iter+1;
end;
