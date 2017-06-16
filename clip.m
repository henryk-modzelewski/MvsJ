function v=clip(v,t)
    if ~isnumeric(v); error('v not numeric'); end
    if numel(v)<2 || size(v,2)>1; error('v not vector'); end
    l=length(v);
    if isreal(v)
        for i=1:l
            if v(i)<t; v(i)=0; end
        end
    else
        for i=1:l
            if abs(v(i))<t; v(i)=0; end
        end
    end
end
