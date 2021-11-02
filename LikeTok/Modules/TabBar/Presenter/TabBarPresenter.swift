//
//  TabBarTabBarPresenter.swift
//  LikeTok
//
//  Created by Artem Holod on 01/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class TabBarPresenter: NSObject {
    private unowned let view: TabBarPresenterOutput
    private var selectedViewController: UIViewController?
    private let startViewController: Int
    init(_ view: TabBarPresenterOutput,
         _ startViewController: Int) {
        self.view = view
        self.startViewController = startViewController
    }

    func viewDidLoad() {
        view.updateViews(vc: getViewControllers(), selected: startViewController)
    }
    
    private func getViewControllers() -> [UIViewController] {
        return [MainFeedAssembler.createModule(), UIViewController(), UIViewController(), UIViewController(), UIViewController()]
    }

}

extension TabBarPresenter: TabBarPresenterInput {
    func attachInstanse(tabbar: UITabBarController) {
        tabbar.delegate = self
    }
}

extension TabBarPresenter: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        checkIsHomeVC(viewController)
//
//        selectedViewController = view.getCurrentController()
    }
    
    private func checkIsHomeVC(_ viewController: UIViewController) {
//        if selectedViewController is CatalogWebViewController,
//           viewController == selectedViewController {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "onHome"), object: nil, userInfo: nil)
//        } else {
//            selectedViewController = nil
//        }
    }
}
