//
//  FeedViewFeedViewInteractorOutput.swift
//  marketplace
//
//  Created by Mikhail Lutskii on 20/11/2020.
//  Copyright © 2020 BSL. All rights reserved.
//

protocol FeedViewInteractorOutput: AnyObject {
    func didReceivedPost(with result: Result<FeedResponse?, NetworkError>)
    func didReceivedFeed(with offset: Int, result: Result<FeedGlobalResponse, NetworkError>)
    func didReceivedUser(with result: Result<UserInfoResponse?, NetworkError>)
//    func didSendChatMessage(with result: Result<CreateChatResponse?, NetworkAPI.NetworkError>)
//    func didSendComment(with result: Result<CommentResponse?, NetworkAPI.NetworkError>)
    func didCreateLike(with result: String?)
    func didDeleteLike(with result: String?)
    func didSubscribe(with result: Result<SubscribeResponse?, NetworkError>)
    func didUnsubscribe(with result: Result<SubscribeResponse?, NetworkError>)
    func didSetUserId(with index: Int)
    func openComments()
}

struct SubscribeResponse: Decodable {
    let subscriptionUserId: String
    let subscriberUserId: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case subscriptionUserId = "subscription_user_id"
        case subscriberUserId = "subscriber_user_id"
        case createdAt = "created_at"
    }
}

final class UserInfoResponse: Codable {
    var username: String
    var name: String?
    let phone: String
    let email: String?
    var avatarURL: String
    var location: Location?
    let profileType: String
    let userId: String
    let createdAt: String
    let updatedAt: String
//    var businessData: BusinessData?
    let likes: Int
    var subscribers: Int
    var isSubscribed: Bool
    
    enum CodingKeys: String, CodingKey {
        case username, name, phone, email
        case avatarURL = "avatar_url"
        case location
        case profileType = "profile_type"
        case userId = "id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
//        case businessData = "profile_data"
        case likes
        case subscribers
        case isSubscribed = "is_subscribed"
    }
    
    init(username: String,
         name: String,
         phone: String,
         email: String,
         avatarURL: String,
         location: Location,
         profileType: String,
         userId: String,
         createdAt: String,
         updatedAt: String,
//         businessData: BusinessData? = nil,
         likes: Int,
         subscribers: Int,
         isSubscribed: Bool) {
        self.username = username
        self.name = name
        self.phone = phone
        self.email = email
        self.avatarURL = avatarURL
        self.location = location
        self.profileType = profileType
        self.userId = userId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
//        self.businessData = businessData
        self.likes = likes
        self.subscribers = subscribers
        self.isSubscribed = isSubscribed
    }
}

// MARK: - Location
struct Location: Codable {
    var address: String
    var geoPoint: UserGeoPoint
    let userId: String
    let isCurrent: Bool
    
    enum CodingKeys: String, CodingKey {
        case address
        case geoPoint = "geo_point"
        case userId = "id"
        case isCurrent = "is_current"
    }
    
    init(address: String, geoPoint: UserGeoPoint, userId: String, isCurrent: Bool) {
        self.address = address
        self.geoPoint = geoPoint
        self.userId = userId
        self.isCurrent = isCurrent
    }
}

// MARK: - GeoPoint
struct UserGeoPoint: Codable {
    let longitude: Double
    let latitude: Double
    
    init(longitude: Double, latitude: Double) {
        self.longitude = longitude
        self.latitude = latitude
    }
}
