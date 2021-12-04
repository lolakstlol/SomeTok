//
//  CatalogFiltresCatalogFiltresPresenter.swift
//  LikeTok
//
//  Created by Artem Holod on 04/12/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

final class CatalogFiltresPresenter {
    private unowned let view: CatalogFiltresPresenterOutput

    init(_ view: CatalogFiltresPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
     
    }

}

extension CatalogFiltresPresenter: CatalogFiltresPresenterInput {

}
