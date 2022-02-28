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
    func onFetchProfileDataSuccess(_ model: OtherProfileServerDatum)
    func onFetchProfileDataFailure(_ error: NetworkError)
    func onFollowSuccess(_ following: Bool, subscribersCount: Int)
    func onFollowFailure(_ error: NetworkError)
}
