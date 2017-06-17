function s = loop(b,n)
    s=0;
    for i=1:n
        if mod(n,2)
            s=s+b*n;
        else
            s=s-b*n;
        end
    end
end
