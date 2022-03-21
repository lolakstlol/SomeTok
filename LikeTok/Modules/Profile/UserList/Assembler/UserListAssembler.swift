//
//  UserListAssembler.swift
//  LikeTok
//
//  Created by Daniel on 21.03.22.
//

import Foundation

enum UserListAssembler {
    static func createModule(type: UserSearchTypes) -> UserSearchListViewController {
        let viewController = UserSearchListViewController()
        let presenter = UserSearchListPresenter(viewController, type: type)
        viewController.presenter = presenter
        return viewController
    }
}
