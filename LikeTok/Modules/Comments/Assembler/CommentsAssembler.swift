//
//  CommentsAssembler.swift
//  LikeTok
//
//  Created by Daniel on 22.01.22.
//

import Foundation

final class CommentsAssembler {
    static func createModule(commentsService: CommentsApiWorkerProtocol = CommentsApiWorker(), uuid: String) -> CommentsViewController {
        let viewController = CommentsViewController()
        let presenter = CommentsPresenter(viewController, commentsService, uuid)
        viewController.presenter = presenter
        return viewController
    }
}
