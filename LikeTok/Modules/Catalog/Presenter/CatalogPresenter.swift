//
//  CatalogCatalogPresenter.swift
//  LikeTok
//
//  Created by Artem Holod on 27/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

final class CatalogPresenter {
    private unowned let view: CatalogPresenterOutput

    init(_ view: CatalogPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
     
    }

}

extension CatalogPresenter: CatalogPresenterInput {
    func searchDidTap() {
        view.openSerachScreen()
    }
}
