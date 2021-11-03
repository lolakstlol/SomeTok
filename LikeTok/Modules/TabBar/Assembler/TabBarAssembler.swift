//
//  TabBarTabBarAssembler.swift
//  LikeTok
//
//  Created by Artem Holod on 01/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

enum TabBarAssembler {
    static func createModule(startVC: Int = 0) -> TabBarViewController {
        let stroyboard = UIStoryboard(name: String(describing: TabBarViewController.self), bundle: nil)
        let viewController: TabBarViewController
        viewController = stroyboard.instantiateViewController(identifier: String(describing: TabBarViewController.self))
        let presenter = TabBarPresenter(viewController, startVC)
        viewController.presenter = presenter
        return viewController
    }
}
