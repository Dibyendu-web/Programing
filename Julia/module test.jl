module geometry


struct Point
    x::Float64
    y::Float64
end

struct circle
    center::Point
    radius::Float64
end

function area(c::circle)
    return π * c.radius^2
    
end
  
export Point, circle, area

end
