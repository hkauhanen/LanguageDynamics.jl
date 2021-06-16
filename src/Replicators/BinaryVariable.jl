"""
A binary variable of type `T`.
"""
mutable struct BinaryVariable{T<:Number} <: AbstractReplicator
  x::T
end


"""
    characterize(x::BinaryVariable)

Characterize a binary variable.
"""
function characterize(x::BinaryVariable)
  x.x
end
