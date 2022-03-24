//
//  SettingsAssembler.swift
//  LikeTok
//
//  Created by Daniel on 23.03.22.
//

import Foundation

enum SettingsAssembler {
    static func createModule() -> SettingsViewController {
        let viewController = SettingsViewController()
        let presenter = SettingsPresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
