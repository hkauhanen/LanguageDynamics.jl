"""
Abstract interactor. The top node of the Interactor type hierarchy.
"""
abstract type AbstractInteractor end

"""
Abstract speaker: an interactor that is an individual.
"""
abstract type AbstractSpeaker <: AbstractInteractor end

"""
Abstract language: an interactor that is a language (community).
"""
abstract type AbstractLanguage <: AbstractInteractor end

"""
Abstract probabilistic speaker: a speaker containing a probabilistic replicator.
"""
abstract type AbstractProbabilisticSpeaker <: AbstractSpeaker end

"""
Abstract utterance selector: an interactor of the Utterance Selection Model type.
"""
abstract type AbstractUtteranceSelector <: AbstractProbabilisticSpeaker end

