import UIKit

// Methods for navigation operations
class MainRouter: Router {

    private var window: UIWindow?
    
    private var topViewController: UIViewController? {
        // TODO: refactor
        return UIApplication.topViewController()
    }
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func present(_ module: Presentable?) {
        self.present(module, animated: true, completion: nil)
    }

    func present(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        if let controller = module?.toPresent() {
            self.topViewController?.present(controller, animated: animated, completion: completion)
        }
    }
    
    func push(_ module: Presentable?) {
        self.push(module, animated: true)
    }

    func push(_ module: Presentable?, animated: Bool) {
        if let controller = module?.toPresent() {
            self.topViewController?.navigationController?.pushViewController(controller, animated: animated)
        }
    }

    func setRootModule(_ module: Presentable?) {
        setRootModule(module, windowBackgroundColor: .clear)
    }

    func setRootModule(_ module: Presentable?, windowBackgroundColor: UIColor?) {
        window?.backgroundColor = windowBackgroundColor
        window?.rootViewController = module?.toPresent()
        // animate changing root view controller
        UIView.transition(with: window!,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {},
                          completion: nil)

    }
}
