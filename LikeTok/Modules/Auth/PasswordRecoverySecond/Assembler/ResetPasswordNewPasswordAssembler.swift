//
//  ResetPasswordNewPasswordResetPasswordNewPasswordAssembler.swift
//  LikeTok
//
//  Created by Danik on 24/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum PasswordRecoverySecondAssembler {
    static func createModule() -> PasswordRecoverySecondViewController {
        let viewController = PasswordRecoverySecondViewController()
        let presenter = PasswordRecoverySecondPresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
