// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Abandoned by %@
  internal static func abandonedBy(_ p1: Any) -> String {
    return L10n.tr("Localizable", "abandoned_by", String(describing: p1))
  }
  /// Answered by %@
  internal static func answeredBy(_ p1: Any) -> String {
    return L10n.tr("Localizable", "answered_by", String(describing: p1))
  }
  /// Assign
  internal static let assign = L10n.tr("Localizable", "assign")
  /// %@ answered
  internal static func callDirectionAnswered(_ p1: Any) -> String {
    return L10n.tr("Localizable", "call_direction_answered", String(describing: p1))
  }
  /// %@ missed
  internal static func callDirectionMissed(_ p1: Any) -> String {
    return L10n.tr("Localizable", "call_direction_missed", String(describing: p1))
  }
  /// Call ID copied to clipboard!
  internal static let callIdCopied = L10n.tr("Localizable", "call_id_copied")
  /// Call Information
  internal static let callInformationTitle = L10n.tr("Localizable", "call_information_title")
  /// callee
  internal static let callee = L10n.tr("Localizable", "callee")
  /// caller
  internal static let caller = L10n.tr("Localizable", "caller")
  /// Contact Information
  internal static let contactInformationTitle = L10n.tr("Localizable", "contact_information_title")
  /// Copy call ID
  internal static let copyCallId = L10n.tr("Localizable", "copy_call_id")
  /// 
  internal static let emptyString = L10n.tr("Localizable", "empty_string")
  /// History
  internal static let history = L10n.tr("Localizable", "history")
  /// Incoming call
  internal static let incomingCall = L10n.tr("Localizable", "incoming_call")
  /// Loading...
  internal static let loadingIndicatorTitle = L10n.tr("Localizable", "loading_indicator_title")
  /// made by %@
  internal static func madeByCaller(_ p1: Any) -> String {
    return L10n.tr("Localizable", "made_by_caller", String(describing: p1))
  }
  /// Not answered by %@
  internal static func notAnsweredBy(_ p1: Any) -> String {
    return L10n.tr("Localizable", "not_answered_by", String(describing: p1))
  }
  /// Notes
  internal static let notes = L10n.tr("Localizable", "notes")
  /// OK
  internal static let ok = L10n.tr("Localizable", "ok")
  /// on %@
  internal static func onCallee(_ p1: Any) -> String {
    return L10n.tr("Localizable", "on_callee", String(describing: p1))
  }
  /// Outcoming call
  internal static let outcomingCall = L10n.tr("Localizable", "outcoming_call")
  /// Tags
  internal static let tags = L10n.tr("Localizable", "tags")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
