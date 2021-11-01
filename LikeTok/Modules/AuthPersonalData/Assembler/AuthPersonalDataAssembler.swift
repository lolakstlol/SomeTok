//
//  AuthPersonalDataAuthPersonalDataAssembler.swift
//  LikeTok
//
//  Created by Artem Holod on 31/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum AuthPersonalDataAssembler {
    static func createModule() -> AuthPersonalDataViewController {
        let viewController = AuthPersonalDataViewController()
        let presenter = AuthPersonalDataPresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
