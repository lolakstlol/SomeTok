//
//  OtherProfileServerResponse.swift
//  LikeTok
//
//  Created by Daniel on 20.02.22.
//

import Foundation

// MARK: - Welcome
struct OtherProfileServerModel: Codable {
    let data: OtherProfileServerData
    let result: BaseResult
}

// MARK: - WelcomeData
struct OtherProfileServerData: Codable {
    let data: OtherProfileServerDatum
}

// MARK: - DataData
struct OtherProfileServerDatum: Codable {
    let uuid, username, name, type: String
    let lastActive: String
    let url: String?
    let isFollow, isFriend: Bool
    let photo: Photo

    enum CodingKeys: String, CodingKey {
        case uuid, username, name, type
        case lastActive = "last_active"
        case url
        case isFollow = "is_follow"
        case isFriend = "is_friend"
        case photo
    }
}

// MARK: - Photo
struct OtherProfileServerPhoto: Codable {
    let preview: String
}
