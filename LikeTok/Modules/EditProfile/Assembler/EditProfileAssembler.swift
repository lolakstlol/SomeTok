//
//  EditProfileAssembler.swift
//  LikeTok
//
//  Created by Daniel on 19.02.22.
//

import Foundation

enum EditProfileAssembler {
    static func createModule(_ model: EditProfileModel, completion: ((EditProfileModel) -> ())?) -> EditProfileViewController {
        let viewController = EditProfileViewController()
        let networkService = ProfileNetworkService()
        let presenter = EditProfilePresenter(viewController, networkService, model, completion)
        viewController.presenter = presenter
        return viewController
    }
}
