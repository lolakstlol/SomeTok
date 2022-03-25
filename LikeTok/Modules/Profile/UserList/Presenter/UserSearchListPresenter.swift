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

struct BaseProfile {
    let baseProfileType: ProfileType
    let uuid: String?
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
    private var baseControllerModel: BaseProfile
    
    private var subscribersCursor: String?
    private var subscriptionsCursor: String?
    private var friendsCursor: String?
    
    private var isReloadingSubscribersPage = false
    private var isReloadingSubscriptionsPage = false
    private var isReloadingFriendsPage = false
    
    init(_ view: UserSearchListOutput, selectedType: UserSearchTypes, baseControllerModel: BaseProfile) {
        self.view = view
        self.selectedType = selectedType
        self.baseControllerModel = baseControllerModel
    }

    func viewDidLoad() {
        view.setupUI(baseControllerModel.baseProfileType)
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
    
    
    
    func loadSubscribers(uuid: String?) {
        guard let uuid = uuid else {
            return
        }
        userListApiWorker.loadSubscribersOther(uuid: uuid) { [weak self] result in
            switch result {
            case .success(let subscibers):
                self?.subscribersCursor = subscibers?.data.meta.cursor
                self?.view.setSubscribers(models: subscibers?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadSubscriptions(uuid: String?) {
        guard let uuid = uuid else {
            return
        }
        userListApiWorker.loadSubscriptionsOther(uuid: uuid) { [weak self] result in
            switch result {
            case .success(let subscriptions):
                self?.subscriptionsCursor = subscriptions?.data.meta.cursor
                self?.view.setSubscriptions(models: subscriptions?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadMoreSubscribers(uuid: String?) {
        guard let cursor = subscribersCursor, let uuid = uuid, !isReloadingSubscribersPage else {
            return
        }
        isReloadingSubscribersPage = true
        userListApiWorker.searchSubscribers(cursor: cursor, uuid: uuid) { [weak self] result in
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
    
    func loadMoreSubscriptions(uuid: String?) {
        guard let cursor = subscriptionsCursor, let uuid = uuid, !isReloadingSubscriptionsPage else {
            return
        }
        isReloadingSubscriptionsPage = true
        userListApiWorker.searchSubscriptions(cursor: cursor, uuid: uuid) { [weak self] result in
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
    
    func searchSubscribers(predicate: String, uuid: String?) {
        guard let uuid = uuid else {
            return
        }
        userListApiWorker.searchSubscribers(predicate: predicate, uuid: uuid) { [weak self] result in
            switch result {
            case .success(let subscibers):
                self?.subscribersCursor = subscibers?.data.meta.cursor
                self?.view.setSubscribers(models: subscibers?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchSubscriptions(predicate: String, uuid: String?) {
        guard let uuid = uuid else {
            return
        }
        userListApiWorker.searchSubscriptions(predicate: predicate, uuid: uuid) { [weak self] result in
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
            baseControllerModel.baseProfileType == .my ? loadMoreSubscribers() : loadMoreSubscribers(uuid: baseControllerModel.uuid)
        case .subscriptions:
            baseControllerModel.baseProfileType == .my ? loadMoreSubscriptions() : loadMoreSubscriptions(uuid: baseControllerModel.uuid)
        case .friends:
            loadMoreFriends()
        }
    }
    
    func load(_ predicate: String, type: UserSearchTypes) {
        switch type {
        case .subscribers:
            baseControllerModel.baseProfileType == .my ? searchSubscribers(predicate: predicate) : searchSubscribers(predicate: predicate, uuid: baseControllerModel.uuid)
        case .subscriptions:
            baseControllerModel.baseProfileType == .my ? searchSubscriptions(predicate: predicate) : searchSubscriptions(predicate: predicate, uuid: baseControllerModel.uuid)
        case .friends:
            searchFriends(predicate: predicate)
        }
    }
    
    func load(_ type: UserSearchTypes) {
        switch type {
        case .subscribers:
            baseControllerModel.baseProfileType == .my ? loadSubscribers() : loadSubscribers(uuid: baseControllerModel.uuid)
        case .subscriptions:
            baseControllerModel.baseProfileType == .my ? loadSubscriptions() : loadSubscriptions(uuid: baseControllerModel.uuid)
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
