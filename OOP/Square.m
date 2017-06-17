classdef Square < Figures

properties
    a = 0
end

methods

    function f=Square(a)

        f = f@Figures(datetime);
        f.a = a;

    end

    function a=area(fig)
        a = fig.a^2;
    end

end

end

