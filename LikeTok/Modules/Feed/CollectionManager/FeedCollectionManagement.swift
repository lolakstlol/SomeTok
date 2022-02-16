//
//  FeedCollectionManagement.swift
//  Marketplace
//
//  Created by Daniil Kabachuk on 5/22/21.
//  Copyright © 2021 BSL. All rights reserved.
//

import UIKit.UICollectionView

protocol FeedCollectionManagement: AnyObject {
    var output: FeedCollectionOutput? { get set }
    func attach(_ collectionView: UICollectionView)
    func update(with configurators: [FeedCellConfigurator])
    func updateItem(with model: FeedResponse, at index: Int)
    func updateCellLikes(type: LikeType, at index: Int?)
    func scrollToTop()
    func playVideo()
    func setFeedIndex(_ index: Int)
}
