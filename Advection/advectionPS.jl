function advectionPS{ET<:AbstractFloat}(T::SharedArray{ET,2},u::ET,v::ET,dx::ET,dy::ET,dt::ET,iter::Int)::Matrix{ET}
    (ny,nx)=size(T);
    tend=SharedArray(ET,size(T));
    for i=1:iter
        @parallel for x=2:nx-1
            for y=2:ny-1
                tend[y,x]= -u*((T[y,x+1]-T[y,x-1])/(2.*dx));
                tend[y,x]+=-v*((T[y+1,x]-T[y-1,x])/(2.*dy));
            end
        end
        for x=1:nx
            for y=1:ny
                T[y,x]=T[y,x]+tend[y,x]*dt;
            end
        end
    end
    return T
end
