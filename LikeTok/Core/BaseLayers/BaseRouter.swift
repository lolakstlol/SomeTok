//
//  BaseRouter.swift
//  magnit-ios
//
//  Created by Dmitry Kosyakov on 24.08.2020.
//  Copyright © 2020 BSL.dev. All rights reserved.
//

import UIKit.UIViewController

class BaseRouter: BaseRouting {
    private(set) unowned var viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
}
