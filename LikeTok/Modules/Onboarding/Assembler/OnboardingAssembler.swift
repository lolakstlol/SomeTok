//
//  OnboardingOnboardingAssembler.swift
//  LikeTok
//
//  Created by Danik on 20/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

enum OnboardingAssembler {
    
    static func createModule(onCompleteOnboarding: @escaping (() -> ())) -> OnboardingViewController {
        let viewController = OnboardingViewController()
        let presenter = OnboardingPresenter(viewController)
        presenter.onCompleteOnboarding = onCompleteOnboarding
        viewController.presenter = presenter
        return viewController
    }
}
