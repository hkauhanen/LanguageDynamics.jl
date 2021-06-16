"""
A pool population is a well-mixing finite community, i.e. one in
which every interactor is connected to every other interactor and
the probability of interaction is uniform.
"""
mutable struct PoolPopulation{T<:AbstractInteractor} <: AbstractPopulation
  census::Array{T}
  nactions::Int64
end


"""
    PoolPopulation{T}()

Construct an empty pool population of interactors of type `T`.

## Examples

    PoolPopulation{EmptyInteractor}()
"""
function PoolPopulation{T}() where {T<:AbstractInteractor}
  PoolPopulation(Array{T}(undef, 0), 0)
end


