//
//  FeedNewAssembler.swift
//  LikeTok
//
//  Created by Daniel on 17.01.22.
//

import Foundation

final class FeedNewAssembler {
    static func createModule(type: FeedViewEnterOption = .general,
                             feedService: FeedServiceProtocol = FeedService()) -> FeedNewwViewController {
        let viewController = FeedNewwViewController()
        let presenter = FeedNewPresenter(viewController, feedService, type: type)
        viewController.presenter = presenter
        return viewController
    }
}
