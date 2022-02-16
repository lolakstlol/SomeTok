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
    private var isReadyToPlay: Bool = false {
        didSet {
            isReadyToPlay ? playVideo() : stopVideo()
        }
    }
    
    init(_ model: FeedResponse, isMainFeed: Bool) {
        self.model = model
        self.isMainFeed = isMainFeed
        
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(userWasSubscribed),
//                                               name: .userWasSubscribed,
//                                               object: nil)
    }
    
    func playVideo() {
        debugPrint("-- play video \(model.author.username)")
        cell?.play()
    }
    
    func stopVideo() {
        debugPrint("-- stop video \(model.author.username)")
        cell?.pause()
    }
    
    func setupCell(_ cell: UIView) {
//        guard let payload = model.media.first?.preview else { return }
        self.cell = cell as? FeedCell
//        self.cell?.previewImageView.kf.setImage(with: URL(string: payload))
//        let userImage = model.author.photo.preview ?? ""
//        self.cell?.avatarImageView.kf.setImage(with: URL(string: userImage))
//        self.cell?.setupUserData(authorName: model.author.name ?? "", description: , likesCount: <#T##Int#>, isLiked: <#T##Bool#>, commentsCount: <#T##Int#>)
//        guard let videoURL = model.media.last?.original, model.media.last?.type == .video else { return }
        let payload = model.media
        let previewImageString = payload.first?.preview ?? ""
        let videoUrlString = payload.first(where: { $0.type == .video })?.original ?? ""
        let avatarImageString = model.author.photo.preview ?? ""
        let authorName = model.author.name ?? ""
        let description = model.title ?? ""
        let likesCount = model.likes
        let isLiked = model.isLiked
        let commentsCount = model.comments
        
        if let videoUrl = URL(string: videoUrlString) {
            self.cell?.set(videoURL: videoUrl, previewImageString: previewImageString, avatarImageString: avatarImageString)
        } else {
            self.cell?.set(previewImageString: previewImageString, avatarImageString: avatarImageString)
        }
        self.cell?.setupUserData(authorName: authorName,
                           description: description,
                           likesCount: likesCount,
                           isLiked: isLiked,
                           commentsCount: commentsCount)
        
//        debugPrint("--- video is loading on \(videoURL)")
//        self.cell?.loadVideo(URL(string: videoURL))
    }
    
    func updateCell(delegate: FeedCellActionsOutput,
                    likes: (likesCount: Int, type: LikeType, shouldShowFilledLike: Bool),
                    commentsCount: Int) {
//        if UserDefaultsManager.shared.userId != nil {
//            self.cell?.subscribeButton.setImage((model.user.isSubscribed ?? false)
//                                                ? Asset.Assets.Feed.Subscription.subscribed.image
//                                                : Asset.Assets.Feed.Subscription.subscribe.image, for: .normal)
//        } else {
//            self.cell?.subscribeButton.setImage(Asset.Assets.Feed.Subscription.subscribe.image, for: .normal)
//        }
//        debugPrint("update cell")
        cell?.update(delegate, likes: likes, commentsCount: commentsCount)
    }
    
    
    func updateState(_ isReadyToPlay: Bool) {
        self.isReadyToPlay = isReadyToPlay
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
