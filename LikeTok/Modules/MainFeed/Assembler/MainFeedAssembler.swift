//
//  MainFeedMainFeedAssembler.swift
//  LikeTok
//
//  Created by Artem Holod on 01/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum MainFeedAssembler {
    static func createModule() -> MainFeedViewController {
        let viewController = MainFeedViewController()
        let presenter = MainFeedPresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
