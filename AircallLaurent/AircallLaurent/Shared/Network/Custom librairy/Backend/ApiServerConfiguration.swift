import Foundation

// https://jsonplaceholder.typicode.com

final class ApiServerConfiguration {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Singleton ********************/

  static var aircallAPI =
    ApiServerConfiguration(host: "aircall-job.herokuapp.com",
                           version: "")

  /******************** URL ********************/

  private var host: String

  private(set) var version: String

  var baseURL: URLComponents {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = host
    return urlComponents
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  private init(host: String, version: String = "") {
    self.host = ""
    self.version = ""
    self.configure(host: host, version: version)
  }

  //----------------------------------------------------------------------------
  // MARK: - Configure
  //----------------------------------------------------------------------------

  func configure(host: String? = nil, version: String? = nil) {
    configure(host: host)
    configure(version: version)
  }

  private func configure(host: String?) {
    guard let host = host else { return }
    self.host = host
  }

  private func configure(version: String?) {
    guard let version = version else { return }

    if version.starts(with: "/") || version.isEmpty {
      self.version = version
    } else {
      self.version = "/" + version
    }
  }

}
