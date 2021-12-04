import Foundation

// MARK: - SearchTagsResponse
struct SearchTagsResponse: Codable {
    let data: SearchDataClass
    let result: ResponseResult
}

// MARK: - DataClass
struct SearchDataClass: Codable {
    let data: [CategoriesPost]
    let meta: Meta
    let links: Links
}

