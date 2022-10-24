cd \\acad-filebox\u_drive\900358056\AD-Profile\Desktop\Ismail\OR\HW5\hw5files\hw5files


A=[-2 1 0; -1 2 1];
b=[1; -1];


%%%%% Deciding Two-phase or Typical LP

[m,n] = size(A)

AA = A(:,n)

decider = AA.*b

if any(decider<0)
    disp("Two Phase")
else
    disp("Typical Simplex")
end

%%%%%%%%% Seting auxiliary variables, Updating A, c %%%%

T = zeros(size(decider));  % Placeholder for auxiliary variable
for ii = 1:length(decider)
    if decider(ii)<0
       T(ii) = -1;
    else
       T(ii) = 1;
    end
end

% diag(T) % Diagonal matrix for auxiliary variables
A = [A,diag(T)]

c=[-1; -1; -1];

c =  [c' zeros(1,m)]' % Updating c with auxiliary varialbles



