//
//  AboutPersonalPostAssembler.swift
//  LikeTok
//
//  Created by Daniel on 26.02.22.
//

import Foundation

enum AboutPersonalPostAssembler {
    static func createModule() -> AboutPersonalPostViewController {
        let viewController = AboutPersonalPostViewController()
        let presenter = AboutPersonalPostPresenter(viewController)
        viewController.presenter = presenter
        return viewController
    }
}
