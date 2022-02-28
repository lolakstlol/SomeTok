//
//  CreatePrivatePostCreatePrivatePostPresenter.swift
//  LikeTok
//
//  Created by Artem Holod on 22/02/2022.
//  Copyright © 2022 LikeTok. All rights reserved.
//

import UIKit

final class CreatePrivatePostPresenter {
    private unowned let view: CreatePrivatePostPresenterOutput
    private var isKeyboardAppears: Bool = false
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
        CameraApiWorker().createPost(false, title: description) { response in
            switch response {
            case .success(let result):
                let uuid = result?.data.uuid ?? "1"
                CameraApiWorker.upload(self.videoData, with: "video", fileExtension: "mp4", to: "\(API.server)/user/post/\(uuid)/video/upload", preview: self.preview) { result in
                    switch result {
                    case .success:
                        CameraApiWorker().publishPost(uuid) { result in
                            self.view.didPublishPost()
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showKeyboard(_ info: KeyboardObserver.KeyboardInfo) {
        if !isKeyboardAppears {
            let kbSize = info.keyboardBounds
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
            isKeyboardAppears = true
            view.onShowKeyboard(insets)
        }
    }
    
    func hideKeyboard() {
        if isKeyboardAppears {
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            isKeyboardAppears = false
            view.onHideKeyboard(insets)
        }
    }
}
