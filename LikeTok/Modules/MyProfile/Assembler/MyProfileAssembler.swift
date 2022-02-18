//
//  MyProfileAssembler.swift
//  LikeTok
//
//  Created by Daniel on 17.02.22.
//

import Foundation

enum MyProfileAssembler {
    static func createModule() -> MyProfileViewController {
        let viewController = MyProfileViewController()
        let presenter = MyProfilePresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
