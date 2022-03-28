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
    func setPersonalFeed(_ models: [FeedPost])
    func setAdvertismentFeed(_ models: [FeedPost])
    func appendPersonal(_ model: [FeedPost])
    func appendAdvertisment(_ model: [FeedPost])
    func reloadCollectionView()
    func onFetchFeedFailrue(_ error: NetworkError)
    func onFetchProfileDataSuccess(_ model: ProfileModel)
    func onFetchProfileDataFailure(_ error: NetworkError)
    func onEditButtonTap(_ viewController: EditProfileViewController)
    func pushFeed(_ viewController: FeedViewViewController)
}
