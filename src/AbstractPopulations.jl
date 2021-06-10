"""
Abstract population. The top node of the Population type hierarchy.
"""
abstract type AbstractPopulation end

"""
Abstract network population. Interactors are nodes of some network.
"""
abstract type AbstractNetworkPopulation <: AbstractPopulation end

"""
Abstract spatial population. Represents any type of population in which
interactors have a spatial representation (e.g. a point on a plane).
"""
abstract type AbstractSpatialPopulation <: AbstractPopulation end

"""
Abstract lattice population: interactors on some lattice.
"""
abstract type AbstractLatticePopulation <: AbstractSpatialPopulation end

