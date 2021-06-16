"""
Momentum-based utterance selector, after Stadler et al. (2016).

# Reference

Stadler, K., Blythe, R. A., Smith, K. & Kirby, S. (2016) Momentum in language
change: a model of self-actuating s-shaped curves. *Language Dynamics and Change*,
6, 171–198. <https://doi.org/10.1163/22105832-00602005>
"""
mutable struct MomentumSelector <: AbstractUtteranceSelector
  replicator::BinaryVariable{Float64}
  gamma_replicator::BinaryVariable{Float64}
  alpha::Float64
  gamma::Float64
  b::Float64
  T::Int
  mmax::Float64
  meta::Any
end


"""
    MomentumSelector(alpha::Float64, gamma::Float64, b::Float64, T::Int, x0::Float64)

Construct a `MomentumSelector` with learning rate `alpha`, short-term memory
smoothing factor `gamma`, momentum bias `b`, number of utterances per interaction `T`,
and initial frequency `x0`.
"""
function MomentumSelector(alpha::Float64, gamma::Float64, b::Float64, T::Int, x0::Float64)
  tmmax = log(alpha/gamma)/(alpha - gamma)
  mmax = exp(-alpha*tmmax) - exp(-gamma*tmmax)
  MomentumSelector(BinaryVariable{Float64}(x0), BinaryVariable{Float64}(x0), alpha, gamma, b, T, mmax, nothing)
end


"""
    act!(x::MomentumSelector, y::MomentumSelector)

Let one `MomentumSelector` act upon another, i.e. `x` speaks and `y` listens.
"""
function act!(x::MomentumSelector, y::MomentumSelector)
  normalized_momentum = (y.gamma_replicator.x - y.replicator.x)/y.mmax
  observed_frequency = rand(Distributions.Binomial(x.T, x.replicator.x))/x.T

  transformed_frequency = 0.0

  if observed_frequency == 1.0
    transformed_frequency = 1.0
  elseif observed_frequency != 0.0
    transformed_frequency = observed_frequency + y.b*normalized_momentum
  end

  if transformed_frequency > 1.0
    transformed_frequency = 1.0
  elseif transformed_frequency < 0.0
    transformed_frequency = 0.0
  end

  y.replicator.x = y.alpha*transformed_frequency + (1-y.alpha)*y.replicator.x
  y.gamma_replicator.x = y.gamma*transformed_frequency + (1-y.gamma)*y.gamma_replicator.x
end


