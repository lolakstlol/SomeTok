//
//  VideoUploadPersonalFinalPresenterOutput.swift
//  LikeTok
//
//  Created by Daniel on 24.02.22.
//

import Foundation

protocol VideoUploadAdvertismentFinalPresenterOutput: AnyObject {
//    func onFetchOnboardingData(_ data: [OnboardingPage])
    func setupUI(preview: Data)
    func didPublishPost()
}
