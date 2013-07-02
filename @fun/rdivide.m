function f = rdivide(f, g, varargin)
%./   Right array divide for a FUN.
%   F ./ C divides the FUN F by a double C. If F is am array-valued FUN with M
%   columns, then C must be either a scalar or a 1xM array.
%
%   Alternatively if C is a FUN with the same number of columns as F or F is a
%   scalar, then the resulting division is returned if C is found to have no
%   roots in its domain. The division is performed column-wise. Note that F and
%   C are assumed to have the same domain. The method gives no warning if their
%   domains don't agree, but the output of the method will be gibberish.
%
% See also MRDIVIDE, TIMES.

% Copyright 2013 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

% FUN ./ [] = []:
if ( isempty(f) || isempty(g) )
    f = [];
    return
end

% Look at different cases:

if ( isa(g, 'double') )         % FUN ./ DOUBLE
    
    % Divide the ONEFUN:
    f.onefun = rdivide(f.onefun, g, varargin{:});
    
elseif isa(f, 'double')         % DOUBLE ./ FUN
    
    % If g has roots in [a, b] we're going to get an error. However, don't worry
    % about catching errors here; rather, just allow the error generated by the
    % ONEFUN method to be thrown.
    g.onefun = rdivide(f, g.onefun, varargin{:});
    
    % Assign g to be the output argument
    f = g;
    
else                            % FUN ./ FUN
    
    % Both f and g are FUN objects. Similar to above, enclose in a try-catch
    % statement in case g has roots on [a, b].
    try
        % Call RDIVIDE of the ONEFUN:
        f.onefun = rdivide(f.onefun, g.onefun, varargin{:});
    catch ME
        if ( strcmp(ME.identifier, 'CHEBFUN:CHEBTECH:rdivide:DivideByZeros') )
            % The right argument has roots on [a ,b].
            error('CHEBFUN:FUN:rdivide:DivideByZeros', ...
                'Cannot divide by a FUN with roots in [%.5g, %.5g].', ...
               g.domain(1), g.domain(2));
        else
            % Unexpected error, rethrow it.
            rethrow(ME)
        end
    end
    
end

end