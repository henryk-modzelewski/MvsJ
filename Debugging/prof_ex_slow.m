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

function y = prof_ex_slow(x)
%% Find the elements of each column of x that are greater than that col's mean, 
%% and collect them into y.

    % Get size of x
    [m,n] = size(x);

    % Initialise Output
    y = [];

    % Loop over cols
    for i = 1:n

        % Find elements over the mean
        ind = find(x(:,i) > mean(x(:,i)));

        % Collect them
        b = x(ind,i);

        % Concatonate them onto y
        y = [y; b];

    end
    
end

