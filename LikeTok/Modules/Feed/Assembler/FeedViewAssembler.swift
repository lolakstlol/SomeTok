//
//  FeedViewFeedViewAssembler.swift
//  marketplace
//
//  Created by Mikhail Lutskii on 20/11/2020.
//  Copyright © 2020 BSL. All rights reserved.
//

final class FeedViewAssembler {
    static func createModule(type: FeedViewEnterOption = .subscriptions,
                             feedService: FeedServiceProtocol = FeedService(),
                             collectionManager: FeedCollectionManagement = FeedCollectionManager()) -> FeedViewViewController {
        let viewController = FeedViewViewController()
        let interactor = FeedViewInteractor(type, feedService)
        let presenter = FeedViewPresenter(interactor, viewController)
        viewController.presenter = presenter
        viewController.collectionManager = collectionManager
        return viewController
    }
}
