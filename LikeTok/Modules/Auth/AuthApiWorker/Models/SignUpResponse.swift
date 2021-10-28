import Foundation

// MARK: - SignUpResponse
struct SignUpResponse: Codable {
    let result: SignUpResult
}

// MARK: - Result
struct SignUpResult: Codable {
    let message: String
    let status: Bool
}
