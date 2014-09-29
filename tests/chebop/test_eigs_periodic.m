% Test file for periodic egeinvalue problems.

function pass = test_eigs_basic(pref)

% Get the preferences.
if ( nargin < 1 )
    pref = cheboppref;
end

tol = 1e-10;

%% Problem description.
% Solving
%   -u'' = lambda*u,
% for x in [0 2*pi],  subject to
% periodic boundary conditions.

% Define the domain we're working on.
dom = [0 2*pi];

% Assign the equation to a chebop N such that N(u) = lambda*u.
L = chebop(@(u) -diff(u, 2), dom);

% Assign boundary conditions to the chebop.
L.bc = 'periodic';

% Number of eigenvalue and eigenmodes to compute.
k = 7;

% Solve the eigenvalue problem with FOURIER.
[V, D] = eigs(L, k);
D = diag(D); 

% Exact solution.
Dexact = [0 1 1 4 4 9 9]';
err(1) = norm(D - Dexact, inf);

%% Problem description.
% Solving
%   -u'' + 2*q*cos(2*x)*u = lambda*u,
% for x in [0 2*pi],  subject to
% periodic boundary conditions.

% Define the domain we're working on.
dom = [0 2*pi];

% Assign the equation to a chebop N such that N(u) = lambda*u.
q = 2;
L = chebop(@(x, u) -diff(u, 2) + 2*q*cos(2*x).*u, dom);

% Assign boundary conditions to the chebop.
L.bc = 'periodic';

% Number of eigenvalue and eigenmodes to compute.
k = 7;

% Solve the eigenvalue problem with FOURIER.
D = eigs(L, k);

% Solutions from WolframAlpha.
Dwolfram = [ -1.513956885056520;
             -1.390676501225323;
              2.379199880488686;
              3.672232706497191;
              5.172665133358294;
              9.140627737766440;
              9.370322483621104 ];
err(2) = norm(D - Dwolfram, inf);

%%
pass = err < tol;

end
