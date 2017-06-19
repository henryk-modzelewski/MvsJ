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
clear

% Start Single Program Multiple Data
% Every line in this SPMD block is being evaluated on each worker
spmd

    % Create an array of 1,000,000 random numbers and distribute it over available workers
    C = rand(100000,100000,'codistributed');

    % Run our function on each worker
    b = debug_ex(getLocalPart(C));

end %spmd

% Initialize the sum
B = 0;

% Transfer the results locally and sum
for i = 1:length(b)
    B = B + b{i};
end
