//
//  CommentsPresenterInput.swift
//  LikeTok
//
//  Created by Daniel on 21.01.22.
//

import Foundation

protocol CommentsPresenterInput: BasePresenting {
//    func updateFeedType(_ type: FeedViewEnterOption)
//    func fetchMoreFeed()
//    func reloadFeed()
    func sendComment(_ text: String)
    func fetchMoreComments()
    func profileTapAction(_ uuid: String)
}
