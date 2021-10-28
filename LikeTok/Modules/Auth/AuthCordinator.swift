import UIKit

class AuthCoordinator: BaseCoordinator {
    
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
        showAuth()
    }
}

extension AuthCoordinator {
    func showAuth() {
        let vc = StartSplashScreenAssembler.createModule { [weak self] in
            let vc = SignUpAssembler.createModule {
                self?.finishFlow?()
            }
            let nav = UINavigationController(rootViewController: vc)
            self?.router.setRootModule(nav, windowBackgroundColor: .white)
        }
        router.setRootModule(vc, windowBackgroundColor: .white)
    }
}
