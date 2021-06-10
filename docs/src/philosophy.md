```@meta
CurrentModule = LanguageDynamics
```

# Philosophy

The design philosophy of LanguageDynamics.jl follows David Hull's general theory of selection and its application to cultural evolution in the domain of language (see references below). There are three main types of objects: **replicators**, **interactors** and **populations**. In a typical case, a replicator could be a grammatical parameter, interactors would be individual speakers, and the population would correspond to a community of first-language learners; typically, we are interested in tracking how the relative frequencies of different replicators evolve through interactions between the interactors that make up the population. This framework is intended to be maximally general, however. In a more macroscopic application, for example, we could take the interactors to be entire languages.

!!! info
    A **population** is a container of **interactors**, who are containers of **replicators**. Replicators reproduce in the population through interactions between interactors, mediated by the structure of the population.

LanguageDynamics.jl defines an entire [hierarchy of types](@ref type-hierarchies). Replicators are composite types derived from the abstract `AbstractReplicator` type or one of its abstract descendants. Similarly, interactors derive ultimately from `AbstractInteractor` and populations from `AbstractPopulation`. All non-abstract replicator, interactor and population types must implement certain functions to guarantee unified behaviour, as discussed next.


## The nature of populations


## The nature of interactors


## The nature of replicators


## Rendezvous and actions


## References

(Hull, Croft, maybe Michaud?)


