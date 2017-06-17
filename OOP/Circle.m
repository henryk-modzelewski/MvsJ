classdef Circle < Figures

properties
    r = 0
end

methods

    function f=Circle(r)

        f = f@Figures(datetime);
        f.r = r;

    end

    function a=area(fig)
        a = pi*fig.r^2;
    end

end

end

