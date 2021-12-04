import UIKit
import AppTrackingTransparency

private enum OnboardingState {
    case paywallNotPassed
    case paywallPassed
}

private struct AppStartPaywallState {
    let hasShown: Bool
    let firstTimeDelay: Int
    let frequency: Int
    let startsWithoutShow: Int
    
    var isTimeToShow: Bool {
        let deadline = hasShown ? frequency : firstTimeDelay
        return startsWithoutShow >= deadline
    }
}

private enum LaunchInstructor {
    case onboarding
    case main
    
    static func build(onboardingState: OnboardingState) -> Self {
        if onboardingState == .paywallNotPassed {
            return .onboarding
        }
        return .main
    }
}

class ApplicationCoordinator: BaseCoordinator {
        
    private let coordinatorFactory: CoordinatorFactory
        
    private let settings: ApplicationSettings
    
    private let router: Router
            
    private var instructor: LaunchInstructor {
        return LaunchInstructor.build(onboardingState: onboardingState)
    }
    
    private var onboardingState: OnboardingState {
        return settings.hasPassedPaywall ? .paywallPassed : .paywallNotPassed
    }
    
    init(coordinatorFactory: CoordinatorFactory,
         settings: ApplicationSettings = ApplicationSettings.shared,
         router: Router) {
        self.coordinatorFactory = coordinatorFactory
        self.settings = settings
        self.router = router
    }
    
    override func start(with deepLinkOption: DeepLinkOption?) {
        if let deepLinkOption = deepLinkOption {
            // to do
        } else {
            switch instructor {
            case .onboarding:
                runOnboardingFlow()
            case .main:
                AccountManager.isAuthorized() ? runMainFlow() : runAuthFlow()
            }
            
        }
        
    }
    
    private func requestTrackingAuthorization() {
        if #available(iOS 14.5, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    // Tracking authorization dialog was shown
                    // and we are authorized
                    print("requestTrackingAuthorization: Authorized")

                    // Now that we are authorized we can get the IDFA
//                    DispatchQueue.main.async {
//                        FBSDKCoreKit.Settings.isAdvertiserIDCollectionEnabled = true
//                    }
                case .denied:
                   // Tracking authorization dialog was
                   // shown and permission is denied
                     print("requestTrackingAuthorization: Denied")
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    print("requestTrackingAuthorization: Not Determined")
                case .restricted:
                    print("requestTrackingAuthorization: Restricted")
                @unknown default:
                    print("requestTrackingAuthorization: Unknown")
                }
            }
        }
    }
}

// MARK: - Flows

private extension ApplicationCoordinator {
    
    func runOnboardingFlow() {
        let coordinator = coordinatorFactory.makeOnboardingCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.settings.hasPassedPaywall = true
            self?.runAuthFlow()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func runAuthFlow() {
        let coordinator = coordinatorFactory.makeAuthModuleCordinator(router: router)
        coordinator.finishFlow = {
            self.removeDependency(coordinator)
            self.runMainFlow()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    
    func runMainFlow() {
        router.setRootModule(UINavigationController(rootViewController: TabBarAssembler.createModule()))
        //router.setRootModule(UINavigationController(rootViewController: CatalogAssembler.createModule()), windowBackgroundColor: .green)
//        let coordinator = coordinatorFactory.makeAuthModuleCordinator(router: router)
//        requestTrackingAuthorization()
//        pushNotificationsController.registerForPushNotifications { [weak self] granted, error in
//            self?.analytics.updateUserProperty(.setPushesAllowed(allowed: granted))
//        }
        
//        router.setRootModule(UIViewController(), windowBackgroundColor: .white)
//
//        addDependency(coordinator)
//        coordinator.start()
    }
    
}

class CoordinatorFactory {
    
    func makeOnboardingCoordinator(router: Router) -> OnboardingCoordinator {
        return OnboardingCoordinator(router: router)
    }
    
    func makeAuthModuleCordinator(router: Router) -> AuthCoordinator {
        return AuthCoordinator(router: router)
    }
    
//    func makePasswordRecoveryCoordinator(router: Router) -> PasswordRecoveryCoordinator {
//        return PasswordRecoveryCoordinator(router: router)
//    }
}
