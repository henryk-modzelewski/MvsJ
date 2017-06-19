%Use debug_ex(x)
%This simple function sums each element in 'x'
%
%Julia Debugging Example - debug_ex
%West Grid Research Computing Summer School - UBC - June 2017
%
%================================================================================
% Author:   Keegan Lensink
%            Seismic Laboratory for Imaging and Modeling
%            UBC, Vancouver
%            June, 2017
%================================================================================

function b = debug_ex(x)

    % Get the number of elements in x
    n = numel(x);

    % Initialize output
    b = 0;

    % Loop over elements
    for i = 1:n
        b = b + x(i);
    end    

end

