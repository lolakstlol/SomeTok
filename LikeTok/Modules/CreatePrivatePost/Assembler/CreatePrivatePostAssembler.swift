//
//  CreatePrivatePostCreatePrivatePostAssembler.swift
//  LikeTok
//
//  Created by Artem Holod on 22/02/2022.
//  Copyright © 2022 LikeTok. All rights reserved.
//

import Foundation

enum CreatePrivatePostAssembler {
    static func createModule(video: Data, preview: Data) -> CreatePrivatePostViewController {
        let viewController = CreatePrivatePostViewController()
        let presenter = CreatePrivatePostPresenter(viewController,
                                                   video: video,
                                                   preview: preview)
        viewController.presenter = presenter
        return viewController
    }
}
