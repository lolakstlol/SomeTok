//
//  OtherProfilePresenter.swift
//  LikeTok
//
//  Created by Daniel on 20.02.22.
//

import Foundation

final class OtherProfilePresenter {
    
    private unowned let view: OtherProfilePresenterOutput
    private var profileNetworkService: OtherProfileNetworkServiceProtocol
    private var feedNetworkService: FeedServiceProtocol
    private var uuid: String
    private var advertismentCursor: String?
    
    private var isLoadingAdvertismentPage: Bool = false
    
    private var model: OtherProfileServerDatum?
    
    init(_ view: OtherProfilePresenterOutput, _ profileNetworkService: OtherProfileNetworkServiceProtocol, _ feedNetworkService: FeedServiceProtocol,_ uuid: String) {
        self.view = view
        self.profileNetworkService = profileNetworkService
        self.feedNetworkService = feedNetworkService
        self.uuid = uuid
    }

    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        fetchProfileData()
        fetchUserFeed()
        view.setupUI()
    }
}

private extension OtherProfilePresenter {
    func fetchProfileData() {
        profileNetworkService.user { [weak self] result in
            switch result {
            case .success(let model):
                if let model = model?.data.data {
                    self?.model = model
                    self?.view.onFetchProfileDataSuccess(model)
                } else {
                    self?.view.onFetchProfileDataFailure(.noData)
                }
            
            case .failure(let error):
                self?.view.onFetchProfileDataFailure(error)
            }
        }
    }
    
    func fetchUserFeed() {
        feedNetworkService.getInitialFeed(with: .zero, type: .advertisment) { result in
            switch result {
            case .success(let model):
                self.advertismentCursor = model.data.meta.cursor
                self.view.setAdvertisment(model.data.data)
                self.view.reloadCollectionView()
            case .failure(let error):
                self.view.onFetchFeedFailrue(error)
            }
        }
    }
    
    func fetchUserFeedMore() {
        guard let cursor = advertismentCursor, !isLoadingAdvertismentPage else {
            return
        }
        isLoadingAdvertismentPage = true
        feedNetworkService.getFeed(with: .zero, cursor: cursor, type: .advertisment) { result in
            switch result {
            case .success(let model):
                self.advertismentCursor = model.data.meta.cursor
                self.view.appendAdvertisment(model.data.data)
                self.isLoadingAdvertismentPage = false
            case .failure(let error):
                self.view.onFetchFeedFailrue(error)
            }
        }
    }
    
}

extension OtherProfilePresenter: OtherProfilePresenterInput {
    func didTapVideo(_ collectionType: FeedViewEnterOption, _ dataSourse: [FeedPost], index: Int) {
        var cursor = String()
        switch collectionType {
        case .advertisment:
            cursor = advertismentCursor ?? ""
        default:
            break
        }
        let feedViewController = FeedViewAssembler.createModule(type: collectionType, feedService: FeedOtherNetworkService(uuid: uuid), collectionManager: FeedCollectionManager(), initialDataSourse: dataSourse, initialCursor: cursor, initialIndex: index)
        view.pushFeed(feedViewController)
    }

    func openSubscibersList() {
        let userListViewController = UserSearchListAssembler.createModule(selectedSearchType: .subscribers, baseController: .other, uuid: uuid)
        userListViewController.hidesBottomBarWhenPushed = true
        view.pushUsersList(userListViewController)
    }
    
    func openSubsciptionsList() {
        let userListViewController = UserSearchListAssembler.createModule(selectedSearchType: .subscriptions, baseController: .other, uuid: uuid)
        userListViewController.hidesBottomBarWhenPushed = true
        view.pushUsersList(userListViewController)
    }
    
    func followButtonTap() {
        profileNetworkService.follow { [weak self] result in
            switch result {
            case .success(let followModel):
                if let following = followModel?.data.following {
                    let subscribersCount = self?.model?.subscribers ?? 0
                    let newSubscribersCount = following ? subscribersCount + 1 : subscribersCount - 1
                    self?.model?.subscribers = newSubscribersCount
                    self?.view.onFollowSuccess(following, subscribersCount: newSubscribersCount)
                } else {
                    self?.view.onFollowFailure(.noData)
                }
            
            case .failure(let error):
                self?.view.onFollowFailure(error)
            }
        }
    }
    
    func loadMore(_ type: FeedViewEnterOption) {
        fetchUserFeedMore()
    }
}