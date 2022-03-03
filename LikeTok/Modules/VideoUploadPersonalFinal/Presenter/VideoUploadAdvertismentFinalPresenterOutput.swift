//
//  VideoUploadPersonalFinalPresenterOutput.swift
//  LikeTok
//
//  Created by Daniel on 24.02.22.
//

import UIKit

protocol VideoUploadAdvertismentFinalPresenterOutput: AnyObject {
//    func onFetchOnboardingData(_ data: [OnboardingPage])
    func setupUI(preview: Data)
    func onShowKeyboard(_ insets: UIEdgeInsets)
    func onHideKeyboard(_ insets: UIEdgeInsets)
    func onPublishPost()
}
