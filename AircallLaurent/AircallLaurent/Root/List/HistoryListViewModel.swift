//
//  HistoryListViewModel.swift
//  AircallLaurent
//
//  Created by Laurent on 28/04/2021.
//

import UIKit
import CoreData

final class HistoryListViewModel: NSObject {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Data ********************/

  let fetchedResultsController: NSFetchedResultsController<Call> 

  let repository = HistoryListRepository()

  /******************** Callbacks ********************/

  var didFail: ((Error) -> Void)?

  var dataDidChange: (() -> Void)?

  var willFetchedResultsControllerChangeContent: (() -> Void)?

  var didFetchedResultsControllerChangeContent: (() -> Void)?

  var didFetchedResultsControllerChangeSectionInfo:
    ((NSFetchedResultsChangeType, Int) -> Void)?

  var didFetchedResultsControllerChangeSectionObject:
    ((NSFetchedResultsChangeType, IndexPath?, IndexPath?) -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override init() {
    let request: NSFetchRequest<Call> = Call.fetchRequest()
    let createdAtSortDescriptor = NSSortDescriptor(key: "createdAt",
                                                   ascending: true)
    request.sortDescriptors = [createdAtSortDescriptor]
    request.predicate = NSPredicate(format: "isArchived == 0")

    let viewContext = Database.shared.persistentContainer.viewContext
    self.fetchedResultsController =
      NSFetchedResultsController<Call>(fetchRequest: request,
                                       managedObjectContext: viewContext,
                                       sectionNameKeyPath: nil,
                                       cacheName: nil)
    super.init()

    fetchedResultsController.delegate = self
    try? fetchedResultsController.performFetch()
    dataDidChange?()
  }

  //----------------------------------------------------------------------------
  // MARK: - Network
  //----------------------------------------------------------------------------

  func fetchCalls() {
    repository.fetchCalls { [weak self] result in
      switch result {
        case .success(let calls):
          try? self?.fetchedResultsController.performFetch()
          self?.dataDidChange?()
        case .failure(let error): self?.didFail?(error)
      }
    }
  }

  func resetArchiveState() {
    repository.reset { [weak self] result in
      switch result {
        case .success():
          try? self?.fetchedResultsController.performFetch()
          self?.dataDidChange?()
        case .failure(let error): self?.didFail?(error)
      }
    }
  }

  func archive(call: CallModel) {
    var archivedCall = call
    archivedCall.isArchived = true
    repository.update(call: archivedCall) { [weak self] result in
      switch result {
        case .success():
          try? self?.fetchedResultsController.performFetch()
          self?.dataDidChange?()
        case .failure(let error): self?.didFail?(error)
      }
    }
  }

}

//==============================================================================
// MARK: - NSFetchedResultsControllerDelegate
//==============================================================================

extension HistoryListViewModel: NSFetchedResultsControllerDelegate {

  func controllerWillChangeContent(
      _ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    willFetchedResultsControllerChangeContent?()
    }

    func controller(
      _ controller: NSFetchedResultsController<NSFetchRequestResult>,
      didChange sectionInfo: NSFetchedResultsSectionInfo,
      atSectionIndex sectionIndex: Int,
      for type: NSFetchedResultsChangeType) {
      didFetchedResultsControllerChangeSectionInfo?(type, sectionIndex)
    }

    func controller(
      _ controller: NSFetchedResultsController<NSFetchRequestResult>,
      didChange anObject: Any,
      at indexPath: IndexPath?,
      for type: NSFetchedResultsChangeType,
      newIndexPath: IndexPath?) {
      didFetchedResultsControllerChangeSectionObject?(type,
                                                      indexPath,
                                                      newIndexPath)
    }

    func controllerDidChangeContent(
      _ controller: NSFetchedResultsController<NSFetchRequestResult>) {
      didFetchedResultsControllerChangeContent?()
    }

}
