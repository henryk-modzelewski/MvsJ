function loop(b,n)
    s=0
    for i=1:n
        if mod(n,2)==1
            s-=b*n
        else
            s+=b*n
        end
    end
    return s
end

function Loop{BDT}(b::BDT,n::Int)
    s::BDT=0
    for i=1:n
        if mod(n,2)==1
            s-=b*n
        else
            s+=b*n
        end
    end
    return s
end
