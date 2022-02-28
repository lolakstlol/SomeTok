//
//  CommentsPresenter.swift
//  LikeTok
//
//  Created by Daniel on 21.01.22.
//

import Foundation

protocol CommentsDelegate: AnyObject {
    func updateCommentCount(_ count: Int)
}

final class CommentsPresenter {
    
    private unowned let view: CommentsPresenterOutput
    private var commentsService: CommentsApiWorkerProtocol?
    private var uuid = String()
    
    weak var delegate: CommentsDelegate?

    init(_ view: CommentsPresenterOutput, _ commentsService: CommentsApiWorkerProtocol, _ uuid: String, delegate: CommentsDelegate) {
        self.view = view
        self.commentsService = commentsService
        self.uuid = uuid
        self.delegate = delegate
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
        case .success(let commentsResult):
            let comments = commentsResult.data.data
            view.setupComments(comments)
            delegate?.updateCommentCount(comments.count)
        case .failure(let error):
            debugPrint(error.localizedDescription)
        }
    }
}
