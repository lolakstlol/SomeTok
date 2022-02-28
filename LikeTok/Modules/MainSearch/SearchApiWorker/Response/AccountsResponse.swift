import Foundation

// MARK: - SearchTagsResponse
struct SearchAccountsResponse: Codable {
    let data: SearchAccountsDataClass
    let result: ResponseResult
}

// MARK: - DataClass
struct SearchAccountsDataClass: Codable {
    let data: [SearchAccountsDatum]
}

// MARK: - Datum
struct SearchAccountsDatum: Codable {
    let type, uuid: String
    var isFollow, isFriend: Bool
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
struct SearchAccountsPhoto: Codable {
    let preview: String?
}
