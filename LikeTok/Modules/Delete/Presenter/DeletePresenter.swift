//
//  DeleteDeletePresenter.swift
//  LikeTok
//
//  Created by Artem Holod on 28/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

final class DeletePresenter {
    private unowned let view: DeletePresenterOutput

    init(_ view: DeletePresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
     
    }

}

extension DeletePresenter: DeletePresenterInput {

}
