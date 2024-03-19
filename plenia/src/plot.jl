function plot(params::Params, points::Particles)
    
    W = params.width
    Q = params.quality

    xs = LinRange(-W, W, Q)
    ys = LinRange(-W, W, Q)

    U(x) = fields(x, params=params, 
                     points=points, arg="R")

    zs = Observable([U([x,y]) for x in xs, y in ys])

    fig, ax = surface(xs,ys,zs,
        colormap = Reverse(:cyclic_tritanopic_wrwc_70_100_c20_n256),
        axis=(type=Axis3, azimuth = 0, elevation=pi/2);
        shading=NoShading)

    hidedecorations!(ax)    

    return xs, ys, zs, fig, ax
end

function updateplot(xs::Observable, ys::Observable, zs::Observable)

    U(x) = fields(x, params=params,
                     points=psystem, arg="R")

    zs[] = [(U([uu,vv])) for uu in xs, vv in ys]
    sleep(1e-6)
    return nothing
end