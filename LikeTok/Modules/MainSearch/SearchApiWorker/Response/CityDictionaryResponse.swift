import Foundation

// MARK: - CityDictionaryResponse
struct CityDictionaryResponse: Codable {
    let data: CityDictionaryData
    let result: ResponseResult
}

// MARK: - DataClass
struct CityDictionaryData: Codable {
    let data: [CityDictionary]
    let meta: Meta
    let links: Links
}

// MARK: - Datum
struct CityDictionary: Codable {
    let name, country, slug: String
}


