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
        let networkService = OtherProfileNetworkService(uuid: uuid)
        let feedNetworkService = FeedOtherNetworkService(uuid: uuid)
        let presenter = OtherProfilePresenter(viewController, networkService, feedNetworkService, uuid)
        viewController.presenter = presenter
        return viewController
    }
}
