function gradient(x::Vector; params::Params, points::Particles)

    r = max.(sqrt.( sum((points.pos .- transpose(x) ).^2, dims=2) ), 1e-10 )

    ∇r = grad_r(x, r, points.pos)
    U  = sum( kernel.(r, w=params.αk, μ=params.μk, σ=params.σk) )
    ∇U = grad_kernel.(r, w=params.αk, μ=params.μk, σ=params.σk)
    ∇G = grad_kernel(U, w=1.0, μ=params.μg, σ=params.σg)

    ∇C = -(params.cr/2.) * grad_smoothmax.(1.0 .- r, 0.0)

    return sum( ∇C.*∇r - ∇G.*∇U.*∇r, dims = 1)
end

function grad_r(x::Vector, r::Matrix, p::Matrix)
    drdx = -(p[:,1] .- x[1]) ./ r
    drdy = -(p[:,2] .- x[2]) ./ r
    return [drdx drdy]
end 

function grad_kernel(x; w::Float64 = 1., μ::Float64 = 0., σ::Float64 = 1.)
    σ > 0 || error("the variance σ  must be positive")
    α = w * exp( -( (x - μ)/σ)^2 )
    β = (1/(σ^2)) * (2μ - 2x)
    return α * β
end 

function grad_smoothmax(a::Float64, b::Float64; ε::Float64=5e-2)
    return (2*a - 2*b)/(4*(ε + (a - b)^2)^(.5)) + .5
end