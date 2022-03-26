//
//  FeedViewFeedViewPresenterOutput.swift
//  marketplace
//
//  Created by Mikhail Lutskii on 20/11/2020.
//  Copyright © 2020 BSL. All rights reserved.
//

import CoreLocation

protocol FeedViewPresenterOutput: AnyObject {
    func setupUI()
    func updateConfigurators(_ configurators: [FeedCellConfigurator])
    func clearConfigurators()
    func updateItem(with model: FeedPost, at index: Int)
    func setNavigationBarHidden(_ hidden: Bool)
    func setInitialIndex(_ index: Int)
    func scrollToTop()
    func setupUserFeed(with index: Int)
    func setupLike(_ type: LikeType, at index: Int?)
    func hideActivityIndicator()
    func openComments(_ uuid: String)
    func openProfile(_ uuid: String)
    func stopVideo()
    func playVideo()
    func tapScreenAction()
}
