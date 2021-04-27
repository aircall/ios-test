import UIKit

/*******************************************************************************
 * TableViewDelegate
 *
 * Generic class conforming to table view delegate.
 *
 ******************************************************************************/

class TableViewDelegate<Provider: CollectionDataProvider>:
  NSObject,
  UITableViewDelegate
{

  var provider: Provider

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(with provider: Provider) {
    self.provider = provider
  }

  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    provider.item(at: indexPath)?.select()
  }

}
