//
//  MyProfilePresenter.swift
//  LikeTok
//
//  Created by Daniel on 17.02.22.
//

import Foundation
import UIKit

final class MyProfilePresenter {
    
    private unowned let view: MyProfilePresenterOutput
    private var profileNetwork: ProfileNetworkServiceProtocol
    private var profileFeedNetwork: FeedServiceProtocol
    private var model: ProfileModel?
    
    private var advertismentCursor: String?
    private var personalCursor: String?
    
    private var isLoadingAdvertismentPage: Bool = false
    private var isLoadingPersonalPage: Bool = false
    
    init(_ view: MyProfilePresenterOutput, _ networkService: ProfileNetworkServiceProtocol, _ feedNetworkService: FeedServiceProtocol) {
        self.view = view
        self.profileNetwork = networkService
        self.profileFeedNetwork = feedNetworkService
    }

    func viewDidLoad() {
    }
    
    func viewWillAppear() {
        view.setupUI()
        fetchProfileData()
        fetchFeedData()
    }

}

private extension MyProfilePresenter {
    func fetchProfileData() {
        profileNetwork.settings { [weak self] result in
            switch result {
            case .success(let model):
                if let serverModel = model?.data.data {
                    let model = ToProfileModel(serverModel).transform
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
    
    func fetchFeedData() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        self.profileFeedNetwork.getInitialFeed(with: .zero, type: .personal) { result in
            switch result {
            case .success(let model):
                self.personalCursor = model.data.meta.cursor
                self.view.setPersonalFeed(model.data.data)
                dispatchGroup.leave()
            case .failure(let error):
                self.view.onFetchFeedFailrue(error)
                dispatchGroup.leave()
            }
        }
            
        dispatchGroup.enter()
        self.profileFeedNetwork.getInitialFeed(with: .zero, type: .advertisment) { result in
            switch result {
            case .success(let model):
                self.advertismentCursor = model.data.meta.cursor
                self.view.setAdvertismentFeed(model.data.data)
                dispatchGroup.leave()
            case .failure(let error):
                self.view.onFetchFeedFailrue(error)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.view.reloadCollectionView()
        }
    }
    
    func fetchMorePersonalFeed() {
        guard let cursor = personalCursor, !isLoadingPersonalPage else {
            return
        }
        isLoadingPersonalPage = true
        profileFeedNetwork.getFeed(with: .zero, cursor: cursor, type: .personal) { result in
            switch result {
            case .success(let model):
                self.personalCursor = model.data.meta.cursor
                self.view.appendPersonal(model.data.data)
                self.isLoadingPersonalPage = false
            case .failure(let error):
                self.view.onFetchFeedFailrue(error)
                self.isLoadingPersonalPage = false
            }
        }
    }
    
    func fetchMoreAdvertismentFeed() {
        guard let cursor = advertismentCursor, !isLoadingAdvertismentPage else {
            return
        }
        isLoadingAdvertismentPage = true
        profileFeedNetwork.getFeed(with: .zero, cursor: cursor, type: .advertisment) { result in
            switch result {
            case .success(let model):
                self.advertismentCursor = model.data.meta.cursor
                self.view.appendAdvertisment(model.data.data)
                self.isLoadingAdvertismentPage = false
            case .failure(let error):
                self.view.onFetchFeedFailrue(error)
                self.isLoadingAdvertismentPage = false
            }
        }
    }
    
}

extension MyProfilePresenter: MyProfilePresenterInput {
    
    func didTapVideo(_ collectionType: FeedViewEnterOption, _ dataSourse: [FeedPost], index: Int) {
        var cursor = String()
        switch collectionType {
        case .personal:
            cursor = personalCursor ?? ""
        case .advertisment:
            cursor = advertismentCursor ?? ""
        default:
            break
        }
        let feedViewController = FeedViewAssembler.createModule(type: collectionType, feedService: FeedProfileNetworkService(), collectionManager: FeedCollectionManager(), initialDataSourse: dataSourse, initialCursor: cursor, initialIndex: index)
        view.pushFeed(feedViewController)
    }
    
    func editButtonTap() {
        guard let model = model else {
            return
        }
        let editModel = EditProfileModel(avatar: model.photo.preview,
                                         name: model.name,
                                         username: model.username,
                                         email: model.email,
                                         phone: model.phone,
                                         country: model.location.country ?? "",
                                         city: model.location.city,
                                         description: model.description ?? "")
        let controller = EditProfileAssembler.createModule(editModel)
        view.onEditButtonTap(controller)
    }
    
    func loadMore(_ type: FeedViewEnterOption) {
        switch type {
        case .personal:
            fetchMorePersonalFeed()
        case .advertisment:
            fetchMoreAdvertismentFeed()
        default:
            break
        }
    }
}

