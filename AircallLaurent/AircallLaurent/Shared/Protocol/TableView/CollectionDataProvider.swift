import UIKit

/*******************************************************************************
 * CollectionDataProvider
 *
 * A type that can provide data to a collection (collection/table view)
 *
 ******************************************************************************/

protocol CollectionDataProvider {

  associatedtype CellHolder

  /******************** Data ********************/

  var items: [[CellConfigurating]] { get set }

  /******************** Callbacks ********************/

  var dataDidChange: (() -> Void)? { get set }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  func registerOn(_ cellHolder: CellHolder)

  //----------------------------------------------------------------------------
  // MARK: - Get
  //----------------------------------------------------------------------------

  func numberOfSections() -> Int
  func numberOfItems(in section: Int) -> Int

  func item(at indexPath: IndexPath) -> CellConfigurating?

  //----------------------------------------------------------------------------
  // MARK: - Update
  //----------------------------------------------------------------------------

  mutating func updateItem(at indexPath: IndexPath,
                           with value: CellConfigurating)
}

extension CollectionDataProvider {

  //----------------------------------------------------------------------------
  // MARK: - Array safety check
  //----------------------------------------------------------------------------

  private func isValidIndex(_ index: Int, in array: [Any]) -> Bool {
    return (array.indices ~= index) ? true : false
  }

  private func isValidIndexPath(_ indexPath: IndexPath,
                                in array: [[Any]]) -> Bool {
    let section = indexPath.section
    let row = indexPath.row
    return
      isValidIndex(section, in: array) && isValidIndex(row, in: array[section])
  }

  //----------------------------------------------------------------------------
  // MARK: - CollectionDataProvider
  //----------------------------------------------------------------------------

  func numberOfSections() -> Int {
    return items.count
  }

  func numberOfItems(in section: Int) -> Int {
    return isValidIndex(section, in: items) ? items[section].count : 0
  }

  func item(at indexPath: IndexPath) -> CellConfigurating? {
    guard isValidIndexPath(indexPath, in: items) else { return nil }
    return items[indexPath.section][indexPath.row]
  }

  mutating func updateItem(at indexPath: IndexPath,
                           with value: CellConfigurating) {
    guard isValidIndexPath(indexPath, in: items) else { return }
    items[indexPath.section][indexPath.row] = value
    dataDidChange?()
  }

}
