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
    let dataDescription: String?
    let photo: Photo
    var friends, subscriptions, subscribers: Int

    enum CodingKeys: String, CodingKey {
        case uuid, username, name, type
        case lastActive = "last_active"
        case url
        case dataDescription = "description"
        case isFollow = "is_follow"
        case isFriend = "is_friend"
        case photo, friends, subscriptions, subscribers
    }
}

// MARK: - Photo
struct OtherProfileServerPhoto: Codable {
    let preview: String
}
