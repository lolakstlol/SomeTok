import Foundation

// MARK: - HashtagsDictionaryResponse
struct HashtagsDictionaryResponse: Codable {
    let data: HashtagsDictionaryResponseDatum
    let result: HashtagsDictionaryResponseResult
}

// MARK: - Datum
struct HashtagsDictionaryResponseDatum: Codable {
    let data: [HashtagsDictionaryHashtag]
}

struct HashtagsDictionaryHashtag: Codable {
    let name: String
}

// MARK: - Result
struct HashtagsDictionaryResponseResult: Codable {
    let message: String
    let status: Bool
}
