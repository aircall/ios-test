import Foundation

enum NetworkError: Error {

  //----------------------------------------------------------------------------
  // MARK: - Cases
  //----------------------------------------------------------------------------

  case networkError
  case invalidJSON
  case invalidHTTPURLResponse(response: HTTPURLResponse)
  case couldNotGenerateURL
  case invalidResult
  case invalidEnvelopeData

}
