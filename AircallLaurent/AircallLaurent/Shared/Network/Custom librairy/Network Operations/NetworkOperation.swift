import Foundation

class NetworkOperation<
  ResultSuccessType: Codable,
  RequestType: ApiRequestProtocol
>: AsynchronousBlockOperation {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Typealias ********************/

  typealias ResultType = Result<ResultSuccessType, Error>

  /******************** Services ********************/

  private let service: UrlSessionApiService

  private var request: RequestType

  /******************** Result ********************/

  var completionBlockInMainThread: ((ResultType) -> Void)?

  var success: ((ResultSuccessType) -> Void)?

  var failure: ((Error) -> Void)?

  private(set) var result: ResultType =
  ResultType.failure(NetworkError.invalidResult) {
    didSet {
      switch result {
        case .success(let data): success?(data)
        case .failure(let error): failure?(error)
      }

      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        self.completionBlockInMainThread?(self.result)
      }

      finish()
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(request: RequestType,
       dependencies: [Operation]?,
       serverConfiguration: ApiServerConfiguration = .aircallAPI) {
    self.service = UrlSessionApiService(configuration: serverConfiguration)
    self.request = request
    super.init()
    setup(dependencies: dependencies, shouldAddToNetworkQueue: false)
  }

  private func setup(dependencies: [Operation]?,
                     shouldAddToNetworkQueue: Bool) {
    dependencies?.forEach() { addDependency($0) }
    setupRequest()

    if shouldAddToNetworkQueue {
      NetworkQueue.shared.addOperation(operation: self)
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Request
  //----------------------------------------------------------------------------

  private func setupRequest() {
    service.setup(with: request) { [weak self] result in
      switch result {
        case .failure(let error): self?.handleFailure(error: error)
        case .success(let data): self?.handleSuccess(data: data)
      }
    }
  }

  private func handleSuccess(data: Data) {
    do {
      let item = try JSONDecoder().decode(ResultSuccessType.self, from: data)
      result = ResultType.success(item)
    } catch {
      handleFailure(error: error)
    }
  }

  private func handleFailure(error: Error) {
    result = ResultType.failure(error)
  }

  //----------------------------------------------------------------------------
  // MARK: - Operation life cycle
  //----------------------------------------------------------------------------

  override func main() {
    service.start()
  }

  override func cancel() {
    super.cancel()
    service.cancel()
  }

}
