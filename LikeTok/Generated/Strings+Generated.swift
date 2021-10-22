// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {

  public enum DrinkList {
    public enum Navigation {
      /// Drinks
      public static let title = Strings.tr("Localizable", "DrinkList.Navigation.Title")
    }
  }

  public enum Onboarding {
    /// Next
    public static let next = Strings.tr("Localizable", "Onboarding.Next")
    /// Skip
    public static let skip = Strings.tr("Localizable", "Onboarding.Skip")
  }

  public enum ResetPassword {
    /// E-mail
    public static let email = Strings.tr("Localizable", "ResetPassword.Email")
    /// Resume
    public static let resume = Strings.tr("Localizable", "ResetPassword.Resume")
    /// The confirmation code will be sent to your email address
    public static let text = Strings.tr("Localizable", "ResetPassword.Text")
    /// Reset password
    public static let title = Strings.tr("Localizable", "ResetPassword.Title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
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
