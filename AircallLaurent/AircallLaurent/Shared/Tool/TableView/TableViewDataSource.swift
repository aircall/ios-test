import UIKit

/*******************************************************************************
 * TableViewDataSource
 *
 * Generic class conforming to table view data source protocol.
 *
 ******************************************************************************/

class TableViewDataSource<Provider: CollectionDataProvider>:
  NSObject,
  UITableViewDataSource
{

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  private var provider: Provider

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(with provider: Provider) {
    self.provider = provider
  }

  //----------------------------------------------------------------------------
  // MARK: - Data source
  //----------------------------------------------------------------------------

  func numberOfSections(in tableView: UITableView) -> Int {
    return provider.numberOfSections()
  }

  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return provider.numberOfItems(in: section)
  }

  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let item = provider.item(at: indexPath) else {
      return UITableViewCell()
    }
    return item.configuratedCellFor(tableView: tableView,
                                    atIndexPath: indexPath)
  }

}
