//
//  CreatePrivatePostCreatePrivatePostPresenter.swift
//  LikeTok
//
//  Created by Artem Holod on 22/02/2022.
//  Copyright © 2022 LikeTok. All rights reserved.
//

import Foundation

final class CreatePrivatePostPresenter {
    private unowned let view: CreatePrivatePostPresenterOutput
    private let videoData: Data
    private let preview: Data

    init(_ view: CreatePrivatePostPresenterOutput,
         video: Data,
         preview: Data) {
        self.view = view
        self.videoData = video
        self.preview = preview
    }

    func viewDidLoad() {
        view.setupView()
        view.setupPreview(preview: preview)
    }

}

extension CreatePrivatePostPresenter: CreatePrivatePostPresenterInput {
    func uploadVideo(with description: String) {
        
    }
}
