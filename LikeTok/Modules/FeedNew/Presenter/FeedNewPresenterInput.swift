//
//  FeedNewPresenterInput.swift
//  LikeTok
//
//  Created by Daniel on 17.01.22.
//

import Foundation

protocol FeedNewPresenterInput: BasePresenting {
    var selectedUUID: String? { get }
    func selectItem(_ item: FeedResponse)
    func updateFeedType(_ type: FeedViewEnterOption)
    func updateSelectedItemLike()
    func didTapComments()
    func likeAction()
    func fetchMoreFeed()
    func reloadFeed()
}
