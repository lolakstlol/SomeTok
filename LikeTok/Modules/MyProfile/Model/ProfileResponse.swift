//
//  ProfileModel.swift
//  LikeTok
//
//  Created by Daniel on 19.02.22.
//

import Foundation

// MARK: - Welcome
struct ProfileServerModel: Codable {
    let data: ProfileServerData
    let result: BaseResult
}

// MARK: - WelcomeData
struct ProfileServerData: Codable {
    let data: ProfileServerDatum
}

// MARK: - DataData
struct ProfileServerDatum: Codable {
    let uuid, name, username, phone: String
    let email: String
    let dataDescription: String?
    let type: String?
    let photo: ProfileServerPhoto
    let typeOfActivity: String?
    let location: ProfileServerLocation
    let site: String?
    let position, userLastActive: String?
    let notificationCount, messageCount, friends, subscriptions: Int
    let subscribers: Int

    enum CodingKeys: String, CodingKey {
        case uuid, name, username, phone, email
        case dataDescription = "description"
        case type, photo
        case typeOfActivity = "type_of_activity"
        case location, site, position
        case userLastActive = "user_last_active"
        case notificationCount = "notification_count"
        case messageCount = "message_count"
        case friends, subscriptions, subscribers
    }
}

// MARK: - Location
struct ProfileServerLocation: Codable {
    let country: String?
    let city: String
}

// MARK: - Photo
struct ProfileServerPhoto: Codable {
    let preview: String?
}
