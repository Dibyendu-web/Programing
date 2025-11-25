using BenchmarkTools

function f1(x::Matrix{Float64}, y::Matrix{Float64})
    s = size(x)
    a = zeros(Float64, s)
    for i in 1:s[1]
        for j in 1:s[2]
            a[i, j] = x[i, j] + y[i, j]
        end
    end
    return a
end
function f2(x::Matrix{Float64}, y::Matrix{Float64})
    s = size(x)
    a = zeros(Float64, s)
    for i in 1:s[1]
        for j in 1:s[2]
            @inbounds a[i, j] = x[i, j] + y[i, j]
        end
    end
    return a
end

x = rand(10000, 10000);
y = rand(10000, 10000);
@benchmark f1(x, y)
@benchmark f2(x, y)

x = [1 2 3; 4 5 6; 7 8 9]
y = similar(x)