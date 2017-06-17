export debug_ex

"""
Use debug_ex(x::AbstractArray)
This simple function sums each element in 'x'\n

Julia Debugging Example - debug_ex\n
West Grid Research Computing Summer School - UBC - June 2017

================================================================================\n
 Author:   Keegan Lensink\n
            Seismic Laboratory for Imaging and Modeling\n
            UBC, Vancouver\n
            June, 2017\n
================================================================================\n
"""
function debug_ex{T<:Number}(x::AbstractArray{T})

    # If x is multidimensional, vectorize it by reference
    (ndims(x) > 1) && (x = vec(x))

    # Get the length of x for iteration
    n = length(x)

    # Initialize output
    b = 0

    # Loop over values in x
    for i = 1:n
        
        b += x[i]

    end # for

    return b
    
end # debug_ex

