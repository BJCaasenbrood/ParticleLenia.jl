function fields(x::Vector; params::Params, points::Particles, arg::String = "E")

    r = max.(sqrt.( sum((points.pos .- transpose(x) ).^2, dims=2) ), 1e-10 )
    U = sum( kernel.(r, w=params.αk, μ=params.μk, σ=params.σk) )
    G = kernel(U, w=1.0, μ=params.μg, σ=params.σg ) 

    R = (params.cr/2.) * sum( smoothmax.(1.0 .- r, 0.0) )

    if arg == "U"
        return U
    elseif arg == "G"
        return G     
    elseif arg == "R"
        return R
    else
        return R-G
    end
end

function smoothmax(a::Float64, b::Float64; ε::Float64=5e-2)
    return 0.5 * (a + b + sqrt((a-b)^2 + ε))
end

function kernel(x; w::Float64 = 1., μ::Float64 = 0., σ::Float64 = 1.)
    σ > 0 || error("the variance σ  must be positive")
    return w * exp( -( (x - μ)/σ)^2 )
end 