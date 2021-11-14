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
    func updateItem(with model: FeedResponse, at index: Int)
    func scrollToTop()
    func setupAddress(with text: String)
    func setupUserFeed(with index: Int)
    func showDismissButton()
    func setupLike(_ type: LikeType, at index: Int?)
    func hideActivityIndicator()
    func hideAddressStackView()
}

struct FeedResponse: Decodable {
    let text: String?
    let postType: String
    let media: [String]?
    let postId: String
    let createdAt: String
    let updatedAt: String
    let hashtags: [String]?
    var likes: Int
    var user: UserResponse
    let geoPoint: GeoPoint?
    var comments: Int
    var isLiked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case text, likes, hashtags, user, media, comments
        case postType = "post_type"
        case postId = "id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case geoPoint = "geo_point"
        case isLiked = "is_liked"
    }
}

struct GeoPoint: Codable {
    let longitude: CLLocationDegrees
    let latitude: CLLocationDegrees
}

struct Media: Codable {
    let type: String
    let payload: Payload
    
    struct Payload: Codable {
        let source: String
        let mainImageUrl: String
        let blurImageUrl: String?
        
        enum CodingKeys: String, CodingKey {
            case source
            case mainImageUrl = "main_image_url"
            case blurImageUrl = "blur_image_url"
        }
    }
}


struct UserResponse: Decodable {
    let userId: String
    let username: String
    let avatarUrl: String
    let name: String?
    let profileType: String
    var isSubscribed: Bool?
    
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case username
        case name
        case avatarUrl = "avatar_url"
        case profileType = "profile_type"
        case isSubscribed = "is_subscribed"
    }
}
