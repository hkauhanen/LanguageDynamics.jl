"""
    inject!(x::AbstractInteractor, y::AbstractPopulation)

Add an interactor to a population.
"""
function inject!(x::AbstractInteractor, y::AbstractPopulation)
  push!(y.census, x)
end


"""
    eject!(x::Int, y::AbstractPopulation)

Remove interactor with ID `x` from population `y`.
"""
function eject!(x::Int, y::AbstractPopulation)
  splice!(y.census, x)
end


"""
    eject!(x::AbstractPopulation)

Remove a randomly chosen interactor from a population.
"""
function eject!(x::AbstractPopulation)
  splice!(x.census, rand(1:length(x.census)))
end


"""
    rendezvous!(x::AbstractPopulation, y::Int, z::Int)

Conduct a rendezvous between interactors indexed by `y` and `z` in population `x`.
(The first mentioned acts first.)
"""
function rendezvous!(x::AbstractPopulation, y::Int, z::Int)
  act!(x.census[y], x.census[z])
  act!(x.census[z], x.census[y])
  x.nactions += 2
end


"""
    rendezvous!(x::AbstractPopulation)

Conduct a rendezvous between two interactors chosen at random in population `x`.
"""
function rendezvous!(x::AbstractPopulation)
  length(x.census) > 1 || return false
  int1 = 0
  int2 = 0
  while true
    int1 = rand(1:length(x.census))
    int2 = rand(1:length(x.census))
    int1 != int2 && break
  end
  rendezvous!(x, int1, int2)
end


"""
    characterize(x::AbstractPopulation)

Characterize the state of a population. Tries to form either a single number
or a vector that reflects the population's average behaviour, depending on
the types of replicators carried by the interactions in the population. In
practice, this is achieved by calling on `characterize` functions on the
interactors.
"""
function characterize(x::AbstractPopulation)
  length(x.census) > 0 || return false
  result = characterize(x.census[1])
  for person in x.census[2:end]
    result += characterize(person)
  end
  result/length(x.census)
end


"""
    characterize_by_location(x::AbstractLatticePopulation)

Characterize a lattice population cell by cell.
"""
function characterize_by_location(x::AbstractLatticePopulation)
  out = zeros(x.size, x.size)
  speakers_by_cell = zeros(x.size, x.size)

  for s in 1:length(x.census)
    speaker = x.census[s]
    sx = x.locations[s].x
    sy = x.locations[s].y
    out[sx, sy] += characterize(speaker)
    speakers_by_cell[sx, sy] += 1
  end

  out ./ speakers_by_cell
end
