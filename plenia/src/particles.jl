@kwdef mutable struct Particles
    nParticles :: Int64
    pos :: Matrix{Float64}
end

function PLenia(np::Int64; width::Float64=12.)

    # generate random point cloud
    points = (rand(np,2) .- 0.5) .* width
    
    # check if point matrix lives in ℜ2
    nParticles = size(points,1)
    size(points,2) == 2 || error("Particle matrix p must be of size nx2")

    # return struct of particles
    return Particles(nParticles, points)
end