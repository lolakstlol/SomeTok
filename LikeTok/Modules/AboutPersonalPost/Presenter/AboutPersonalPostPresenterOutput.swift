//
//  AboutPersonalPostPresenterOutput.swift
//  LikeTok
//
//  Created by Daniel on 26.02.22.
//

import Foundation

protocol AboutPersonalPostPresenterOutput: AnyObject {
//    func onFetchOnboardingData(_ data: [OnboardingPage])
    func setupUI()
    func animatedPresent()
    func animatedDismiss()
    func onNextButtonTap()
}
