function T=advectionPF(T,u,v,dx,dy,dt,iter)
    [ny,nx]=size(T);
    tend=zeros(size(T));
    for i=1:iter
        parfor x=2:nx-1
            for y=2:ny-1
                tend(y,x)=         -u*((T(y,x+1)-T(y,x-1))/(2.*dx));
                tend(y,x)=tend(y,x)-v*((T(y+1,x)-T(y-1,x))/(2.*dy));
            end
        end
        T=T+tend*dt;
    end
end
