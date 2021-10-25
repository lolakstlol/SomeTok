//
//  ResetPasswordNewPasswordResetPasswordNewPasswordAssembler.swift
//  LikeTok
//
//  Created by Danik on 24/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum ResetPasswordNewPasswordAssembler {
    static func createModule() -> ResetPasswordNewPasswordViewController {
        let viewController = ResetPasswordNewPasswordViewController()
        let presenter = ResetPasswordNewPasswordPresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
