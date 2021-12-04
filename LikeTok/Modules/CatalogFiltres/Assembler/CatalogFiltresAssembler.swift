//
//  CatalogFiltresCatalogFiltresAssembler.swift
//  LikeTok
//
//  Created by Artem Holod on 04/12/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum CatalogFiltresAssembler {
    static func createModule(currentFiltres: CategoriesFiltres?, completion: @escaping (CategoriesFiltres?) -> Void) -> CatalogFiltresViewController {
        let viewController = CatalogFiltresViewController()
        let presenter = CatalogFiltresPresenter(viewController)
        viewController.presenter = presenter
        viewController.completion = completion
        return viewController
    }
}
