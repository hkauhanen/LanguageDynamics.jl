"""
An empty speaker. This is an empty type that has no functionality apart
from 'existing'. Its use case is testing and debugging population-dynamic
functions; linguistically, empty speakers are inert. They can be rendezvoused,
technically, but nothing happens.
"""
mutable struct EmptySpeaker <: AbstractSpeaker end


"""
    act!(x::EmptySpeaker, y::AbstractSpeaker)

Make an `EmptySpeaker` attempt an action on another speaker. Does nothing
and returns `false`.
"""
function act!(x::EmptySpeaker, y::AbstractSpeaker)
  return false
end
