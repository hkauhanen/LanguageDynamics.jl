```@meta
CurrentModule = LanguageDynamics
```

# Philosophy

Broadly speaking, the design philosophy of LanguageDynamics.jl follows David Hull's general theory of selection and its application to cultural evolution in the domain of language. There are three main types of objects: **replicators**, **interactors** and **populations**. In a typical case, a replicator could be the setting of a grammatical parameter, interactors would be individual speakers, and the population corresponds to the speech community; typically, we would be interested in tracking how the relative frequencies of different replicators evolve through interactions between the interactors that make up the population.This framework is intended to be maximally general, however. In a more macroscopic application, for example, we could take the interactors to be entire languages.

!!! info
    A **population** is a container of **interactors**, who are containers of **replicators**. Replicators reproduce in the population through interactions between interactors.

LanguageDynamics.jl defines an entire hierarchy of abstract types. Replicators are composite types derived from the abstract `AbstractReplicator` type or one of its abstract descendants. Similarly, interactors derive ultimately from `AbstractInteractor` and populations from `AbstractPopulation`. Concrete examples will be given below.


## The nature of populations


## The nature of interactors


## Rendezvous and actions



