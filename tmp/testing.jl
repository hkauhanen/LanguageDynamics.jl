function dicttest()
  com = LanguageDynamics.ZipfTravellerPopulation{LanguageDynamics.MomentumSelector}(7, 2.5)

  for i = 1:200
    LanguageDynamics.inject!(LanguageDynamics.MomentumSelector(0.01, 0.02, 1.0, 4, 0.1), com)
  end

  #for i = 1:100
  #  eject!(com)
  #end

  while com.nactions < 0.5*200*100#_000
    LanguageDynamics.travel!(com)
    LanguageDynamics.rendezvous!(com)
  end
end

function arrtest()
  com = PoolPopulation{EmptyInteractor}()

  for i = 1:500
    inject!(EmptyInteractor(), com)
  end

  #for i = 1:100
  #  eject!(com)
  #end

  for i = 1:1000
    rendezvous!(com)
  end
end
