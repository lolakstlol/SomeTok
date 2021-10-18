//
//  ModuleNameModuleNamePresenter.swift
//  LikeTok
//
//  Created by Artem Holod on 18/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

final class ModuleNamePresenter {
    private unowned let view: ModuleNamePresenterOutput

    init(_ view: ModuleNamePresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
     
    }

}

extension ModuleNamePresenter: ModuleNamePresenterInput {

}
