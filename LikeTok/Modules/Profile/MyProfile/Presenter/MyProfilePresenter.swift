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
    private var networkService: ProfileNetworkServiceProtocol
    private var model: ProfileModel?
    
    private var advertismentCursor: String?
    private var personalCursor: String?
    
    init(_ view: MyProfilePresenterOutput, _ networkService: ProfileNetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
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
        networkService.settings { [weak self] result in
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
        
//        DispatchQueue.main.async(group: dispatchGroup, qos: .userInitiated) {
            dispatchGroup.enter()
            self.networkService.feedPersonal { result in
                switch result {
                case .success(let model):
                    self.personalCursor = model?.data.meta.cursor
                    self.view.setPersonalFeed(model?.data.data ?? [])
                    dispatchGroup.leave()
                case .failure(let error):
                    self.view.onFetchFeedFailrue(error)
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.enter()
            self.networkService.feedAdvertisment { result in
                switch result {
                case .success(let model):
                    self.advertismentCursor = model?.data.meta.cursor
                    self.view.setAdvertismentFeed(model?.data.data ?? [])
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
}

extension MyProfilePresenter: MyProfilePresenterInput {
    
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
}

