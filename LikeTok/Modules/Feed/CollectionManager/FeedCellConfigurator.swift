//
//  FeedCellConfigurator.swift
//  Marketplace
//
//  Created by Mikhail Lutskiy on 22.11.2020.
//  Copyright © 2020 BSL. All rights reserved.
//
// swiftlint:disable large_tuple

import UIKit
import Kingfisher

final class FeedCellConfigurator {
    static var cellIdentifier: String = FeedCell.cellIdentifier
    
    private var model: FeedResponse
    private(set) var cell: FeedCell?
    private let isMainFeed: Bool
    private var isReadyToPlay: Bool = false
    
    init(_ model: FeedResponse, isMainFeed: Bool) {
        self.model = model
        self.isMainFeed = isMainFeed
        
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(userWasSubscribed),
//                                               name: .userWasSubscribed,
//                                               object: nil)
    }
    
    
    func playVideo() {
        cell?.playVideo()
    }
    
    func stopVideo() {
        cell?.stopVideo()
    }
    
    func setupCell(_ cell: UIView) {
        guard let payload = model.media.first?.preview else { return }
        self.cell = cell as? FeedCell
        self.cell?.imageView.kf.setImage(with: URL(string: payload))
        let userImage = model.author.photo.preview
        self.cell?.userImageView.kf.setImage(with: URL(string: userImage))
//        self.cell?.imageView.image = Assets.onb1.image
//        self.cell?.backgroundImageView.kf.setImage(with: URL(string: payload.blurImageUrl ?? ""))

//        self.cell?.toCatalogButton.isHidden = !isMainFeed
//        self.cell?.subscribeButton.isHidden = model.user.userId == UserDefaultsManager.shared.userId
//        let time = AppDateFormatter.shared.howLongAgoWithDate(with: model.createdAt) ?? ""
        self.cell?.setupUserData(userName: model.author.name)
        guard let videoURL = model.media.last?.original else { return }
        self.cell?.loadVideo(URL(string: videoURL))
    }
    
    func updateState(_ isReadyPlay: Bool) {
        
        if isReadyPlay {
            self.playVideo()
        } else {
            self.stopVideo()
        }
//        self.isReadyToPlay = isReadyPlay
    }
    
    func updateCell(delegate: FeedCellActionsOutput,
                    playerDelegate: FeedPlayerDelegate,
                    likes: (likesCount: Int, type: LikeType, shouldShowFilledLike: Bool),
                    commentsCount: Int,
                    imageUrlString: String,
                    description: String,
                    media: [Media]) {
//        if UserDefaultsManager.shared.userId != nil {
//            self.cell?.subscribeButton.setImage((model.user.isSubscribed ?? false)
//                                                ? Asset.Assets.Feed.Subscription.subscribed.image
//                                                : Asset.Assets.Feed.Subscription.subscribe.image, for: .normal)
//        } else {
//            self.cell?.subscribeButton.setImage(Asset.Assets.Feed.Subscription.subscribe.image, for: .normal)
//        }
        let mediaUrls = processMedia(media)
        cell?.configure(delegate, playerDelegate, likes, commentsCount, imageUrlString, mediaUrls.imageUrlString, mediaUrls.videoUrlString, description)
    }
    
    func processMedia(_ media: [Media]) -> (imageUrlString: String, videoUrlString: String){
        var imageURL: String = ""
        var videoURL: String = ""
        
        for item in media {
            switch item.type {
            case .video:
                videoURL = item.original ?? ""
            case .image:
                imageURL = item.original ?? ""
            }
        }
        
        return (imageURL, videoURL)
    }
        
    func getCellSize(viewSize: CGSize?) -> CGSize {
        guard let viewSize = viewSize else { return .zero }
        return viewSize
    }
    
    func updateModel(model: FeedResponse, completion: @escaping EmptyClosure = {}) {
        self.model = model
        completion()
    }
    
    func getModel() -> FeedResponse {
        return model
    }
}
