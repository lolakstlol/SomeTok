// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {

  public enum AuthCode {
    /// Получить новый код
    public static let getNewCode = Strings.tr("Localizable", "AuthCode.getNewCode")
    /// Подтверждение
    public static let navigationTitle = Strings.tr("Localizable", "AuthCode.navigationTitle")
    /// Мы отправили код на e-mail, введите его в поле ниже
    public static let title = Strings.tr("Localizable", "AuthCode.title")
  }

  public enum Onboarding {
    /// Next
    public static let next = Strings.tr("Localizable", "Onboarding.Next")
    /// Skip
    public static let skip = Strings.tr("Localizable", "Onboarding.Skip")
  }

  public enum PasswordRecovery {
    /// Error
    public static let error = Strings.tr("Localizable", "PasswordRecovery.error")
    public enum First {
      /// Check the correctness of your mail
      public static let badEmail = Strings.tr("Localizable", "PasswordRecovery.First.badEmail")
      /// There is no such user. Please check the correctness of the mail.
      public static let noUserError = Strings.tr("Localizable", "PasswordRecovery.First.noUserError")
      /// Server error. Check your internet connection.
      public static let responseError = Strings.tr("Localizable", "PasswordRecovery.First.responseError")
      /// Resume
      public static let resume = Strings.tr("Localizable", "PasswordRecovery.First.resume")
      /// A confirmation code will be sent to your email address
      public static let text = Strings.tr("Localizable", "PasswordRecovery.First.text")
      /// Password recovery
      public static let title = Strings.tr("Localizable", "PasswordRecovery.First.title")
    }
    public enum Second {
      /// Enter the code from the email
      public static let code = Strings.tr("Localizable", "PasswordRecovery.Second.code")
      /// Enter the password
      public static let enterThePassword = Strings.tr("Localizable", "PasswordRecovery.Second.enterThePassword")
      /// You entered invalid characters
      public static let invalidPassword = Strings.tr("Localizable", "PasswordRecovery.Second.invalidPassword")
      /// Resume
      public static let resume = Strings.tr("Localizable", "PasswordRecovery.Second.resume")
      /// Enter a new password
      public static let text = Strings.tr("Localizable", "PasswordRecovery.Second.text")
      /// Password recovery
      public static let title = Strings.tr("Localizable", "PasswordRecovery.Second.title")
    }
  }

  public enum SignIn {
    /// Создать аккаунт
    public static let createAccount = Strings.tr("Localizable", "SignIn.createAccount")
    /// Забыли пароль?
    public static let resetPassword = Strings.tr("Localizable", "SignIn.resetPassword")
    /// Авторизация
    public static let title = Strings.tr("Localizable", "SignIn.title")
  }

  public enum SignUP {
    /// Продолжить
    public static let continueButton = Strings.tr("Localizable", "SignUP.continueButton")
    /// Уже зарегистрированы?
    public static let loginButton = Strings.tr("Localizable", "SignUP.loginButton")
    /// Согласен с Политикой обработки персональных данных
    public static let privacy = Strings.tr("Localizable", "SignUP.privacy")
    /// Политикой обработки персональных данных
    public static let privacyDetected = Strings.tr("Localizable", "SignUP.privacyDetected")
    /// Регистрация
    public static let title = Strings.tr("Localizable", "SignUP.title")
    public enum PlaceHolder {
      /// Логин
      public static let login = Strings.tr("Localizable", "SignUP.placeHolder.login")
      /// E-mail
      public static let mail = Strings.tr("Localizable", "SignUP.placeHolder.mail")
      /// Пароль
      public static let password = Strings.tr("Localizable", "SignUP.placeHolder.password")
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
