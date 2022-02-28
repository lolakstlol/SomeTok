//
//  VideoUploadPersonalFinalAssembler.swift
//  LikeTok
//
//  Created by Daniel on 24.02.22.
//

import Foundation

enum VideoUploadAdvertismentFinalAssembler {
    static func createModule(preview: Data, video: Data) -> VideoUploadAdvertismentFinalViewController {
        let viewController = VideoUploadAdvertismentFinalViewController()
        let presenter = VideoUploadAdvertismentFinalPresenter(viewController, preview: preview, video: video)
        viewController.presenter = presenter
        return viewController
    }
}
