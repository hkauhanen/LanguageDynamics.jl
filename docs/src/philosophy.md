```@meta
CurrentModule = LanguageDynamics
```

# Philosophy

The design philosophy of LanguageDynamics.jl follows David Hull's general theory of selection and its application to cultural evolution in the domain of language (see references below). There are three main types of objects: **replicators**, **interactors** and **populations**. In a typical case, a replicator could be a grammatical parameter, interactors would be individual speakers, and the population would correspond to a community of first-language learners; typically, we are interested in tracking how the relative frequencies of different replicators evolve through interactions between the interactors that make up the population. This framework is intended to be maximally general, however. In a more macroscopic application, for example, we could take the interactors to be entire languages.

!!! info
    A **population** is a container of **interactors**, which are containers of **replicators**. Replicators reproduce in the population through interactions between interactors, mediated by the structure of the population.

LanguageDynamics.jl defines an entire [hierarchy of types](@ref type-hierarchies). Replicators are composite types derived from the abstract `AbstractReplicator` type or one of its abstract descendants. Similarly, interactors derive ultimately from `AbstractInteractor` and populations from `AbstractPopulation`. All non-abstract replicator, interactor and population types must implement certain functions to guarantee unified behaviour, as discussed next.


## The nature of populations

Every population type is required to descend from `AbstractPopulation` and to minimally implement the following:

* A field named `census`, which is an `Array` of objects descending from [`AbstractInteractor`](@ref).

Three functions are defined for `AbstractPopulation` and hence available to all populations:

* A function `inject!(x,y)`, which inserts interactor object `x` into population `y`.
* A function `eject!(x,y)`, which removes interactor with census index `x` from population `y`.
* A function `rendezvous!(x)`, which triggers an interaction between randomly chosen interactors in population `x`.

Populations can redefine these through their own methods, and add further methods not implemented in the abstract. For example, network populations (descendants of [`AbstractNetworkPopulation`](@ref)) must have methods for connecting and disconnecting interactors). The specific requirements for implementing particular abstract types are detailed in the documentation for each abstract type.

!!! warning
    Given this implementation, the indices of interactors in the `census` variable will change if interactors are removed from the population. The array implementation was chosen for performance reasons -- an alternative implementation using a `Dict` and unique keys, for example, would be orders of magnitude slower. If time-persistent unique interactor identifiers are needed, this should be accomplished through external book-keeping.


## The nature of interactors

Every interactor type is required to descend from `AbstractInteractor` and to minimally implement the following:

* A field named `replicator`, of a type `T` that descends from `AbstractReplicator`.
* A method or methods `act!(x,y)`, which specifies/specify how interactor `x` acts on interactor `y`.

An exception is the `EmptyInteractor` type which does not implement a replicator.

Many interactor types require that `x` and `y` above be of the same type `T`. However, sometimes `x`, `y` or both can refer to all descendants of an abstract type with which it makes sense for an interactor of type `T` to interact.


## The nature of replicators

FIXME


## Rendezvous and actions

In LanguageDynamics.jl, interactions between interactors typically arise through calls to a `rendezvous!` function implemented in the population whose members those interactors are. This function then calls upon `act!` functions implemented in the interactors, which in turn may modify the replicators contained in the interactors.

For instance, suppose we have a population `x` whose implementation of `rendezvous!(x)` is to pick two interactors from the census at random and to make both act upon each other if, and only if, some condition C is satisfied. Calling `rendezvous!(x)` would then first check for C and, if satisfied, proceed to call both `act!(a,b)` and `act!(b,a)`, where `a` and `b` are the two randomly drawn interactors. The effect of the action functions would depend on the types of the interactors. Suppose, for example, that both speakers are utterance selectors; then `a` acting on `b` has the effect of `a` producing a number of utterances and `b` updating its replicator based on that action.

!!! info
    Actions are in general asymmetric: `act!(a,b)` cannot be assumed to have the same effect as `act!(b,a)`.

!!! warning
    Rendezvous functions are used to prompt interactors to act upon each other. Whether any tangible action *in fact* occurs may depend on the satisfaction of some set of conditions, as explained above.


## References

(Hull, Croft, maybe Michaud?)


