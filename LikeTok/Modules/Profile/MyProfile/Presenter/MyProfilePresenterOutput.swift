//
//  MyProfilePresenterOutput.swift
//  LikeTok
//
//  Created by Daniel on 17.02.22.
//

import Foundation

protocol MyProfilePresenterOutput: AnyObject {
//    func onFetchOnboardingData(_ data: [OnboardingPage])
    func setupUI()
    func onFetchProfileDataSuccess(_ model: ProfileModel)
    func onFetchProfileDataFailure(_ error: NetworkError)
    func onEditButtonTap(_ controller: EditProfileViewController)
}
