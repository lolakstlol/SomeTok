//
//  CommentsPresenterOutput.swift
//  LikeTok
//
//  Created by Daniel on 21.01.22.
//

import Foundation

protocol CommentsPresenterOutput: AnyObject {
    func setupUI()
    func setupComments(_ comments: [CommentsDatum])
    func onCommentPostSuccess(_ newComment: CommentsDatum)
    func onCommentPostFailure(_ error: NetworkError)
    func openOtherProfile(_ viewController: OtherProfileViewController)
    func onScrolledToBottom()
    func onListEnd()
}
