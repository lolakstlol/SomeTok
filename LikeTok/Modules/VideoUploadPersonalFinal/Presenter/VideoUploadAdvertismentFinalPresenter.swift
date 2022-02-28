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
    func publishButtonTap() {
        
    }

}
