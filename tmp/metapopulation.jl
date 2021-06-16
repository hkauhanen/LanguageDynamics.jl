function metapop()
  # make metapopulation
  mp = ZTMetaPopulation{LanguageDynamics.MomentumSelector}(7, 2.5)

  # add speakers
  for i = 1:200
    inject!(LanguageDynamics.MomentumSelector(0.01, 0.02, 1.0, 4, 0.1), mp)
  end

  # Travel + rendezvous
  while mp.nactions < 0.5*200*100#_000
    travel!(mp)
    rendezvous!(mp)
  end
end
