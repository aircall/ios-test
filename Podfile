load "Phasesfile"

platform :ios, "13"

target :Aircall do
  script_phase(Phase.gen_resources)

  pod 'Reusable'
  pod 'SwiftGen'

  target :AircallTests do
    inherit! :search_paths
  end
end
