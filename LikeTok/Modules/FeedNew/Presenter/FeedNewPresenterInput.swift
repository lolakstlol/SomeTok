//
//  FeedNewPresenterInput.swift
//  LikeTok
//
//  Created by Daniel on 17.01.22.
//

import Foundation

protocol FeedNewPresenterInput: BasePresenting {
    func updateFeedType(_ type: FeedViewEnterOption)
    func fetchMoreFeed()
    func reloadFeed()
}
