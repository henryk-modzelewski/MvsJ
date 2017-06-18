function advection{ET<:AbstractFloat}(T::Matrix{ET},u::ET,v::ET,dx::ET,dy::ET,dt::ET,iter::Int)::Matrix{ET}
    (ny,nx)=size(T);
    tend=zeros(size(T)...);
    for i=1:iter
        for x=2:nx-1
            for y=2:ny-1
                tend[y,x]= -u*((T[y,x+1]-T[y,x-1])/(2.*dx));
                tend[y,x]+=-v*((T[y+1,x]-T[y-1,x])/(2.*dy));
            end
        end
        T=T+tend*dt;
    end
    return T
end
