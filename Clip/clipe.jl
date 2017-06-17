function clip{ET<:AbstractFloat}(v::Vector{ET},t::Real,f::Function)
    l=length(v)
    for i=1:l
        v[i]= f(v[i],t) ? zero(ET) : v[i]
    end
    return v
end

function clip{ET<:Complex}(v::Vector{ET},t::Real,f::Function)
    l=length(v)
    for i=1:l
        v[i]= f(abs(v[i]),t) ? zero(ET) : v[i]
    end
    return v
end

function clip{ET<:AbstractFloat}(v::Vector{ET},t::Real)
    l=length(v)
    for i=1:l
        v[i]= v[i]<t ? zero(ET) : v[i]
    end
    return v
end

function clip{ET<:Complex}(v::Vector{ET},t::Real)
    l=length(v)
    for i=1:l
        v[i]= abs(v[i])<t ? zero(ET) : v[i]
    end
    return v
end

