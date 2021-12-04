import Foundation

// MARK: - CountryDictionaryResponse
struct CountryDictionaryResponse: Codable {
    let data: [CountryDictionary]
    let result: ResponseResult
}

// MARK: - CountryDictionar
struct CountryDictionary: Codable {
    let name, slug: String
}
