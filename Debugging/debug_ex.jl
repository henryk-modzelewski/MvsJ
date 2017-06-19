export debug_ex_stable

"""
Use debug_ex(x::AbstractArray)
This simple function sums each element in 'x'\n

Julia Debugging Example - debug_ex
West Grid Research Computing Summer School - UBC - June 2017

================================================================================
 Author:   Keegan Lensink
            Seismic Laboratory for Imaging and Modeling
            UBC, Vancouver
            June, 2017
================================================================================
"""
function debug_ex_stable{T<:Number}(x::AbstractArray{T})

    # If x is multidimensional, vectorize it by reference
    vx = vec(x) 

    # Get the length of x for iteration
    n = length(vx)

    # Initialize output
    b = zero(T)

    # Loop over values in x
    for i = 1:n
        
        b += vx[i]

    end # for

    return b
    
end # debug_ex

function debug_ex_stable{T<:String}(x::AbstractArray{T})

    # If x is multidimensional, vectorize it by reference
    (ndims(x) > 1) && (x = vec(x))

    # Join the string array's elements into one string    
    b = join(x, " + ")
    
    all(map(isnumber,x)) && (b = eval(parse(b)))
    
    return b
    
end # debug_ex


