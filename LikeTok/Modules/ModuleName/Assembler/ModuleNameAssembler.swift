//
//  ModuleNameModuleNameAssembler.swift
//  LikeTok
//
//  Created by Artem Holod on 18/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum ModuleNameAssembler {
    static func createModule() -> ModuleNameViewController {
        let viewController = ModuleNameViewController()
        let presenter = ModuleNamePresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
