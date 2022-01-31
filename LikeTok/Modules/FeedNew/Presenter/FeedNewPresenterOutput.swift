//
//  FeedNewPresenterOutput.swift
//  LikeTok
//
//  Created by Daniel on 17.01.22.
//

import Foundation

protocol FeedNewPresenterOutput: AnyObject {
    func onFetchFeed(_ items: [FeedResponse])
    func onTapComments(_ uuid: String)
    func onChangedFilter()
    func onLikeSuccess()
    func onLikeFailed()
}
