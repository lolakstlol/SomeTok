import Foundation

struct CommentsResponse: Codable {
    let data: CommentsDataClass
    let result: BaseResult
}

// MARK: - DataClass
struct CommentsDataClass: Codable {
    let data: [CommentsDatum]
    let meta: CommentsMeta
    let links: CommentsLinks
}

// MARK: - Datum
struct CommentsDatum: Codable {
    let countComments: Int
    let uuid: String
    let adv: Bool
    let author: CommentsAuthor
    let userLastActive, createdAt, updatedAt, message: String
    let like: Bool
    let post: CommentsPost

    enum CodingKeys: String, CodingKey {
        case countComments = "count_comments"
        case uuid, adv, author
        case userLastActive = "user_last_active"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case message, like, post
    }
}

// MARK: - Author
struct CommentsAuthor: Codable {
    let uuid, username, name, type: String
    let lastActive: String
    let url, authorDescription: String?
    let isFollow, isFriend: Bool
    let photo: CommentsPhoto
    let friends, subscriptions, subscribers: Int

    enum CodingKeys: String, CodingKey {
        case uuid, username, name, type
        case lastActive = "last_active"
        case url
        case authorDescription = "description"
        case isFollow = "is_follow"
        case isFriend = "is_friend"
        case photo, friends, subscriptions, subscribers
    }
}

// MARK: - Photo
struct CommentsPhoto: Codable {
    let preview: String?
}

// MARK: - Post
struct CommentsPost: Codable {
    let title, text: String?
    let isLike: Bool
    let likes: Int

    enum CodingKeys: String, CodingKey {
        case title, text
        case isLike = "is_like"
        case likes
    }
}

// MARK: - Links
struct CommentsLinks: Codable {
    let first, last, prev: String?
    let next: String?
}

// MARK: - Meta
struct CommentsMeta: Codable {
    let cursor: String?
    let path: String
    let perPage: String

    enum CodingKeys: String, CodingKey {
        case cursor, path
        case perPage = "per_page"
    }
}
