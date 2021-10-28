import Foundation

protocol SettingsProtocol {
    var hasPassedPaywall: Bool { get set }
    var lastReviewVersion: String? { get set }
}

protocol FeedbackGeneratorSettings {
    var feedbackGeneratorEnabled: Bool { get set }
}

class ApplicationSettings: SettingsProtocol {
    
    static var shared = ApplicationSettings(userDefaults: UserDefaults.standard)

    public var notificationToken: String = ""
    
    private let userDefaults: UserDefaults
    
    enum Key: CaseIterable {
        static let hasPassedPaywall = "hasPassedPaywall"
        static let notificationEnabled = "notificationEnabled"
        static let trackingsFilter = "trackings.filter"
        static let hasAddedTracking = "hasAddedTracking"
        static let lastVersion = "lastVersion"
        static let lastReviewVersion = "lastReviewVersion"
        static let feedbackGeneratorDisabled = "feedbackGeneratorDisabled"
        static let didRegisterLocalPush = "didRegisterLocalPush"
        static let hasShownAppStartPaywall = "appStartPaywall.hasShown"
        static let startsWithoutAppStartPaywall = "appStartPaywall.startsWithoutShow"
        static let extraPackagesCount = "reward.extraPackagesCount"
        static let isRegisteredInstallViaInvite = "isRegisteredInstallViaInvite"
    }
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func clearAllData() {
        let dictionary = userDefaults.dictionaryRepresentation()
           dictionary.keys.forEach { key in
            userDefaults.removeObject(forKey: key)
        }
        userDefaults.synchronize()
    }
    
    var hasPassedPaywall: Bool {
        get {
            return userDefaults.bool(forKey: Key.hasPassedPaywall)
        }
        set {
            userDefaults.set(newValue, forKey: Key.hasPassedPaywall)
        }
    }
    
    var didRegisterLocalPush: Bool {
        get {
            return userDefaults.bool(forKey: Key.didRegisterLocalPush)
        }
        set {
            userDefaults.set(newValue, forKey: Key.didRegisterLocalPush)
        }
    }
    
    var notificationEnabled: Bool? {
        get {
            if userDefaults.object(forKey: Key.notificationEnabled) == nil {
                return nil
            }
            return userDefaults.bool(forKey: Key.notificationEnabled)
        }
        set {
            if let newValue = newValue {
                userDefaults.set(newValue, forKey: Key.notificationEnabled)
            } else {
                userDefaults.removeObject(forKey: Key.notificationEnabled)
            }
            
        }
    }

    var lastVersion: String? {
        get {
            return userDefaults.string(forKey: Key.lastVersion)
        }
        set {
            userDefaults.set(newValue, forKey: Key.lastVersion)
        }
    }
    
    var lastReviewVersion: String? {
        get {
            return userDefaults.string(forKey: Key.lastReviewVersion)
        }
        set {
            userDefaults.set(newValue, forKey: Key.lastReviewVersion)
        }
    }
}

extension ApplicationSettings: FeedbackGeneratorSettings {
    var feedbackGeneratorEnabled: Bool {
        get {
            return !userDefaults.bool(forKey: Key.feedbackGeneratorDisabled)
        }
        set {
            userDefaults.set(!newValue, forKey: Key.feedbackGeneratorDisabled)
        }
    }
}
