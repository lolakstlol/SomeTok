//
//  VideoUploadPersonalFinalPresenter.swift
//  LikeTok
//
//  Created by Daniel on 24.02.22.
//

import Foundation
import UIKit

final class VideoUploadAdvertismentFinalPresenter {
    
    private unowned let view: VideoUploadAdvertismentFinalPresenterOutput
    private var isKeyboardAppears: Bool = false
    private var preview: Data
    private var video: Data
    
    init(_ view: VideoUploadAdvertismentFinalPresenterOutput, preview: Data, video: Data) {
        self.view = view
        self.preview = preview
        self.video = video
    }

    func viewDidLoad() {
        view.setupUI(preview: preview)
    }

}

extension VideoUploadAdvertismentFinalPresenter: VideoUploadAdvertismentFinalPresenterInput {
    
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
    
    func publishButtonTap(description: String) {
        CameraApiWorker().createPost(true, title: description) {  response in
            switch response {
            case .success(let result):
                let uuid = result?.data.uuid ?? "1"
                CameraApiWorker.upload(self.video, with: "video", fileExtension: "mp4", to: "\(API.server)/user/post/\(uuid)/video/upload", preview: self.preview) { [weak self] result in
                    switch result {
                    case .success:
                        CameraApiWorker().publishPost(uuid) { result in
                            self?.view.onPublishPost()
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

}
