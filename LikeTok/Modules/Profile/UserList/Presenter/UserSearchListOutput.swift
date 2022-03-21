//
//  UserSearchListOutput.swift
//  LikeTok
//
//  Created by Daniel on 20.03.22.
//

import Foundation

protocol UserSearchListOutput: AnyObject {
    func setSubscriptions(models: [UserListDatum])
    func setSubscribers(models: [UserListDatum])
    func setFriends(models: [UserListDatum])
    func onFollowSuccess(_ following: Bool, uuid: String)
    func onFollowFailure(_ error: NetworkError)
}
