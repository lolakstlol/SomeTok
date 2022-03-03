//
//  FilterCurrentFilterCurrentAssembler.swift
//  LikeTok
//
//  Created by Artem Holod on 04/12/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum FilterType {
    case city
    case country
    case category
    case hashtag
}

enum FilterCurrentAssembler {
    static func createModule(type: FilterType, completion: @escaping (Any) -> Void) -> FilterCurrentViewController {
        let viewController = FilterCurrentViewController()
        let presenter = FilterCurrentPresenter(viewController)
        viewController.presenter = presenter
        viewController.filterType = type
        viewController.completion = completion
        return viewController
    }
}
