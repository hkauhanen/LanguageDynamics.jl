module LanguageDynamics

# Imports
import Distributions

# Auxiliaries
include("common.jl")

# Abstract types
include("AbstractPopulations.jl")
include("AbstractInteractors.jl")
include("AbstractReplicators.jl")

# Replicators
include("Replicators/BinaryVariable.jl")

# Interactors
include("Interactors/Interactors.jl")
include("Interactors/EmptyInteractor.jl")
include("Interactors/MomentumSelector.jl")

# Populations
include("Populations/Populations.jl")
include("Populations/PoolPopulation.jl")
include("Populations/ZipfTravellerPopulation.jl")

# Exports: auxiliaries
export Point
export zipf
export manhattan
export chebyshev

# Exports: abstracts
export AbstractInteractor
export AbstractPopulation

# Exports: populations
export PoolPopulation
export ZipfTravellerPopulation
export inject!
export eject!
export rendezvous!
export travel!
export characterize
export characterize_by_location

# Exports: interactors
export EmptyInteractor
export MomentumSelector

# Exports: replicators
export BinaryVariable

end
