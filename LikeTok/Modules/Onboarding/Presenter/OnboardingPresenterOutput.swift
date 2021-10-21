//
//  OnboardingOnboardingPresenterOutput.swift
//  LikeTok
//
//  Created by Danik on 20/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

protocol OnboardingPresenterOutput: AnyObject {
    func onFetchOnboardingData(_ data: [OnboardingPage])
}
