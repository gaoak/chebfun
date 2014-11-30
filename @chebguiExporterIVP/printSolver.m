function printSolver(fid, expInfo)
%PRINTSOLVER     Print commands for solving problems
%
% Calling sequence:
%   PRINTPOSTSOLVER(FID, EXPINFO)
% where
%   FID:        ID of a file-writing stream.
%   EXPINFO:    Struct containing information for printing the problem.

% Copyright 2014 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

% Print commands for solving the problem:
fprintf(fid,'\n%%%% Solve the problem!');
fprintf(fid, ['\n%% Here, we call the solveIVP() method ' ...
    '(which offers the same functionality \n%% as nonlinear '...
    'backslash but allows options to be passed).\n']);
fprintf(fid, 'u = solveIVP(N, rhs, options);\n');

end