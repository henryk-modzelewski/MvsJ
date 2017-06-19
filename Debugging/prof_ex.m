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

function y = prof_ex(x)
%% Find the elements of each column of x that are greater than its mean, 
%% and collect them into y.

    % Get size of x
    [m,n] = size(x);

    % Initialise Output, by pre allocating memory. Create counter
    y = zeros(n*m,1);
    count = 0;

    % Move mean outside of loop, it doesnt change
    x_bar = mean(x);

    % Loop over columns
    for i = 1:n

        % Use logical indexing instead of 'find'
        ind = x(:,i) > x_bar(i);

        % Skip collected them, unecessary memory allocations

        % Append to previously filled elements of pre-allocated memory
        n_elements = sum(ind);
        y(count+1:count+n_elements) = x(ind,i);

        % Update counter
        count = count + n_elements;

    end
   
    % Clean up unused memory
    y(count+1:end) = [];

end


