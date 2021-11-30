//
//  CatalogCatalogAssembler.swift
//  LikeTok
//
//  Created by Artem Holod on 27/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum CatalogAssembler {
    static func createModule() -> CatalogViewController {
        let viewController = CatalogViewController()
        let presenter = CatalogPresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
