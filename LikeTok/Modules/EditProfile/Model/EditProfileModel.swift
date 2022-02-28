//
//  EditProfileModel.swift
//  LikeTok
//
//  Created by Daniel on 20.02.22.
//

import Foundation

struct EditProfileModel {
    let avatar: String?
    let name: String
    var username: String
    let email: String
    let phone: String
    let country: String
    let city: String
    let description: String
}

struct EditedProfileModel {
    let name: String?
    var username: String?
    let email: String?
    let phone: String?
    let country: String?
    let city: String?
    let description: String?
}
