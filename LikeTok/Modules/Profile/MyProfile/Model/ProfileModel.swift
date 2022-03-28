//
//  ProfileModel.swift
//  LikeTok
//
//  Created by Daniel on 20.02.22.
//

import Foundation

struct ProfileModel {
    let uuid, name, username, phone: String
    let email: String
    let description: String?
    let type: String?
    let photo: ProfilePhoto
    let typeOfActivity: String?
    let location: ProfileLocation
    let site, position: String?
    let userLastActive: String?
    let notificationCount, messageCount, friends, subscriptions: Int
    let subscribers: Int
}

struct ProfileLocation {
    let country: String?
    let city: String
}

struct ProfilePhoto {
    let preview: String?
}
