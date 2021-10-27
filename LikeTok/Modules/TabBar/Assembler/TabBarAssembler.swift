//
//  TabBarTabBarAssembler.swift
//  LikeTok
//
//  Created by Danik on 26/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum TabBarAssembler {
    static func createModule() -> TabBarViewController {
        let viewController = TabBarViewController()
        let presenter = TabBarPresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
