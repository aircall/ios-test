load "Phasesfile"

platform :ios, "13"

target :Aircall do
  script_phase(Phase.gen_injections)
  script_phase(Phase.gen_resources)

  pod 'AnnotationInject'
  pod 'Reusable'
  pod 'SwiftGen'

  target :AircallTests do
    inherit! :search_paths

    pod 'Quick'
    pod 'Nimble'
  end
end
