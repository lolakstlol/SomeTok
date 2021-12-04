//
//  FilterCurrentFilterCurrentPresenter.swift
//  LikeTok
//
//  Created by Artem Holod on 04/12/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

final class FilterCurrentPresenter {
    private unowned let view: FilterCurrentPresenterOutput

    init(_ view: FilterCurrentPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
     
    }

}

extension FilterCurrentPresenter: FilterCurrentPresenterInput {

}
