//
//  ToProfileModel.swift
//  LikeTok
//
//  Created by Daniel on 20.02.22.
//

import Foundation

class ToProfileModel {
    
    private let serverModel: ProfileServerDatum
    
    var transform: ProfileModel {
        return ProfileModel(uuid: serverModel.uuid, name: serverModel.name, username: serverModel.username, phone: serverModel.phone, email: serverModel.email, description: serverModel.dataDescription, type: serverModel.type, photo: ProfilePhoto(preview: serverModel.photo.preview), typeOfActivity: serverModel.typeOfActivity, location: ProfileLocation(country: serverModel.location.country, city: serverModel.location.city), site: serverModel.site, position: serverModel.position, userLastActive: serverModel.userLastActive, notificationCount: serverModel.notificationCount, messageCount: serverModel.messageCount, friends: serverModel.friends, subscriptions: serverModel.subscriptions, subscribers: serverModel.subscribers)
    }
    
    init(_ serverModel: ProfileServerDatum) {
        self.serverModel = serverModel
    }
    
}
