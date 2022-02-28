//
//  CreatePrivatePostCreatePrivatePostPresenterInput.swift
//  LikeTok
//
//  Created by Artem Holod on 22/02/2022.
//  Copyright © 2022 LikeTok. All rights reserved.
//

import Foundation

protocol CreatePrivatePostPresenterInput: BasePresenting {
    func uploadVideo(with description: String)
}
