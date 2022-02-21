//
//  OtherProfilePresenter.swift
//  LikeTok
//
//  Created by Daniel on 20.02.22.
//

import Foundation

final class OtherProfilePresenter {
    
    private unowned let view: OtherProfilePresenterOutput
    private var networkService: ProfileNetworkServiceProtocol
    private var uuid: String
    
    private var model: ProfileModel?
    
    init(_ view: OtherProfilePresenterOutput, _ networkService: ProfileNetworkServiceProtocol, _ uuid: String) {
        self.view = view
        self.networkService = networkService
        self.uuid = uuid
    }

    func viewDidLoad() {
        view.setupUI()
        fetchProfileData()
    }

}

private extension OtherProfilePresenter {
    func fetchProfileData() {
        networkService.user(uuid) { [weak self] result in
            switch result {
            case .success(let model):
                if let model = model?.data.data {
                    self?.view.onFetchProfileDataSuccess(model)
                } else {
                    self?.view.onFetchProfileDataFailure(.noData)
                }
            
            case .failure(let error):
                self?.view.onFetchProfileDataFailure(error)
            }
        }
    }
}

extension OtherProfilePresenter: OtherProfilePresenterInput {
    
}
