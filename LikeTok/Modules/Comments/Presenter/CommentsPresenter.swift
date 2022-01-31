//
//  CommentsPresenter.swift
//  LikeTok
//
//  Created by Daniel on 21.01.22.
//

import Foundation

final class CommentsPresenter {
    
    private unowned let view: CommentsPresenterOutput
    private var commentsService: CommentsApiWorkerProtocol?
    private var uuid = String()

    init(_ view: CommentsPresenterOutput, _ commentsService: CommentsApiWorkerProtocol, _ uuid: String) {
        self.view = view
        self.commentsService = commentsService
        self.uuid = uuid
    }

    func viewDidLoad() {
        view.setupUI()
        fetchComments()
    }

}

extension CommentsPresenter: CommentsPresenterInput {
    func reloadComments() {
        fetchComments()
    }
    
    
    func sendComment(_ text: String) {
        commentsService?.postComment(uuid: uuid, message: text, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.view.onCommentPosted()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        })
    }
    
}

private extension CommentsPresenter {
    func fetchComments() {
        commentsService?.getComments(uuid: uuid, completion: { [weak self] result in
            self?.handleFeedRequstResult(result: result)
        })
    }
    
    func handleFeedRequstResult(result: Result<CommentsResponse, NetworkError>) {
        switch result {
        case .success(let comments):
            view.setupComments(comments.data)
        case .failure(let error):
            debugPrint(error.localizedDescription)
        }
    }
}
