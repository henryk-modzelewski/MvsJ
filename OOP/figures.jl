module figures

export Figure
abstract Figure

export Circle
type Circle <: Figure
    r
end

export Rectangle
type Rectangle <: Figure
    a
    b
end

export area
area(c::Circle) = pi*c.r^2
area(r::Rectangle) = r.a*r.b

import Base.<, Base.+
<(a::Figure,b::Figure) = (area(a)<area(b))
+(a::Figure,b::Figure) = area(a)+area(b)

end
