//
//  FollowResponse.swift
//  LikeTok
//
//  Created by Daniel on 27.02.22.
//

import Foundation

struct FollowResponse: Codable {
    let data: FollowDataClass
    let result: BaseResult
}

// MARK: - DataClass
struct FollowDataClass: Codable {
    let following: Bool
}
