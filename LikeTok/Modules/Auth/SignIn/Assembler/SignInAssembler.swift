//
//  SignInSignInAssembler.swift
//  LikeTok
//
//  Created by Artem Holod on 27/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum SignInAssembler {
    static func createModule(onCompleteAuth: @escaping (() -> Void)) -> SignInViewController {
        let viewController = SignInViewController()
        let presenter = SignInPresenter(viewController)
        viewController.presenter = presenter
        presenter.finishFlow = onCompleteAuth
        return viewController
    }
}
