import Foundation

// MARK: - CreatePostResponse
struct CreatePostResponse: Codable {
    let data: CreatePostDataClass
    let result: CreatePostResult
}

// MARK: - DataClass
struct CreatePostDataClass: Codable {
    let uuid: String
}

// MARK: - Result
struct CreatePostResult: Codable {
    let message: String
    let status: Bool
}
