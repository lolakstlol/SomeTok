//
//  UserListResponse.swift
//  LikeTok
//
//  Created by Daniel on 20.03.22.
//

import Foundation

struct UserSearchListResponse: Codable {
    let data: UserListDataClass
    let result: BaseResult
}

// MARK: - DataClass
struct UserListDataClass: Codable {
    let data: [UserListDatum]
    let meta: UserListMeta
    let links: UserListLinks
}

// MARK: - Datum
struct UserListDatum: Codable {
    let uuid, username, name, type: String
    let lastActive: String
    let photo: UserListPhoto

    enum CodingKeys: String, CodingKey {
        case uuid, username, name, type
        case lastActive = "last_active"
        case photo
    }
}

// MARK: - Photo
struct UserListPhoto: Codable {
    let preview: String?
}

// MARK: - Links
struct UserListLinks: Codable {
    let first, last, prev, next: String?
}

// MARK: - Meta
struct UserListMeta: Codable {
    let cursor: String?
    let path: String
    let perPage: String

    enum CodingKeys: String, CodingKey {
        case cursor, path
        case perPage = "per_page"
    }
}
