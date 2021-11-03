//
//  ResetPasswordResetPasswordAssembler.swift
//  LikeTok
//
//  Created by Danik on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum PasswordRecoveryFirstAssembler {
    static func createModule() -> PasswordRecoveryFirstViewController {
        let viewController = PasswordRecoveryFirstViewController()
        let presenter = PasswordRecoveryFirstPresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
