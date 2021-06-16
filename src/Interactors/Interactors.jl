"""
    characterize(x::AbstractInteractor)

Characterize the state of a single interactor. Calls the `characterize`
method on the replicator carried by the interactor.
"""
function characterize(x::AbstractInteractor)
  characterize(x.replicator)
end
