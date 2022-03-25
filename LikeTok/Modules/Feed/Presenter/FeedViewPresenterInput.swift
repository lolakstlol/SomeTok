//
//  FeedViewFeedViewPresenterInput.swift
//  marketplace
//
//  Created by Mikhail Lutskii on 20/11/2020.
//  Copyright © 2020 BSL. All rights reserved.
//

import UIKit.UIImage

protocol FeedViewPresenterInput: BasePresenting {
    func sendMessage(_ message: String)
    func setCurrentPost(_ post: FeedPost)
    func feedIsScrollingToEnd(with offset: Int)
    func setCommentsCount(with count: Int)
    func openComments()
    func getFeed()
    func getFeedWithScrollToTop()

    func closeButtonTouchUpInside()
    func profileTouchUpInside()
    func likeTouchUpInside(_ type: LikeActionType)
    func shareTouchUpInside(postUUID: String)
    func moreTouchUpInside()
    func subscribeTapAction()
    func screenTapAction()
    func addressLabelTouchUpInside()
    func floatingBasketTouchUpInside()
    
    func isMoreButtonVisible() -> Bool
    func shouldShowActivityIndicator() -> Bool
    func shouldShowFilledLikes() -> Bool
}
