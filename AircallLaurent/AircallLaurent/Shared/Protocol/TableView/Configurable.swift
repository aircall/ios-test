import Foundation

/*******************************************************************************
 * CellConfigurable
 *
 * A type that can be configured with data.
 *
 ******************************************************************************/

protocol Configurable: class {

  associatedtype DataType

  func configure(with data: DataType)

}
