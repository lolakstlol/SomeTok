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
    private var cursor: String?
    private var currentPage: Int = 0
    private var isLoadingList: Bool = false
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
        fetchInitialComments()
    }

}

extension CommentsPresenter: CommentsPresenterInput {
    
    func profileTapAction(_ uuid: String) {
        let otherProfileViewController = OtherProfileAssembler.createModule(uuid)
        view.openOtherProfile(otherProfileViewController)
    }
    
    func fetchMoreComments() {
        if !isLoadingList {
            view.onScrolledToBottom()
            fetchComments()
            isLoadingList = true
        } 
    }
    
    func sendComment(_ text: String) {
        commentsService?.postComment(uuid: uuid, message: text, completion: { [weak self] result in
            switch result {
            case .success(let comment):
//                debugPrint("23")
                self?.view.onCommentPostSuccess(comment.data.data)
            case .failure(let error):
                self?.view.onCommentPostFailure(error)
            }
        })
    }
    
}

private extension CommentsPresenter {
    func fetchInitialComments() {
        commentsService?.getInitialComments(uuid: uuid, completion: { [weak self] result in
            self?.handleFeedRequstResult(result: result)
        })
    }
    
    func fetchComments() {
        guard let cursor = cursor else {
            view.onListEnd()
            return
        }
        commentsService?.getComments(uuid: uuid, cursor: cursor, completion: { [weak self] result in
            self?.handleFeedRequstResult(result: result)
        })
    }
    
    func handleFeedRequstResult(result: Result<CommentsResponse, NetworkError>) {
        switch result {
        case .success(let commentsResult):
            isLoadingList = false
            cursor = commentsResult.data.meta.cursor
            let comments = commentsResult.data.data
            view.setupComments(comments)
            delegate?.updateCommentCount(comments.count)
        case .failure(let error):
            debugPrint(error.localizedDescription)
        }
    }
}
