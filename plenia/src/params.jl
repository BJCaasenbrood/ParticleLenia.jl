@kwdef mutable struct Params
    
    nparticles :: Int64 = 200

    αk :: Float64 = 0.022
    σk :: Float64 = 1.0
    μk :: Float64 = 4.0

    σg :: Float64  = 0.15
    μg :: Float64  = 0.6 
    cr :: Float64  = 1.0

    Δt :: Float64  = 0.2

    quality :: Int64 = 100
    nsteps  :: Int64 = 10
    nframes :: Int64 = 240
    width   :: Float64 = 12.

end