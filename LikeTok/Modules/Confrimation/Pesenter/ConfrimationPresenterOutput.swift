//
//  ConfrimationPresenterOutput.swift
//  LikeTok
//
//  Created by Daniel on 23.03.22.
//

import Foundation

protocol ConfrimationPresenterOutput: AnyObject {
//    func onFetchOnboardingData(_ data: [OnboardingPage])
    func setupUI(_ model: ConfrimationModel)
    func animatedPresent()
    func animatedDismiss(completion: (() -> Void)?)
}
