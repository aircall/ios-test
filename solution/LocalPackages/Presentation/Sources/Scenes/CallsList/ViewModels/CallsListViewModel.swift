//
//  CallsListViewModel.swift
//  
//
//  Created by Jobert on 24/06/2021.
//

import Combine
import Domain
import Foundation

public class CallsListViewModel: ObservableObject {

    private let listCallsUseCase: ListCallsUseCase
    private let archivingCallUseCase: ArchivingCallUseCase
    private var disposeBag: Set<AnyCancellable> = []

    public var router: CallsListViewRouter?

    public let title: String
    @Published public private(set) var calls: Loadable<[CallsListItemViewModel]>

    public init(listCallsUseCase: ListCallsUseCase,
                archivingCallUseCase: ArchivingCallUseCase) {
        self.listCallsUseCase = listCallsUseCase
        self.archivingCallUseCase = archivingCallUseCase
        title = L10n.history
        calls = .notRequested
        NotificationCenter.default.publisher(for: .callUpdated).sink { [weak self] _ in
            self?.update()
        }.store(in: &disposeBag)
    }

    public func update() {
        calls = .isLoading
        listCallsUseCase.execute { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(calls): self.calls = .loaded(calls.map(CallsListItemViewModel.init))
            case let .failure(error): self.calls = .failed(error: error)
            }
        }?.store(in: &disposeBag)
    }

    public func didSelect(_ viewModel: CallsListItemViewModel) {
        router?.perform(.showDetail(ofCall: viewModel.call))
    }
}

final class MockCallsRepository: CallsRepository {
    func list(with completion: @escaping (Result<[Call], Error>) -> Void) -> Cancellable? {
        completion(.success(MockedDomain.calls))
        return nil
    }

    func archiveCall(with callId: UInt, archive: Bool, completion: @escaping (Result<Call, Error>) -> Void) -> Cancellable? {
        nil
    }
}

extension CallsListViewModel {
    static var mock: CallsListViewModel {
        let listCallsUseCase = DefaultListCallsUseCase(callsRepository: MockCallsRepository())
        let archivingCallUseCase = DefaultArchivingCallUseCase(callsRepository: MockCallsRepository())
        let viewModel = CallsListViewModel(listCallsUseCase: listCallsUseCase,
                                           archivingCallUseCase: archivingCallUseCase)
        return viewModel
    }
}
