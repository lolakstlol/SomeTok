//
//  UserSearchListPresenter.swift
//  LikeTok
//
//  Created by Daniel on 20.03.22.
//
import Foundation
import UIKit

struct UserSearchPaginationModel {
    var page: Int
    var lastpredict: String?
}

enum UserSearchTypes {
    case subscriptions
    case subscribers
    case friends
}

final class UserSearchListPresenter {
    private unowned let view: UserSearchListOutput
    private let userListApiWorker: UserSearchListApiWorker = UserSearchListApiWorker()
    private let profileApiWorker: ProfileNetworkServiceProtocol = ProfileNetworkService()
    private var selectedType: UserSearchTypes
    
    init(_ view: UserSearchListOutput, type: UserSearchTypes) {
        self.view = view
        self.selectedType = type
    }

    func viewDidLoad() {
        loadSubscribers()
        loadSubscriptions()
        loadFriends()
    }
    
    func loadSubscribers() {
        userListApiWorker.searchSubscribers { result in
            switch result {
            case .success(let subscibers):
                self.view.setSubscribers(models: subscibers?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadFriends() {
        userListApiWorker.searchFriends { result in
            switch result {
            case .success(let friends):
                self.view.setFriends(models: friends?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadSubscriptions() {
        userListApiWorker.searchSubscriptions { result in
            switch result {
            case .success(let subscriptions):
                self.view.setSubscriptions(models: subscriptions?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension UserSearchListPresenter: UserSearchListInput {
    func load(_ type: UserSearchTypes) {
        switch type {
        case .subscribers:
            loadSubscribers()
        case .subscriptions:
            loadSubscriptions()
        case .friends:
            loadFriends()
        }
    }
    
    func followButtonTap(_ uuid: String) {
        profileApiWorker.follow(uuid) { [weak self] result in
            switch result {
            case .success(let followModel):
                if let following = followModel?.data.following {
                    self?.view.onFollowSuccess(following, uuid: uuid)
                } else {
                    self?.view.onFollowFailure(.noData)
                }
            
            case .failure(let error):
                self?.view.onFollowFailure(error)
            }
        }
    }
}
