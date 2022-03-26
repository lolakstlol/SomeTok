//
//  FeedViewFeedViewAssembler.swift
//  marketplace
//
//  Created by Mikhail Lutskii on 20/11/2020.
//  Copyright © 2020 BSL. All rights reserved.
//

final class FeedViewAssembler {
    static func createModule(type: FeedViewEnterOption = .mainFollowing,
                             feedService: FeedServiceProtocol = FeedService(),
                             collectionManager: FeedCollectionManagement = FeedCollectionManager(),
                             initialDataSourse: [FeedPost] = [],
                             initialCursor: String = String(),
                             initialIndex: Int = Int()) -> FeedViewViewController {
        let viewController = FeedViewViewController()
        let interactor = FeedViewInteractor(type, feedService)
        let presenter = FeedViewPresenter(interactor, viewController, initialDataSourse, initialCursor, initialIndex)
        viewController.presenter = presenter
        viewController.collectionManager = collectionManager
        return viewController
    }
}
