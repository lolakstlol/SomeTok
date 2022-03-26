//
//  UserSearchListAssembler.swift
//  LikeTok
//
//  Created by Daniel on 21.03.22.
//

import Foundation

enum UserSearchListAssembler {
    static func createModule(selectedSearchType: UserSearchTypes, baseController: ProfileType, uuid: String = String()) -> UserSearchListViewController {
        let viewController = UserSearchListViewController()
        let userListApiWorker = UserSearchListApiWorker()
        let userListOtherApiWorker = UserSearchListOtherApiWorker(uuid: uuid)
        let presenter = UserSearchListPresenter(viewController, selectedSearchType, baseController, userListApiWorker, userListOtherApiWorker)
        viewController.presenter = presenter
        return viewController
    }
}
