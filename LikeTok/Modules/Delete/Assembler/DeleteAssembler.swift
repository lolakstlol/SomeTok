//
//  DeleteDeleteAssembler.swift
//  LikeTok
//
//  Created by Artem Holod on 28/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum DeleteAssembler {
    static func createModule() -> DeleteViewController {
        let viewController = DeleteViewController()
        let presenter = DeletePresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
