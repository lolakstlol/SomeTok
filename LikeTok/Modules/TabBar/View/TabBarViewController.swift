//
//  TabBarViewController.swift
//  LikeTok
//
//  Created by Daniil Stelchenko on 27.10.21.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var presenter: TabBarPresenterInput!

    lazy var customTabBarView: CustomTabBarView = {
        return CustomTabBarView()
    }()
    
    @IBInspectable public var tabBarBackgroundColor: UIColor? {
        didSet {
            customTabBarView.backgroundColor = tabBarBackgroundColor
        }
    }
    
    override open var selectedViewController: UIViewController? {
        didSet {
            customTabBarView.select(at: selectedIndex, notifyDelegate: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        additionalSafeAreaInsets = UIEdgeInsets(top: 5,
//                                                left: .zero,
//                                                bottom: Constants.TabBar.tabBarHeight + Constants.TabBar.bottomSpacing,
//                                                right: .zero)
        presenter.viewDidLoad()
        presenter.attachInstanse(tabbar: customTabBarView)
        tabBar.isHidden = true
        
        setupTabBar()
        
        customTabBarView.items = tabBar.items ?? []
        customTabBarView.select(at: selectedIndex)
    }

    
    private func setupTabBar() {
        view.addSubview(customTabBarView)
        
//        customTabBarView.topAnchor.constraint(equalTo: view.bottomAnchor,
//                                              constant: -(Constants.TabBar.bottomSpacing + spacing + Constants.TabBar.tabBarHeight)).isActive = true
//        customTabBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        customTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.TabBar.horizontleSpacing).isActive = true
//        customTabBarView.heightAnchor.constraint(equalToConstant: Constants.TabBar.tabBarHeight).isActive = true
        
        view.bringSubviewToFront(customTabBarView)
        tabBarBackgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
    }
}

extension TabBarViewController: TabBarPresenterOutput {
    func setViewControllers(_ items: [UIViewController], with startViewController: Int) {
        setViewControllers(items, animated: true)
        selectedIndex = startViewController
    }
    
    func setViewController(index: Int) {

    }
    
    func getViewControllers() -> [UIViewController] {
        return viewControllers ?? []
    }
    
    func showTabBar(completion: (() -> ())?) {
        
    }
    
    func hideTabBar(completion: (() -> ())?) {
        
    }
    

}
