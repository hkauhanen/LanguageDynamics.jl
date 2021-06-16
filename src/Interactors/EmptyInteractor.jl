"""
An empty interactor. This is an empty type that has no functionality apart
from 'existing'. Its use case is testing and debugging population-dynamic
functions; linguistically, empty interactors are inert. They can be rendezvoused,
technically, but nothing happens.
"""
mutable struct EmptyInteractor <: AbstractInteractor
  meta::Any
end


"""
Construct an empty interactor.
"""
function EmptyInteractor()
  EmptyInteractor(nothing)
end


"""
    act!(x::EmptyInteractor, y::AbstractInteractor)

Make an `EmptyInteractor` attempt an action on another interactor. Does nothing
and returns `false`.
"""
function act!(x::EmptyInteractor, y::AbstractInteractor)
  return false
end


"""
    act!(x::AbstractInteractor, y::EmptyInteractor)

Make an interactor attempt an action on an `EmptyInteractor`. Does nothing
and returns `false`.
"""
function act!(x::AbstractInteractor, y::EmptyInteractor)
  return false
end


"""
    act!(x::EmptyInteractor, y::EmptyInteractor)

Make an `EmptyInteractor` attempt an action on another `EmptyInteractor`. Does nothing
and returns `false`.
"""
function act!(x::EmptyInteractor, y::EmptyInteractor)
  return false
end
