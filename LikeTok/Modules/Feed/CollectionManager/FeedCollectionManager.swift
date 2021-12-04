//
//  FeedCollectionManager.swift
//  Marketplace
//
//  Created by Mikhail Lutskiy on 22.11.2020.
//  Copyright © 2020 BSL. All rights reserved.
//

import class Foundation.NSObject
import UIKit

protocol FeedCollectionOutput: AnyObject {
    func selectFeedItem(_ item: FeedResponse)
    func requestNextPosts(offset: Int)
    func attach() -> FeedCellActionsOutput
    func isMoreButtonVisible() -> Bool
    func showActivityIndicator()
    func shouldShowFilledLikes() -> Bool
}

final class FeedCollectionManager: NSObject {
    private var configurators = [FeedCellConfigurator]()
    private weak var collectionView: UICollectionView?
    private var itemIndex: Int?
    private var isRefreshingFeed = false
    private var isReadyToPlay = false
    private var currentItem: FeedResponse? {
        guard configurators.count != 0 else {
            return nil
        }
        guard let contentOffsetY = collectionView?.contentOffset.y else {
            return nil
        }
        guard let frameSizeHeight = collectionView?.frame.size.height else {
            return nil
        }
        let index = Int(round(contentOffsetY / frameSizeHeight))
        guard let item = configurators[safe: index]?.getModel() else {
            return nil
        }
        return item
    }
    weak var output: FeedCollectionOutput?
    
    private func setupCellItems() {
        guard let item = currentItem,
              let currentIndex = configurators.firstIndex(where: { $0.getModel().uuid == currentItem?.uuid }),
              let delegate = output?.attach(),
              let shouldShowFilledLikes = output?.shouldShowFilledLikes() else { return }
        
        configurators[currentIndex].updateCell(delegate: delegate,
                                               playerDelegate: self,
                                               likes: (item.likes, item.isLiked ? .filled : .empty, shouldShowFilledLikes),
                                               commentsCount: item.comments,
                                               imageUrlString: item.author.photo.preview ,
                                               description: item.title ?? "",
                                               isReadyToPlay: isReadyToPlay)
                                                //item.user.avatarUrl)
    }
    
    private func checkFeedPositionForRequest() {
        guard let currentIndex = configurators.firstIndex(where: { $0.getModel().uuid == currentItem?.uuid }),
              configurators.count - currentIndex < Constants.Feed.minFeedIndexDifference  else { return } 
        output?.requestNextPosts(offset: configurators.count)
    }
}

// MARK: - UICollectionViewDataSource

extension FeedCollectionManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let configurator = configurators[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: configurator).cellIdentifier,
            for: indexPath)
        configurator.setupCell(cell)
        setupCellItems()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return configurators.count
    }
}

// MARK: - FeedCollectionManagement

extension FeedCollectionManager: FeedCollectionManagement {
    func attach(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.isPagingEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(nibOfClass: FeedCell.self)
        self.collectionView = collectionView
    }
    
    func updateCellLikes(type: LikeType, at index: Int?) {
        guard let index = index, let shouldShowFilledLikes = output?.shouldShowFilledLikes() else { return }
        configurators[index].cell?.updateLikes(type: type, shouldShowFilledLike: shouldShowFilledLikes)
    }
    
    func updateItem(with model: FeedResponse, at index: Int) {
        configurators[index].updateModel(model: model) {
            self.setupCellItems()
        }
    }
    
    func update(with configurators: [FeedCellConfigurator]) {
        self.configurators = configurators
        collectionView?.reloadData()
        if let index = itemIndex {
            collectionView?.scrollToItem(at: IndexPath(row: index, section: .zero),
                                         at: UICollectionView.ScrollPosition(rawValue: .zero),
                                         animated: false)
        }
        guard let item = currentItem else {
            return
        }
        guard let index = itemIndex, let model = (configurators[safe: index]?.getModel()) else {
            output?.selectFeedItem(item)
            setupCellItems()
            return
        }
        output?.selectFeedItem(model)
        setupCellItems()
    }
    
    func scrollToTop() {
        DispatchQueue.main.async {
            self.collectionView?.scrollToItem(at: IndexPath(item: .zero, section: .zero),
                                         at: UICollectionView.ScrollPosition(rawValue: .zero),
                                         animated: true)
            if let first = self.configurators.first?.getModel() {
                self.output?.selectFeedItem(first)
            }
            self.collectionView?.reloadData()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let item = currentItem,
              let currentIndex = configurators.firstIndex(where: { $0.getModel().uuid == currentItem?.uuid })
        else {
            return
        }
        isReadyToPlay = true
//        configurators[currentIndex].updateState(true)
        checkFeedPositionForRequest()
        output?.selectFeedItem(item)
        setupCellItems()
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isReadyToPlay = false
        setupCellItems()
    }
    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        configurators.forEach { $0.updateState(false) }
 
//    }
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard configurators.first?.getModel().uuid == currentItem?.uuid else { return }
        let position = scrollView.contentOffset.y
        if position < -Constants.Feed.minScrollSizeToRefresh, !isRefreshingFeed {
            isRefreshingFeed = true
            output?.showActivityIndicator()
        } else if position >= 0 {
            isRefreshingFeed = false
        }
    }
    
    func setFeedIndex(_ index: Int) {
        itemIndex = index
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedCollectionManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        return configurators[indexPath.row].didTapCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return configurators[indexPath.row].getCellSize(viewSize: collectionView.frame.size)
    }
}

extension FeedCollectionManager: FeedPlayerDelegate {
    func onReadyToPlay() {
        isReadyToPlay = true
        setupCellItems()
//        guard let currentIndex = configurators.firstIndex(where: { $0.getModel().uuid == currentItem?.uuid })
//           else {
//               return
//           }
//        configurators[currentIndex].updateState(true)
    }
    
}

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
