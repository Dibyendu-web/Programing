using ForwardDiff

module NumpyJulia

export meshgrid

function meshgrid(xrange, yrange)
    x = [i for i in xrange, j in yrange]
    y = [j for i in xrange, j in yrange]
    return x, y
end
    
function gradient(f::Function, vars...)
    

    
end
end