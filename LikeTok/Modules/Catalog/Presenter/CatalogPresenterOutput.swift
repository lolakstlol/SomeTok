//
//  CatalogCatalogPresenterOutput.swift
//  LikeTok
//
//  Created by Artem Holod on 27/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

protocol CatalogPresenterOutput: AnyObject {
    func openSerachScreen()
    func openFiltres()
    func showCategories(categories: [CategoriesDatum])
}
