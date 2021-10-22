//
//  ResetPasswordResetPasswordAssembler.swift
//  LikeTok
//
//  Created by Danik on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum ResetPasswordAssembler {
    static func createModule() -> ResetPasswordViewController {
        let viewController = ResetPasswordViewController()
        let presenter = ResetPasswordPresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
