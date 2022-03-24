import Foundation

// MARK: - ShareLinkResponse
struct ShareLinkResponse: Codable {
    let data: ShareLinkDataClass
    let result: ShareLinkResult
}

// MARK: - DataClass
struct ShareLinkDataClass: Codable {
    let referalLink: String

    enum CodingKeys: String, CodingKey {
        case referalLink = "referal_link"
    }
}

// MARK: - Result
struct ShareLinkResult: Codable {
    let message: String
    let status: Bool
}
