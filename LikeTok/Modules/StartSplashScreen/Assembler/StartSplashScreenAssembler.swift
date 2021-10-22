//
//  StartSplashScreenStartSplashScreenAssembler.swift
//  LikeTok
//
//  Created by Artem Holod on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum StartSplashScreenAssembler {
    static func createModule() -> StartSplashScreenViewController {
        let viewController = StartSplashScreenViewController()
        let presenter = StartSplashScreenPresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
