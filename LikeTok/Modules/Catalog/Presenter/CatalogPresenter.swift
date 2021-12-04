//
//  CatalogCatalogPresenter.swift
//  LikeTok
//
//  Created by Artem Holod on 27/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

struct CategoriesFiltres {
    var countries: String
    var cities: String
    var categories: String
}

final class CatalogPresenter {
    private unowned let view: CatalogPresenterOutput
    private let apiWorker: SearchApiWorker = SearchApiWorker()
    var filtres = CategoriesFiltres(countries: "",
                                    cities: "",
                                    categories: "")
    var selectedType: CategoriesType = .digital
    init(_ view: CatalogPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
        loadCatalog()
    }

    private func loadCatalog() {
        apiWorker.getCatalogFeed(type: selectedType, filtres: filtres) { response in
            switch response {
            case .success(let categories):
                self.view.showCategories(categories: categories?.data?.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension CatalogPresenter: CatalogPresenterInput {
    func filtresDidTap() {
        view.openFiltres()
    }
    
    func didChangeType(type: CategoriesType) {
        selectedType = type
        loadCatalog()
    }
    
    func searchDidTap() {
        view.openSerachScreen()
    }
}
