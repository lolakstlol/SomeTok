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
    
    init(_ model: FeedResponse, isMainFeed: Bool) {
        self.model = model
        self.isMainFeed = isMainFeed
        
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(userWasSubscribed),
//                                               name: .userWasSubscribed,
//                                               object: nil)
    }
    
    func setupCell(_ cell: UIView) {
//        guard let payload = model.media?.first?.payload else { return }
        self.cell = cell as? FeedCell
//        self.cell?.imageView.kf.setImage(with: URL(string: payload.mainImageUrl))
        self.cell?.imageView.image = Assets.onb1.image
//        self.cell?.backgroundImageView.kf.setImage(with: URL(string: payload.blurImageUrl ?? ""))

//        self.cell?.toCatalogButton.isHidden = !isMainFeed
//        self.cell?.subscribeButton.isHidden = model.user.userId == UserDefaultsManager.shared.userId
//        let time = AppDateFormatter.shared.howLongAgoWithDate(with: model.createdAt) ?? ""
        self.cell?.setupUserData(userLogin: model.user.username, creationTime: "", userName: model.user.name ?? "")
    }
    
    func updateCell(delegate: FeedCellActionsOutput,
                    likes: (likesCount: Int, type: LikeType, shouldShowFilledLike: Bool),
                    commentsCount: Int,
                    imageUrlString: String) {
//        if UserDefaultsManager.shared.userId != nil {
//            self.cell?.subscribeButton.setImage((model.user.isSubscribed ?? false)
//                                                ? Asset.Assets.Feed.Subscription.subscribed.image
//                                                : Asset.Assets.Feed.Subscription.subscribe.image, for: .normal)
//        } else {
//            self.cell?.subscribeButton.setImage(Asset.Assets.Feed.Subscription.subscribe.image, for: .normal)
//        }
//        cell?.configure(delegate, likes, commentsCount, imageUrlString)
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
