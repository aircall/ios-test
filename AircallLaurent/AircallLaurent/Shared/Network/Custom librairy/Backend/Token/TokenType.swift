import Foundation

public enum TokenType: Equatable {

  //----------------------------------------------------------------------------
  // MARK: - Cases
  //----------------------------------------------------------------------------

  case user
  case admin
  case none
  case custom(token: String)

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var isSecureType: Bool {
    switch self {
    case .none: return false
    default: return true
    }
  }

}

public func == (lhs: TokenType, rhs: TokenType) -> Bool {
  switch (lhs, rhs) {
  case (let .custom(lhsToken), let .custom(rhsToken)):
    return lhsToken == rhsToken
  case (.user, .user): return true
  case (.admin, .admin): return true
  case (.none, .none): return true
  default: return false
  }
}
