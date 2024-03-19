# Particle Lenia for Julia

`plenia.jl` is a Particle Lenia implementation for Julia based on the work [Particle Lenia and the energy-based formulation](https://google-research.github.io/self-organising-systems/particle-lenia/) by [Alexander Mordvintsev](https://znah.net/) et al. (2022). The patterns and cell-like behavior shown in the video below are produced by an artificial "life" system that is called "Particle Lenia" -- based on the name [Lenia Mathematical Lifeforms](https://chakazul.github.io/lenia.html), which in itself is based on John Conway's [Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life). 

Particle Lenia's are systems of Ordinary Differential Equations (ODE) described by a collection of point particles {$\boldsymbol{p_i}$}$_{i=1}^{n_p}$ and the interaction with each other. Each particle is describe an unique position $\boldsymbol{p_i} = [x_i, y_i]^\top$ together with an continuous energy field $E_i(\boldsymbol{x}) = R_i(\boldsymbol{x}) - G_i(\boldsymbol{x})$, being the repulsive and growth energy field, respectively. We refer to [Mordvintsev et al.](https://google-research.github.io/self-organising-systems/particle-lenia/) for the expressions of these fields. The dynamics for this system of particles arise from the gradient of the total energy $E = \sum E_i$, simply put, it reads as follows:
$$\dot{\boldsymbol{p_i}} = -\nabla E(\boldsymbol{p_i}) $$

Despite its mathematical simplicity, the dynamics of such systems lead to interesting (stable) limit cycles, that are reminiscent to the behavior of microscopic organisms in water or single-cell organisms.

https://github.com/BJCaasenbrood/ParticleLenia.jl/assets/36262141/e435c3b3-290e-42c8-889d-8ddeeffdf426

### Running code
To run a Particle Lenia simulation, simply call:
```bash
julia main.jl
```
