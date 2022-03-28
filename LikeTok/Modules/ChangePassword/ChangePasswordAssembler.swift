//
//  ChangePasswordAssembler.swift
//  LikeTok
//
//  Created by Daniel on 24.03.22.
//

import Foundation

enum ChangePasswordAssembler {
    static func createModule() -> ChangePasswordViewController {
        let viewController = ChangePasswordViewController()
        let presenter = ChangePasswordPresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
