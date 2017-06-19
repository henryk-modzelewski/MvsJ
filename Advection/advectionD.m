function T=advectionD(T,u,v,dx,dy,dt,iter)
    DT=distributed(T);

    DTH=decompose(DT);

    DTH=iterate(DTH,u,v,dx,dy,dt,iter);

    DT=recompose(DTH);

    T=gather(DT);
end

function A=iterate(A,u,v,dx,dy,dt,iter)
    spmd
        cA=getCodistributor(A);
        T=getLocalPart(A);
        [ny nx]=size(T);
        tend=zeros(size(T));
        for i=1:iter
            % shift right
            if labindex<numlabs; labTo = labindex + 1; else labTo = []; end;
            if labindex>1; labFrom = labindex - 1; else labFrom = []; end;
            halo = labSendReceive(labTo, labFrom, T(:,end-1));
            if labindex > 1; T(:,1)=halo; end;
    
            % shift left
            if labindex>1; labTo = labindex - 1; else labTo = []; end;
            if labindex<numlabs; labFrom = labindex + 1; else labFrom = []; end;
            halo = labSendReceive(labTo, labFrom, T(:,2));
            if labindex < numlabs; T(:,end)=halo; end;

            % integrate
            for x=2:nx-1
                for y=2:ny-1
                    tend(y,x)=         -u*((T(y,x+1)-T(y,x-1))/(2.*dx));
                    tend(y,x)=tend(y,x)-v*((T(y+1,x)-T(y-1,x))/(2.*dy));
                end
            end
            T=T+tend*dt;
        end
        A=codistributed.build(T,cA);
    end
end

function B=decompose(A)
    spmd
        nr=size(A,1);
        cA=getCodistributor(A);
        a=getLocalPart(A);
        ddim=cA.Dimension;
        part=cA.Partition;
        part(1)=part(1)+1;
        part(2:end-1)=part(2:end-1)+2;
        part(end)=part(end)+1;
        gsize=cA.Cached.GlobalSize;
        gsize(2)=gsize(2)+(numlabs*2-2);
        b=zeros(nr,part(labindex));
        if labindex==1
            b(:,1:end-1)=a;
        elseif labindex==numlabs
            b(:,2:end)=a;
        else
            b(:,2:end-1)=a;
        end
        cB=codistributor1d(ddim,part,gsize);
        B=codistributed.build(b,cB);
    end
end

function B=recompose(A)
    spmd
        nr=size(A,1);
        cA=getCodistributor(A);
        a=getLocalPart(A);
        ddim=cA.Dimension;
        part=cA.Partition;
        part(1)=part(1)-1;
        part(2:end-1)=part(2:end-1)-2;
        part(end)=part(end)-1;
        gsize=cA.Cached.GlobalSize;
        gsize(2)=gsize(2)-(numlabs*2-2);
        b=zeros(nr,part(labindex));
        if labindex==1
            b=a(:,1:end-1);
        elseif labindex==numlabs
            b=a(:,2:end);
        else
            b=a(:,2:end-1);
        end
        cB=codistributor1d(ddim,part,gsize);
        B=codistributed.build(b,cB);
    end
end
