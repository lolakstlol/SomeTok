//
//  OtherProfilePresenterOutput.swift
//  LikeTok
//
//  Created by Daniel on 20.02.22.
//

import Foundation

protocol OtherProfilePresenterOutput: AnyObject {
//    func onFetchOnboardingData(_ data: [OnboardingPage])
    func setupUI()
    func setAdvertisment(_ model: [FeedPost])
    func appendAdvertisment(_ model: [FeedPost])
    func onFetchFeedFailrue(_ error: NetworkError)
    func onFetchProfileDataSuccess(_ model: OtherProfileServerDatum)
    func onFetchProfileDataFailure(_ error: NetworkError)
    func reloadCollectionView()
    func onFollowSuccess(_ following: Bool, subscribersCount: Int)
    func onFollowFailure(_ error: NetworkError)
    func pushUsersList(_ viewController: UserSearchListViewController)
    func pushFeed(_ viewController: FeedViewViewController)
}