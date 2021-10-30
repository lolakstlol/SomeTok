//
//  ResetPasswordResetPasswordAssembler.swift
//  LikeTok
//
//  Created by Danik on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum PasswordRecoveryFirstAssembler {
    static func createModule(onCompleteRecovery: @escaping EmptyClosure) -> PasswordRecoveryFirstViewController {
        let viewController = PasswordRecoveryFirstViewController()
        let presenter = PasswordRecoveryFirstPresenter(viewController)
        presenter.onFinishFlow = onCompleteRecovery
        viewController.presenter = presenter
        return viewController
    }
}
