function T=advectionPFV(T,u,v,dx,dy,dt,iter)
    [ny,nx]=size(T);
    tend=zeros(size(T));
    for i=1:iter
        parfor x=2:nx-1
            tend(:,x)=docol(T(:,x-1:x+1),u,v,dx,dy)
        end
        T=T+tend*dt;
    end
end

function tend=docol(T,u,v,dx,dy)
    [ny,~]=size(T);
    tend=zeros(ny,1);
    for y=2:ny-1
        tend(y,1)=         -u*((T(y,2+1)-T(y,2-1))/(2.*dx));
        tend(y,1)=tend(y,1)-v*((T(y+1,2)-T(y-1,2))/(2.*dy));
    end
end
