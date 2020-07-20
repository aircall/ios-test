load "Phasesfile"

platform :ios, "13"

target :Aircall do
  script_phase(Phase.gen_resources)

  pod 'Cache'
  pod 'ReachabilitySwift'
  pod 'Reusable'
  pod 'SwiftGen'

  target :AircallTests do
    inherit! :search_paths

    pod 'CombineExpectations', :git => 'https://github.com/groue/CombineExpectations', :tag => 'v0.5.0'
  end
end
