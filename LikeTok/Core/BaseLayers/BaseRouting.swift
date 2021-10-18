//
//  BaseRouting.swift
//  magnit-ios
//
//  Created by Dmitry Kosyakov on 24.08.2020.
//  Copyright © 2020 BSL.dev. All rights reserved.
//

import UIKit.UIViewController

protocol BaseRouting: AnyObject {
    func dismiss()
    func popToRoot()
    func pop()
}

extension BaseRouting where Self: BaseRouter {
    func dismiss() {
        if let nvc = viewController.navigationController {
            nvc.dismiss(animated: true)
        } else {
            viewController.dismiss(animated: true)
        }
    }
    
    func popToRoot() {
        if let nvc = viewController.navigationController {
            nvc.popToRootViewController(animated: true)
        }
    }

    func pop() {
        if let nvc = viewController.navigationController {
            nvc.popViewController(animated: true)
        }
    }
}
