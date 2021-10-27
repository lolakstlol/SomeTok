// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {

  public enum Onboarding {
    /// Next
    public static let next = Strings.tr("Localizable", "Onboarding.Next")
    /// Skip
    public static let skip = Strings.tr("Localizable", "Onboarding.Skip")
  }

  public enum ResetPassword {
    /// Error
    public static let error = Strings.tr("Localizable", "ResetPassword.Error")
    public enum Email {
      /// Check the correctness of your mail
      public static let error = Strings.tr("Localizable", "ResetPassword.Email.error")
      /// Resume
      public static let resume = Strings.tr("Localizable", "ResetPassword.Email.resume")
      /// A confirmation code will be sent to your email address
      public static let text = Strings.tr("Localizable", "ResetPassword.Email.text")
      /// Password recovery
      public static let title = Strings.tr("Localizable", "ResetPassword.Email.title")
    }
    public enum NewPassword {
      /// Enter the password again
      public static let confrimThePassword = Strings.tr("Localizable", "ResetPassword.NewPassword.confrimThePassword")
      /// Enter the password
      public static let enterThePassword = Strings.tr("Localizable", "ResetPassword.NewPassword.enterThePassword")
      /// Resume
      public static let resume = Strings.tr("Localizable", "ResetPassword.NewPassword.resume")
      /// Enter a new password
      public static let text = Strings.tr("Localizable", "ResetPassword.NewPassword.text")
      /// Password recovery
      public static let title = Strings.tr("Localizable", "ResetPassword.NewPassword.title")
    }
  }

  public enum SplashScreen {
    /// Начать
    public static let begin = Strings.tr("Localizable", "SplashScreen.begin")
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
