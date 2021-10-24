//
//  ResetPasswordResetPasswordAssembler.swift
//  LikeTok
//
//  Created by Danik on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum ResetPasswordEmailAssembler {
    static func createModule() -> ResetPasswordEmailViewController {
        let viewController = ResetPasswordEmailViewController()
        let presenter = ResetPasswordEmailPresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
