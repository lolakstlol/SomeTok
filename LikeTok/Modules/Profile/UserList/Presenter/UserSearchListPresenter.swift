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

enum ProfileType {
    case my
    case other
}

enum UserSearchTypes {
    case subscriptions
    case subscribers
    case friends
}

final class UserSearchListPresenter {
    private unowned let view: UserSearchListOutput
    private let userListApiWorker: UserSearchListApiWorker
    private let userListOtherApiWorker: UserSearchListOtherApiWorker
    private var selectedType: UserSearchTypes
    private var baseController: ProfileType
    
    private var subscribersCursor: String?
    private var subscriptionsCursor: String?
    private var friendsCursor: String?
    
    private var isReloadingSubscribersPage = false
    private var isReloadingSubscriptionsPage = false
    private var isReloadingFriendsPage = false
    
    init(_ view: UserSearchListOutput, _ selectedType: UserSearchTypes, _ baseController: ProfileType, _ userListApiWorker: UserSearchListApiWorker, _ userListOtherApiWorker: UserSearchListOtherApiWorker) {
        self.view = view
        self.selectedType = selectedType
        self.baseController = baseController
        self.userListApiWorker = userListApiWorker
        self.userListOtherApiWorker = userListOtherApiWorker
    }
    
    func viewDidLoad() {
        view.setupUI(baseController)
        loadSubscribers()
        loadSubscriptions()
        loadFriends()
        view.setupInitialType(selectedType)
    }
    
    func viewWillAppear() {

    }
}

private extension UserSearchListPresenter {
    func loadSubscribers() {
        userListApiWorker.loadSubscribers { [weak self] result in
            switch result {
            case .success(let subscibers):
                self?.subscribersCursor = subscibers?.data.meta.cursor
                self?.view.setSubscribers(models: subscibers?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadFriends() {
        userListApiWorker.loadFriends { [weak self] result in
            switch result {
            case .success(let friends):
                self?.friendsCursor = friends?.data.meta.cursor
                self?.view.setFriends(models: friends?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadSubscriptions() {
        userListApiWorker.loadSubscriptions { [weak self] result in
            switch result {
            case .success(let subscriptions):
                self?.subscriptionsCursor = subscriptions?.data.meta.cursor
                self?.view.setSubscriptions(models: subscriptions?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadMoreSubscribers() {
        guard let cursor = subscribersCursor, !isReloadingSubscribersPage else {
            return
        }
        isReloadingSubscribersPage = true
        userListApiWorker.searchSubscribers(cursor: cursor) { [weak self] result in
            switch result {
            case .success(let subscibers):
                self?.subscribersCursor = subscibers?.data.meta.cursor
                self?.view.appendSubscribers(models: subscibers?.data.data ?? [])
                self?.isReloadingSubscribersPage = false
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadMoreFriends() {
        guard let cursor = friendsCursor, !isReloadingFriendsPage  else {
            return
        }
        isReloadingFriendsPage = true
        userListApiWorker.searchFriends(cursor: cursor) { [weak self] result in
            switch result {
            case .success(let friends):
                self?.friendsCursor = friends?.data.meta.cursor
                self?.view.appendFriends(models: friends?.data.data ?? [])
                self?.isReloadingFriendsPage = false
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadMoreSubscriptions() {
        guard let cursor = subscriptionsCursor, !isReloadingSubscriptionsPage else {
            return
        }
        isReloadingSubscriptionsPage = true
        userListApiWorker.searchSubscriptions(cursor: cursor) { [weak self] result in
            switch result {
            case .success(let subscriptions):
                self?.subscriptionsCursor = subscriptions?.data.meta.cursor
                self?.view.appendSubscriptions(models: subscriptions?.data.data ?? [])
                self?.isReloadingSubscriptionsPage = false
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchSubscribers(predicate: String) {
        userListApiWorker.searchSubscribers(predicate: predicate) { [weak self] result in
            switch result {
            case .success(let subscibers):
                self?.subscribersCursor = subscibers?.data.meta.cursor
                self?.view.setSubscribers(models: subscibers?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchFriends(predicate: String) {
        userListApiWorker.searchFriends(predicate: predicate) { [weak self] result in
            switch result {
            case .success(let friends):
                self?.friendsCursor = friends?.data.meta.cursor
                self?.view.setFriends(models: friends?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchSubscriptions(predicate: String) {
        userListApiWorker.searchSubscriptions(predicate: predicate) { [weak self] result in
            switch result {
            case .success(let subscriptions):
                self?.subscriptionsCursor = subscriptions?.data.meta.cursor
                self?.view.setSubscriptions(models: subscriptions?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    

    func loadSubscribersOther() {
        userListOtherApiWorker.loadSubscribersOther { [weak self] result in
            switch result {
            case .success(let subscibers):
                self?.subscribersCursor = subscibers?.data.meta.cursor
                self?.view.setSubscribers(models: subscibers?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadSubscriptionsOther() {
        userListOtherApiWorker.loadSubscriptionsOther { [weak self] result in
            switch result {
            case .success(let subscriptions):
                self?.subscriptionsCursor = subscriptions?.data.meta.cursor
                self?.view.setSubscriptions(models: subscriptions?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadMoreSubscribersOther() {
        guard let cursor = subscribersCursor, !isReloadingSubscribersPage else {
            return
        }
        isReloadingSubscribersPage = true
        userListOtherApiWorker.searchSubscribers(cursor: cursor) { [weak self] result in
            switch result {
            case .success(let subscibers):
                self?.subscribersCursor = subscibers?.data.meta.cursor
                self?.view.appendSubscribers(models: subscibers?.data.data ?? [])
                self?.isReloadingSubscribersPage = false
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadMoreSubscriptionsOther() {
        guard let cursor = subscriptionsCursor, !isReloadingSubscriptionsPage else {
            return
        }
        isReloadingSubscriptionsPage = true
        userListOtherApiWorker.searchSubscriptions(cursor: cursor) { [weak self] result in
            switch result {
            case .success(let subscriptions):
                self?.subscriptionsCursor = subscriptions?.data.meta.cursor
                self?.view.appendSubscriptions(models: subscriptions?.data.data ?? [])
                self?.isReloadingSubscriptionsPage = false
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchSubscribersOther(predicate: String) {
        userListOtherApiWorker.searchSubscribers(predicate: predicate) { [weak self] result in
            switch result {
            case .success(let subscibers):
                self?.subscribersCursor = subscibers?.data.meta.cursor
                self?.view.setSubscribers(models: subscibers?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchSubscriptionsOther(predicate: String) {
        userListOtherApiWorker.searchSubscriptions(predicate: predicate) { [weak self] result in
            switch result {
            case .success(let subscriptions):
                self?.subscriptionsCursor = subscriptions?.data.meta.cursor
                self?.view.setSubscriptions(models: subscriptions?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension UserSearchListPresenter: UserSearchListInput {
    
    func updateSelectedType(_ type: UserSearchTypes) {
        selectedType = type
    }
    
    func loadMore(_ type: UserSearchTypes) {
        switch type {
        case .subscribers:
            baseController == .my ? loadMoreSubscribers() : loadMoreSubscribersOther()
        case .subscriptions:
            baseController == .my ? loadMoreSubscriptions() : loadMoreSubscriptionsOther()
        case .friends:
            loadMoreFriends()
        }
    }
    
    func load(_ predicate: String, type: UserSearchTypes) {
        switch type {
        case .subscribers:
            baseController == .my ? searchSubscribers(predicate: predicate) : searchSubscribersOther(predicate: predicate)
        case .subscriptions:
            baseController == .my ? searchSubscriptions(predicate: predicate) : searchSubscriptionsOther(predicate: predicate)
        case .friends:
            searchFriends(predicate: predicate)
        }
    }
    
    func load(_ type: UserSearchTypes) {
        switch type {
        case .subscribers:
            baseController == .my ? loadSubscribers() : loadSubscribersOther()
        case .subscriptions:
            baseController == .my ? loadSubscriptions() : loadSubscriptionsOther()
        case .friends:
            loadFriends()
        }
    }
    
    func followButtonTap(_ uuid: String) {
        OtherProfileNetworkService(uuid: uuid).follow { [weak self] result in
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
