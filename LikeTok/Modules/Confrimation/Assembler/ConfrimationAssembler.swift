//
//  ConfrimationAssembler.swift
//  LikeTok
//
//  Created by Daniel on 24.03.22.
//

import Foundation

enum ConfrimationAssembler {
    static func createModule(model: ConfrimationModel) -> ConfrimationViewController {
        let viewController = ConfrimationViewController()
        let presenter = ConfrimationPresenter(viewController, model)
        viewController.presenter = presenter
        return viewController
    }
}
