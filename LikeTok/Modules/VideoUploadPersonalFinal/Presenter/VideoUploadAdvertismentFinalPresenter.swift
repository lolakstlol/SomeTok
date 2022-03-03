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
  
    func publishButtonTap(description: String, tag: String?, category: String?) {
        let hashtag: String = tag ?? ""
        let uploadCategory: String = category ?? ""
        CameraApiWorker().createPost(true, title: description, tag: hashtag, category: uploadCategory) {  response in
            switch response {
            case .success(let result):
                let uuid = result?.data.uuid ?? "1"
                CameraApiWorker.upload(self.video, with: "video", fileExtension: "mp4", to: "\(API.server)/user/post/\(uuid)/video/upload", preview: self.preview) { [weak self] result in
                    switch result {
                    case .success:
                        CameraApiWorker().publishPost(uuid) { result in
                            self?.view.didPublishPost()
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
