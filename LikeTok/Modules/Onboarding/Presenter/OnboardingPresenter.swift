//
//  OnboardingOnboardingPresenter.swift
//  LikeTok
//
//  Created by Danik on 20/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation
import UIKit

final class OnboardingPresenter {
    private unowned let view: OnboardingPresenterOutput

    var onCompleteOnboarding: (() -> ())?
    
    let data: [OnboardingPage] = [OnboardingPage(image: Assets.Onboarding.onb1.image, title: "Делись событиями из жизни ", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore."),
                                  OnboardingPage(image: Assets.Onboarding.onb2.image, title: "Зарабатывай деньги", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore."),
                                  OnboardingPage(image: Assets.Onboarding.onb3.image, title: "Беседуй с друзьями", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.")]
    
    init(_ view: OnboardingPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
        view.onFetchOnboardingData(data)
    }

}

extension OnboardingPresenter: OnboardingPresenterInput {
    func completeOnboarding() {
        onCompleteOnboarding?()
    }

}
