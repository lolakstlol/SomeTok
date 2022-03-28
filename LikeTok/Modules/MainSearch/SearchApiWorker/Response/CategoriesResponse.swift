import Foundation

// MARK: - CategoriesResponse
struct CategoriesResponse: Codable {
    let data: CategoriesDataClass?
    let result: ResponseResult
}

// MARK: - DataClass
struct CategoriesDataClass: Codable {
    let data: [CategoriesDatum]?
    let meta: Meta
    let links: Links
}

// MARK: - Datum
struct CategoriesDatum: Codable {
    let uuid, createdAt, updatedAt, code: String?
    let name: String?
    let posts: [FeedPost]?

    enum CodingKeys: String, CodingKey {
        case uuid
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case code, name, posts
    }
}

// MARK: - Post
struct CategoriesPost: Codable {
    let uuid: String
    let adv: Bool?
    let createdAt, updatedAt: String
    let author: Author?
    let title, text: String?
    let isLike: Bool?
    let likes, comments: Int?
    let media: [Media]?

    enum CodingKeys: String, CodingKey {
        case uuid, adv
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case author, title, text
        case isLike = "is_like"
        case likes, comments, media
    }
}

// MARK: - Author
struct Author: Codable {
    let type, uuid: String
    let isFollow, isFriend: Bool
    let username, name, lastActive: String?
    let photo: Photo

    enum CodingKeys: String, CodingKey {
        case type, uuid
        case isFollow = "is_follow"
        case isFriend = "is_friend"
        case username, name
        case lastActive = "last_active"
        case photo
    }
}

// MARK: - Photo
struct Photo: Codable {
    let preview: String?
}

// MARK: - Media
struct Media: Codable {
    let uuid, type: String?
    let preview, original: String?
}

// MARK: - Links
struct Links: Codable {
    let first, last, prev, next: String?
}

// MARK: - Meta
struct Meta: Codable {
    let cursor: String?
    let path: String
  //  let perPage: Int?

    enum CodingKeys: String, CodingKey {
        case cursor, path
        //case perPage = "per_page"
    }
}

// MARK: - Result
struct ResponseResult: Codable {
    let message: String
    let status: Bool
}
