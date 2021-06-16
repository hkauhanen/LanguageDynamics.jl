mutable struct ZTMetaPopulation{T<:LanguageDynamics.AbstractInteractor}
  # Census (of local populations)
  census::Array{LanguageDynamics.PoolPopulation{T}}

  # Lattice size (side length)
  size::Int

  # Distance decay exponent
  de::Float64

  # Probability mass function for movement
  probabilities::Array{Float64}

  # Distance function
  distance::Function

  # Range of possible distances; will be different for different cells since
  # we assume fixed lattice boundaries
  possible_distances::Dict{Int, Array{Int}}

  # How many actions have occurred
  nactions::Int

  # Cells at a given distance from given cell
  lookup::Dict{Tuple{Int, Int}, Array{Int}}
end


function ZTMetaPopulation{T}(K::Int, lambda::Float64) where {T<:LanguageDynamics.AbstractInteractor}
  # Possible distances on lattice
  possdist = collect(0:2*(K-1))

  # Possible distances for each cell; initialized here as empty
  possdistcell = Dict{Int, Array{Int}}()

  # Metapopulation; array of local populations which are pools
  mp = Array{LanguageDynamics.PoolPopulation{T}}(undef, 0)

  # Construct lookup table and add local populations. This is
  # intensive, but will only happen once (when the metapopulation
  # is constructed).
  lup = Dict{Tuple{Int, Int}, Array{Int}}()
  cellID1 = 0
  for x in 1:K
    for y in 1:K
      cellID1 += 1
      point1 = LanguageDynamics.Point{Int}(x,y)

      push!(mp, LanguageDynamics.PoolPopulation{T}())

      for dist in possdist
        cellID2 = 0
        for i in 1:K
          for j in 1:K
            cellID2 += 1
            point2 = LanguageDynamics.Point{Int}(i,j)

            if LanguageDynamics.manhattan(point1, point2) == dist
              # if this cell does not yet have an entry, initialize
              if !haskey(possdistcell, cellID1)
                possdistcell[cellID1] = Array{Int}(undef, 0)
              end

              # push this distance to the array
              push!(possdistcell[cellID1], dist)

              # if this pair does not yet exist in lookup, initialize
              if !haskey(lup, (cellID1, dist))
                lup[(cellID1, dist)] = Array{Tuple{Int, Int}}(undef, 0)
              end

              # push cell 2 to the lookup for this pair
              push!(lup[(cellID1, dist)], cellID2)
            end
          end
        end
      end

      # we only need cell IDs once in the array
      possdistcell[cellID1] = unique(possdistcell[cellID1])
    end
  end

  # Construct
  ZTMetaPopulation(mp, K, lambda, LanguageDynamics.zipf(2*(K-1) + 1, lambda), LanguageDynamics.manhattan, possdistcell, 0, lup)
end


function inject!(x::LanguageDynamics.AbstractInteractor, y::ZTMetaPopulation)
  # random local population
  rp = rand(1:length(y.census))

  # assign this to speaker's home, using speaker's meta variable
  x.meta = rp

  # inject into local population
  LanguageDynamics.inject!(x, y.census[rp])
end


function rendezvous!(x::ZTMetaPopulation)
  rend = LanguageDynamics.rendezvous!(rand(x.census))
  if rend != false
    x.nactions += 2
  end
end


function travel!(x::ZTMetaPopulation)
  # select random local population
  rp = rand(x.census)

  # select random speaker; fail if local population empty
  while length(rp.census) == 0
    rp = rand(x.census)
  end
  #length(rp.census) > 0 || return false
  rs_coor = rand(1:length(rp.census)) # NB: coordinate in *local* population
  rs = rp.census[rs_coor]

  # travel
  home = rs.meta
  possdist = x.possible_distances[home]
  dist = Distributions.wsample(possdist, LanguageDynamics.zipf(maximum(possdist) + 1, x.de))
  destination = rand(x.lookup[(home, dist)])
  LanguageDynamics.eject!(rs_coor, rp)
  LanguageDynamics.inject!(rs, x.census[destination])
end
