import Foundation

// MARK: - Welcome
struct CommentsResponse: Codable {
    let data: CommentData
    let result: CommentResult
}

struct CommentData: Codable {
    let data: [CommentDatum]
}

// MARK: - Datum
struct CommentDatum: Codable {
    let uuid: String
    let adv: Bool
    let author: CommentAuthor
    let userLastActive, createdAt, updatedAt, message: String
    let like: Bool
    let post: CommentPost

    enum CodingKeys: String, CodingKey {
        case uuid, adv, author
        case userLastActive = "user_last_active"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case message, like, post
    }
}

// MARK: - Author
struct CommentAuthor: Codable {
    let uuid, username, name, type: String
    let lastActive: String
    let isFollow, isFriend: Bool
    let photo: CommentPhoto

    enum CodingKeys: String, CodingKey {
        case uuid, username, name, type
        case lastActive = "last_active"
        case isFollow = "is_follow"
        case isFriend = "is_friend"
        case photo
    }
}

// MARK: - Photo
struct CommentPhoto: Codable {
    let preview: String?
}

// MARK: - Post
struct CommentPost: Codable {
    let title, text: String?
    let isLike: Bool
    let likes: Int

    enum CodingKeys: String, CodingKey {
        case title, text
        case isLike = "is_like"
        case likes
    }
}

// MARK: - Result
struct CommentResult: Codable {
    let message: String
    let status: Bool
}

// MARK: - Encode/decode helpers

//class CommentsJSONNull: Codable, Hashable {
//
//    public static func == (lhs: CommentsJSONNull, rhs: CommentsJSONNull) -> Bool {
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
