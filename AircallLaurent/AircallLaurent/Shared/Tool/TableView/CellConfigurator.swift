import UIKit

/*******************************************************************************
 * CellConfigurator
 *
 * A class that configure a tableViewCell
 *
 ******************************************************************************/

class CellConfigurator<Cell, DataType>: CellConfigurating
  where Cell.DataType == DataType,
Cell: UITableViewCell & Configurable & Reusable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var data: DataType

  /******************** Callback ********************/

  var didSelect: ((DataType) -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(data: DataType) {
    self.data = data
  }

  func register(on tableView: UITableView) {
    let cellIdentifier = Cell.reuseIdentifier
    let cellClass = Cell.self
    let bundle = Bundle(for: cellClass)
    if bundle.path(forResource: cellIdentifier, ofType: "nib") != nil {
      let nib = UINib(nibName: cellIdentifier, bundle: bundle)
      tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    } else {
      tableView.register(cellClass, forCellReuseIdentifier: cellIdentifier)
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Data source
  //----------------------------------------------------------------------------

  func configuratedCellFor(
    tableView: UITableView,
    atIndexPath indexPath: IndexPath
  ) -> UITableViewCell {
    let identifier = Cell.reuseIdentifier

    guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                   for: indexPath) as? Cell
      else {
        assertionFailure("Could not dequeue custom cell.")
        return UITableViewCell()
    }

    cell.configure(with: data)

    return cell
  }

  //----------------------------------------------------------------------------
  // MARK: - Delegate
  //----------------------------------------------------------------------------

  func select() {
    didSelect?(data)
  }

}
