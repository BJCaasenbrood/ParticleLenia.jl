#####################################
using LinearAlgebra
import Pkg as Pkg
Pkg.activate("plenia")
import plenia
#####################################
params = plenia.Params()
#####################################
δ  = 0.01
np = 10
#####################################
p = plenia.PLenia((rand(np,2) .- 0.5) .* 3)

E(x) = plenia.fields(x, params=params, points = p)
ΔE(x) = plenia.gradient(x, params=params, points = p)

ii = 1
df0x1 = E(p.pos[ii,:] + [+δ, 0.]/2)
df0x2 = E(p.pos[ii,:] + [-δ, 0.]/2)
df0y1 = E(p.pos[ii,:] + [0., +δ]/2)
df0y2 = E(p.pos[ii,:] + [0., -δ]/2)

dE1 = (1.0/δ) .* [df0x1-df0x2 df0y1-df0y2]
dr = ΔE(p.pos[ii,:])

display(dE1)
display(dr)