classdef Figures

properties
    dt
end

methods

    function f = Figures(str)
        f.dt = str;
    end

    function x = lt(figa,figb)
        x = (area(figa)<area(figb));
    end

    function x = plus(figa,figb)
        x = area(figa)+area(figb);
    end

end

methods (Abstract)

    x = area(a);

end

end

