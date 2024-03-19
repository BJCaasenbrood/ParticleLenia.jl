#####################################
using GLMakie
import Pkg as Pkg
Pkg.activate("plenia")
import plenia
#####################################
params  = plenia.Params()
psystem = plenia.PLenia(params.nparticles, 
                        width=params.width)
#####################################
GLMakie.activate!(inline=false)

xs = LinRange(-12., 12., 200)
ys = LinRange(-12., 12., 200)
U(x) = plenia.fields(x, params=params, 
                        points=psystem, arg="R")
zs = Observable([U([x,y]) for x in xs, y in ys])

fig, ax = surface(xs,ys,zs,
    colormap = Reverse(:cyclic_tritanopic_wrwc_70_100_c20_n256),
    axis=(type=Axis3, azimuth = 0, elevation=pi/2);
    shading=NoShading)

hidedecorations!(ax)    

#####################################
dE = zeros(Float64, psystem.nParticles, 2)

record(fig, "./vids/plenia.mp4", 1:params.nframes) do frame

    # nsteps of forward newton
    for nn in 1:params.nsteps    
        # update gradient function
        ∇E(x) = plenia.gradient(x, params=params,
                                   points=psystem)

        # compute exact gradient of P-Lenia fields
        for ii in 1:psystem.nParticles
            @inbounds dE[ii,:] = ∇E(psystem.pos[ii,:])
        end

        # update particles
        psystem.pos .-= dE * params.Δt
    end

    U(x) = plenia.fields(x, params=params,
                            points=psystem, arg="R")
    zs[] = [(U([uu,vv])) for uu in xs, vv in ys]
    display(fig)
    sleep(1e-6)
end