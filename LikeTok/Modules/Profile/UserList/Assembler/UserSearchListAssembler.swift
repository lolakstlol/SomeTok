//
//  UserSearchListAssembler.swift
//  LikeTok
//
//  Created by Daniel on 21.03.22.
//

import Foundation

enum UserSearchListAssembler {
    static func createModule(selectedSearchType: UserSearchTypes, baseControllerModel: BaseProfile) -> UserSearchListViewController {
        let viewController = UserSearchListViewController()
        let presenter = UserSearchListPresenter(viewController, selectedType: selectedSearchType, baseControllerModel: baseControllerModel)
        viewController.presenter = presenter
        return viewController
    }
}
