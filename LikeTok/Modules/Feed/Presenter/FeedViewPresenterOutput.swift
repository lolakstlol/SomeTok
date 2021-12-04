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

//struct FeedResponse: Decodable {
//    let text: String?
//    let postType: String
//    let media: [String]?
//    let postId: String
//    let createdAt: String
//    let updatedAt: String
//    let hashtags: [String]?
//    var likes: Int
//    var user: UserResponse
//    let geoPoint: GeoPoint?
//    var comments: Int
//    var isLiked: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case text, likes, hashtags, user, media, comments
//        case postType = "post_type"
//        case postId = "id"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case geoPoint = "geo_point"
//        case isLiked = "is_liked"
//    }
//}
//
//struct GeoPoint: Codable {
//    let longitude: CLLocationDegrees
//    let latitude: CLLocationDegrees
//}
//
//struct Media: Codable {
//    let type: String
//    let payload: Payload
//
//    struct Payload: Codable {
//        let source: String
//        let mainImageUrl: String
//        let blurImageUrl: String?
//
//        enum CodingKeys: String, CodingKey {
//            case source
//            case mainImageUrl = "main_image_url"
//            case blurImageUrl = "blur_image_url"
//        }
//    }
//}
//
//
//struct UserResponse: Decodable {
//    let userId: String
//    let username: String
//    let avatarUrl: String
//    let name: String?
//    let profileType: String
//    var isSubscribed: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case userId = "id"
//        case username
//        case name
//        case avatarUrl = "avatar_url"
//        case profileType = "profile_type"
//        case isSubscribed = "is_subscribed"
//    }
//}


//// MARK: - Welcome
//struct FeedGlobalResponse: Codable {
//    let data: DataClass
//    let result: Res
//}
//
//// MARK: - DataClass
//struct DataClass: Codable {
//    let data: [FeedResponse]
//    let meta: Meta
//}
//
//// MARK: - FeedResponse
//struct FeedResponse: Codable {
//    let uuid: String
//    let adv: Bool
//    var author: UserResponse
//    let title, text: String
//    var isLiked: Bool
//    let media: [Media]
//    var likes: Int
//    var comments: Int
//    let tags, categories: [String]
//    let url: String
//
//    enum CodingKeys: String, CodingKey {
//        case uuid, adv, author, title, text
//        case isLiked = "is_like"
//        case media, likes, comments, tags, categories, url
//    }
//}
//
//// MARK: - Author
//struct UserResponse: Codable {
//    let type, uuid: String
//    var isFollow: Bool
//    let isFriend, username, name, lastActive: String
//    let photo: UserPhoto
//
//    enum CodingKeys: String, CodingKey {
//        case type, uuid
//        case isFollow = "is_follow"
//        case isFriend = "is_friend"
//        case username, name
//        case lastActive = "last_active"
//        case photo
//    }
//}
//
//// MARK: - Photo
//struct UserPhoto: Codable {
//    let preview: String
//}
//
//// MARK: - Media
//struct Media: Codable {
//    let uuid, type: String
//    let preview: String
//    let original: String?
//}
//
//// MARK: - Meta
//struct Meta: Codable {
//    let cursor: String
//    let perPage: Int
//
//    enum CodingKeys: String, CodingKey {
//        case cursor
//        case perPage = "per_page"
//    }
//}
//
//// MARK: - Result
//struct Res: Codable {
//    let message: String
//    let status: Bool
//}
//
//
//struct FeedGlobalResponse: Codable {
//    let data: DataClass
//    let result: Res
//}
//
//// MARK: - DataClass
//struct DataClass: Codable {
//    let data: [FeedResponse]
//    let meta: Meta
//    let links: Links
//}
//
//// MARK: - Datum
//struct FeedResponse: Codable {
//    let uuid: String
//    let adv: Bool
//    let createdAt, updatedAt: JSONNull?
//    var author: Author
//    let title, text: String
//    var isLiked: Bool
//    var likes, comments: Int
//    let media: [Media]
//
//    enum CodingKeys: String, CodingKey {
//        case uuid, adv
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case author, title, text
//        case isLiked = "is_like"
//        case likes, comments, media
//    }
//}
//
//// MARK: - Author
//struct Author: Codable {
//    let uuid, username: String
//    let name: String?
//    let type, lastActive: String
//    var isFollow, isFriend: Bool
//    let photo: Photo
//
//    enum CodingKeys: String, CodingKey {
//        case uuid, username, name, type
//        case lastActive = "last_active"
//        case isFollow = "is_follow"
//        case isFriend = "is_friend"
//        case photo
//    }
//}
//
//// MARK: - Photo
//struct Photo: Codable {
//    let preview: String?
//}
//
//// MARK: - Media
//struct Media: Codable {
//    let uuid: JSONNull?
//    let type: String
//    let preview: String
//    let original: JSONNull?
//}
//
//// MARK: - Links
//struct Links: Codable {
//    let first, last, prev: JSONNull?
//    let next: String
//}
//
//// MARK: - Meta
//struct Meta: Codable {
//    let cursor: String
//    let path: String
//    let perPage: String
//
//    enum CodingKeys: String, CodingKey {
//        case cursor, path
//        case perPage = "per_page"
//    }
//}
//
//// MARK: - Result
//struct Res: Codable {
//    let message: String
//    let status: Bool
//}
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct FeedGlobalResponse: Codable {
    let data: FeedDataClass
    let result: FeedRes
}

// MARK: - DataClass
struct FeedDataClass: Codable {
    let data: [FeedResponse]
    let meta: FeedMeta
    let links: FeedLinks
}

// MARK: - Datum
struct FeedResponse: Codable {
    let uuid: String
    let adv: Bool
    let createdAt, updatedAt: String
    var author: FeedAuthor
    let title, text: String?
    var isLiked: Bool
    var likes, comments: Int
    let media: [FeedMedia]

    enum CodingKeys: String, CodingKey {
        case uuid, adv
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case author, title, text
        case isLiked = "is_like"
        case likes, comments, media
    }
}

// MARK: - Author
struct FeedAuthor: Codable {
    let uuid, username, name, type: String
    let lastActive: String
    var isFollow, isFriend: Bool
    let photo: FeedPhoto

    enum CodingKeys: String, CodingKey {
        case uuid, username, name, type
        case lastActive = "last_active"
        case isFollow = "is_follow"
        case isFriend = "is_friend"
        case photo
    }
}

// MARK: - Photo
struct FeedPhoto: Codable {
    let preview: String
}

// MARK: - Media
struct FeedMedia: Codable {
    let uuid: String
    let type: FeedMediaType
    let preview: String
    let original: String?
}

// MARK: - Links
struct FeedLinks: Codable {
    let first, last, prev: String?
    let next: String
}

// MARK: - Meta
struct FeedMeta: Codable {
    let cursor: String
    let path: String
    let perPage: String

    enum CodingKeys: String, CodingKey {
        case cursor, path
        case perPage = "per_page"
    }
}

// MARK: - Result
struct FeedRes: Codable {
    let message: String
    let status: Bool
}

enum FeedMediaType: String, Codable {
    case video, image
}
// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
