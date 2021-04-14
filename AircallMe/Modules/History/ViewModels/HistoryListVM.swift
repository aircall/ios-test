//
//  HistoryListVM.swift
//  History
//
//  Created by Rudy Frémont on 10/04/2021.
//

import Wordings
import Common

/// View model for History List view controller - give all necessary information and action method about the screen
final class HistoryListVM {
    
    private let historyServices: HistoryServices
    
    private var historyList = [HistoryCellVM]()
    
    init(historyService: HistoryServices) {
        historyServices = historyService
    }
    
    var title: String? {
        return LocalizedWords.tabbarHistoryTitle()
    }
    
    func itemsCount() -> Int {
        return historyList.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> HistoryCellVM {
        return historyList[indexPath.row]
    }
    
    /// Retrieve history item list with filter on the "isArchived" status
    /// - Parameter completion: completion result
    func getHistoryList(completion: @escaping CompletionHandler<Void>) {
        
        historyServices.loadHistoryList { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            
            case .success(let list):
                //Filter archived history item and transform to HistoryCellViewModel
                self.historyList = list.filter { $0.isArchived == false }.compactMap { HistoryCellVM.list($0) }
                completion(.success(()))
                
            case .failure(let statusCode):
                print(statusCode.localizedDescription)
                completion(.failure(statusCode))
            }
        }
    }
    
    /// Archive an history item
    /// - Parameters:
    ///   - indexPath: indexPath of the item to archive
    ///   - completion: completion result
    func archiveItem(at indexPath: IndexPath, completion: @escaping CompletionHandler<Void>) {
        
        let identifier = historyList[indexPath.row].identifier
        
        historyServices.archiveHistoryEntry(identifier: identifier) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                // Remove item from the memory array of item
                self.historyList.remove(at: indexPath.row)
                completion(result)
            case .failure(let statusCode):
                print(statusCode.localizedDescription)
                completion(result)
            }
        }
    }
    
    /// Reset all "isArchived" status
    /// - Parameter completion: completion result
    func resetArchiveStatus(completion: @escaping CompletionHandler<Void>) {
        
        historyServices.resetArchiveStatus { [weak self]  (result) in
            guard let self = self else { return }
            switch result {
            case .success:
                //refresh list
                self.getHistoryList(completion: completion)
            case .failure(let statusCode):
                print(statusCode.localizedDescription)
                completion(result)
            }
        }
    }
    
}
