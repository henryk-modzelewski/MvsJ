classdef Rectangle < Figures

properties
    a = 0
    b = 0
end

methods

    function f=Rectangle(a,b)

        f = f@Figures(datetime);
        f.a = a;
        f.b = b;

    end

    function a=area(fig)
        a = fig.a*fig.b;
    end

end

end

