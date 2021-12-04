//
//  MainSearchMainSearchAssembler.swift
//  LikeTok
//
//  Created by Artem Holod on 27/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum MainSearchAssembler {
    static func createModule() -> MainSearchViewController {
        let viewController = MainSearchViewController()
        let presenter = MainSearchPresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
