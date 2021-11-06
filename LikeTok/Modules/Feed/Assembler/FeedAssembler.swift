//
//  FeedFeedAssembler.swift
//  LikeTok
//
//  Created by Danik on 06/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum FeedAssembler {
    static func createModule() -> FeedViewController {
        let viewController = FeedViewController()
        let presenter = FeedPresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
