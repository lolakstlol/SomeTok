//
//  TabBarTabBarPresenter.swift
//  LikeTok
//
//  Created by Artem Holod on 01/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

struct TabBarItemModel {
    let title: String
    let image: UIImage
    let selectedImage: UIImage
}


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
        view.updateAppearance(appearance: .transparent)
    }

    
    private func getViewControllers() -> [UIViewController] {
        let tabBarItems: [(UIViewController, TabBarItemModel)] = [(FeedNewAssembler.createModule(),
                                                                       TabBarItemModel(title: Strings.Tabbar.feed,
                                                                                       image: Assets.feedUnselected.image,
                                                                                       selectedImage: Assets.feedSelected.image)),
                                                                  (CatalogAssembler.createModule(),
                                                                       TabBarItemModel(title: Strings.Tabbar.search,
                                                                                       image: Assets.searchUnselected.image,
                                                                                       selectedImage:
                                                                                        Assets.searchUnselected.image)),
                                                                      (UINavigationController(rootViewController: CameraViewController()) ,
                                                                       TabBarItemModel(title: Strings.Tabbar.add,
                                                                                       image: Assets.addUnselected.image,
                                                                                       selectedImage: Assets.addUnselected.image)),
                                                                      (ChatViewController(),
                                                                       TabBarItemModel(title: Strings.Tabbar.chat,
                                                                                       image: Assets.chatUnselected.image,
                                                                                       selectedImage:
                                                                                        Assets.chatSelected.image)),
                                                                      (ProfileViewController(),
                                                                       TabBarItemModel(title: Strings.Tabbar.profile,
                                                                                       image: Assets.chatUnselected.image,
                                                                                       selectedImage:
                                                                                        Assets.chatUnselected.image))]
        let viewControllers = { tabBarItems.map { $0.0 } }()

        setupTabBarItems(tabBarItems)
        return viewControllers
    }
    
    private func setupTabBarItems(_ tabBarItems: [(UIViewController, TabBarItemModel)]) {
        tabBarItems.forEach {
            $0.0.tabBarItem.title = $0.1.title
            $0.0.tabBarItem.image = $0.1.image
            $0.0.tabBarItem.selectedImage = $0.1.selectedImage
        }
    }

}

extension TabBarPresenter: TabBarPresenterInput {
    func attachInstanse(tabbar: UITabBarController) {
        tabbar.delegate = self
    }
}

extension TabBarPresenter: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        selectedViewController = viewController
        checkIsHomeVC(viewController)
    }
    
    private func checkIsHomeVC(_ viewController: UIViewController) {
        selectedViewController is FeedViewViewController ? view.updateAppearance(appearance: .transparent) : view.updateAppearance(appearance: .white)
    }
}
