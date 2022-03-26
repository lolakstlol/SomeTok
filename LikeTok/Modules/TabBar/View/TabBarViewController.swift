import UIKit

enum TabBarAppearance {
    case white
    case transparent
}

final class TabBarViewController: UITabBarController {
	var presenter: TabBarPresenterInput!
    var previosSelectedItem: Int?

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        presenter.attachInstanse(tabbar: self)
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
        navigationController?.navigationBar.isHidden = true
//        delegate = self
        previosSelectedItem = selectedIndex
    }
    
}

extension TabBarViewController: TabBarPresenterOutput {
    func updateAppearance(appearance: TabBarAppearance) {
        switch appearance {
        case .white:
            let tabBarAppearance = UITabBarAppearance()
            let tabBarItemAppearance = UITabBarItemAppearance()

            tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
            tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

            tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
            tabBarAppearance.backgroundColor = .white
            tabBar.standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = tabBarAppearance
            }
        case .transparent:
            tabBar.backgroundColor = .black
            let tabBarAppearance = UITabBarAppearance()
            let tabBarItemAppearance = UITabBarItemAppearance()

            tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
            tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

            tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
            tabBarAppearance.backgroundColor = .black
            tabBar.standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = tabBarAppearance
            }
        }
    }
    
    func updateViews(vc: [UIViewController], selected: Int) {
        self.viewControllers = vc
        self.selectedIndex = selected
    }
    
    func returnToPreviosItem() {
        selectedIndex = previosSelectedItem ?? .zero
        updateAppearance(appearance: .transparent)
    }
    
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        previosSelectedItem = selectedIndex
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

    }
}
