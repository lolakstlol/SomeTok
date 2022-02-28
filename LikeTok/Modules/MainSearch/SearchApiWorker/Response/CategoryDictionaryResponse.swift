

// MARK: - CategoryDictionaryResponse
struct CategoryDictionaryResponse: Codable {
    let data: CategoryDictionaryData
    let result: ResponseResult
}

struct CategoryDictionaryData: Codable {
    let data: [CategoryDictionary]
}

// MARK: - Datum
struct CategoryDictionary: Codable {
    let name, slug: String
    let categories: [CategoryDictionary]?
}
