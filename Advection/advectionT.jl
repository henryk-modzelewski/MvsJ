function advectionT{ET<:AbstractFloat}(T::Matrix{ET},u::ET,v::ET,dx::ET,dy::ET,dt::ET,iter::Int)::Matrix{ET}
    (ny,nx)=size(T);
    tend=zeros(size(T)...);
    for i=1:iter
        Threads.@threads for x=2:nx-1
            tend[:,x]= docolT(T[:,x-1:x+1],u,v,dx,dy)
        end
        T=T+tend*dt;
    end
    return T
end

function docolT{ET<:AbstractFloat}(T::Matrix{ET},u::ET,v::ET,dx::ET,dy::ET)
    ny=size(T,1);
    tend=zeros(ny,1);
    for y=2:ny-1
        tend[y,1]=         -u*((T[y,2+1]-T[y,2-1])/(2.*dx));
        tend[y,1]=tend[y,1]-v*((T[y+1,2]-T[y-1,2])/(2.*dy));
    end
    return tend
end
