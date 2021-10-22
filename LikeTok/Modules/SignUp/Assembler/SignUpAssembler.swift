//
//  SignUpSignUpAssembler.swift
//  LikeTok
//
//  Created by Artem Holod on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum SignUpAssembler {
    static func createModule() -> SignUpViewController {
        let viewController = SignUpViewController()
        let presenter = SignUpPresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
