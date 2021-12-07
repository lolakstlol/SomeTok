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
    func stopVideo()
    func tapScreenAction()
}

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
    let uuid, username, name, type: String?
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
