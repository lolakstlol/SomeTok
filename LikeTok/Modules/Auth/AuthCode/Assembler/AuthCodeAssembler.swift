//
//  AuthCodeAuthCodeAssembler.swift
//  LikeTok
//
//  Created by Artem Holod on 26/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum AuthCodeAssembler {
    static func createModule(model: SignUpUserModel, completion: @escaping EmptyClosure) -> AuthCodeViewController {
        let viewController = AuthCodeViewController()
        let presenter = AuthCodePresenter(viewController, signUpModel: model)
        presenter.finishFlow = completion
        viewController.presenter = presenter
        return viewController
    }
}
