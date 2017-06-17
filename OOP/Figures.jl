module Figures

export Figure
abstract Figure

export Circle
type circle{DT<:Real} <: Figure
    r::DT
end
Circle{DT}(r::DT)=circle{DT}(r)

export Rectangle
type rectangle{DT<:Real} <: Figure
    a::DT
    b::DT
end
Rectangle{DT}(a::DT,b::DT)=rectangle{DT}(a,b)

export area
area{DT}(c::circle{DT}) = pi*c.r^2
area{DT}(r::rectangle{DT}) = r.a*r.b

import Base.<, Base.+
<(a::Figure,b::Figure) = (area(a)<area(b))
+(a::Figure,b::Figure) = area(a)+area(b)

end
