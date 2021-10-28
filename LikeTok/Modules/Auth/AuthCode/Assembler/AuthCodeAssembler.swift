//
//  AuthCodeAuthCodeAssembler.swift
//  LikeTok
//
//  Created by Artem Holod on 26/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum AuthCodeAssembler {
    static func createModule() -> AuthCodeViewController {
        let viewController = AuthCodeViewController()
        let presenter = AuthCodePresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
