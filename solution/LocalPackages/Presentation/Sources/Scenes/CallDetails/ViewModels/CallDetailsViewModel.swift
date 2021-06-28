//
//  CallDetailsViewModel.swift
//  
//
//  Created by Jobert on 25/06/2021.
//

import Foundation
import Combine
import Common
import Domain

public class CallDetailsViewModel: ObservableObject {

    private let archivingUseCase: ArchivingCallUseCase
    private var disposeBag: Set<AnyCancellable> = []

    public let title: String
    public let callId: UInt
    @Published public private(set) var details: Loadable<(archived: Bool, sections: [CallDetailsSectionViewModel])>

    public init(archivingCallUseCase: ArchivingCallUseCase, call: Call) {
        archivingUseCase = archivingCallUseCase
        title = DateFormatter.monthDayTime.string(from: call.createdAt)
        callId = call.id
        details = .notRequested
        details = .loaded((archived: call.isArchived, sections: createSections(with: call)))
    }

    public func archiveCall(_ archive: Bool) {
        details = .isLoading
        archivingUseCase.archiveCall(with: callId, archive: archive) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(call):
                    self.details = .loaded((archived: call.isArchived, sections: self.createSections(with: call)))
                case let .failure(error):
                    self.details = .failed(error: error)
                }
            }
        }?.store(in: &disposeBag)
    }

    private func createSections(with call: Call) -> [CallDetailsSectionViewModel] {
        return [.init(title: L10n.contactInformationTitle,
                      items: [ContactInfoViewModel(call)]),
                .init(title: L10n.callInformationTitle,
                      details: "(5sec)",
                      items: [CallInfoStatsViewModel(call),
                              CallInfoProviderViewModel(call)],
                      footerType: .actions)
        ]
    }
}

extension CallDetailsViewModel {
    static var mock: CallDetailsViewModel {
        let archivingCallUseCase = DefaultArchivingCallUseCase(callsRepository: MockCallsRepository())
        let viewModel = CallDetailsViewModel(archivingCallUseCase: archivingCallUseCase,
                                             call: MockedDomain.calls[0])
        return viewModel
    }
}
