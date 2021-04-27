import UIKit

/*******************************************************************************
 * CellConfigurating
 *
 * A type that configure cell for an UITableView
 *
 ******************************************************************************/

protocol CellConfigurating {

  //----------------------------------------------------------------------------
  // MARK: - Delegate
  //----------------------------------------------------------------------------

  func select()

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  /// Register a cell to given table view.
  ///
  /// - Parameter tableView: The table view to register a cell.
  func register(on tableView: UITableView)

  //----------------------------------------------------------------------------
  // MARK: - Data source
  //----------------------------------------------------------------------------

  /// Dequeue a cell from a table view, configure and return it.
  ///
  /// - Parameters:
  ///   - tableView: The table view to dequeue a cell.
  ///   - indexPath: The index path of the cell to dequeue.
  /// - Returns: A configured cell.
  func configuratedCellFor(tableView: UITableView,
                           atIndexPath indexPath: IndexPath) -> UITableViewCell

}
