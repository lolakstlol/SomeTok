

// MARK: - CategoryDictionaryResponse
struct CategoryDictionaryResponse: Codable {
    let data: [CategoryDictionary]
    let result: ResponseResult
}

// MARK: - Datum
struct CategoryDictionary: Codable {
    let name, slug: String
    let subCategories: [CategoryDictionary]?
}
