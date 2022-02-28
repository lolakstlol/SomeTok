import Foundation

// MARK: - CountryDictionaryResponse
struct CountryDictionaryResponse: Codable {
    let data: CountryDictionaryData
    let result: ResponseResult
}

struct CountryDictionaryData: Codable {
    let data: [CountryDictionary]
}

// MARK: - CountryDictionar
struct CountryDictionary: Codable {
    let name, slug: String
}

//struct CategoryDictionaryResponse: Codable {
//    let data: CategoryDictionaryData
//    let result: ResponseResult
//}
//
//struct CategoryDictionaryData: Codable {
//    let data: [CategoryDictionary]
//}
//
//// MARK: - Datum
//struct CategoryDictionary: Codable {
//    let name, slug: String
//    let categories: [CategoryDictionary]?
//}
