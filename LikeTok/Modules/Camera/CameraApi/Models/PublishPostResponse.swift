import Foundation

// MARK: - CreatePostResponse
struct PublishPostResponse: Codable {
    let uuid: String
    let result: PublishResult
}

// MARK: - Result
struct PublishResult: Codable {
    let message: String
    let status: Bool
}
