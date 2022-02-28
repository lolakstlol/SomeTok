//
//  OtherProfileAssembler.swift
//  LikeTok
//
//  Created by Daniel on 20.02.22.
//

import Foundation

enum OtherProfileAssembler {
    static func createModule(_ uuid: String) -> OtherProfileViewController {
        let viewController = OtherProfileViewController()
        let networkService = ProfileNetworkService()
        let presenter = OtherProfilePresenter(viewController, networkService, uuid)
        viewController.presenter = presenter
        return viewController
    }
}
