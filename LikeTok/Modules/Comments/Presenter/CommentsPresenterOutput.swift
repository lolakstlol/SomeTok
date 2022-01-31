//
//  CommentsPresenterOutput.swift
//  LikeTok
//
//  Created by Daniel on 21.01.22.
//

import Foundation

protocol CommentsPresenterOutput: AnyObject {
    func setupUI()
    func setupComments(_ comments: [CommentDatum])
    func onCommentPosted()
}
