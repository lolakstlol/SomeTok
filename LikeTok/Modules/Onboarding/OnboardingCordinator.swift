import Foundation

class OnboardingCoordinator: BaseCoordinator {
    
    // MARK: - Public properties
    
    var finishFlow: EmptyClosure?
    
    // MARK: - Private properties
    
    private let router: Router
    
    private let settings: ApplicationSettings
    
    // MARK: - Initialization
    
    init(router: Router,
         settings: ApplicationSettings = ApplicationSettings.shared) {
        self.router = router
        self.settings = settings
    }
    
    // MARK: - BaseCoordinator
    
    override func start() {
        super.start()
        showOnboarding()
    }
}

extension OnboardingCoordinator {
    func showOnboarding() {
        let vc = OnboardingAssembler.createModule {
            self.finishFlow?()
        }
        router.setRootModule(vc, windowBackgroundColor: .white)
    }
}
