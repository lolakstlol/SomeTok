//
//  CreatePrivatePostCreatePrivatePostPresenterOutput.swift
//  LikeTok
//
//  Created by Artem Holod on 22/02/2022.
//  Copyright © 2022 LikeTok. All rights reserved.
//

import Foundation

protocol CreatePrivatePostPresenterOutput: AnyObject {
    func setupPreview(preview: Data)
    func setupView()
}
