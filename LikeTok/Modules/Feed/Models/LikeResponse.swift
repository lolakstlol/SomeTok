//
//  LikeResponse.swift
//  LikeTok
//
//  Created by Daniel on 17.02.22.
//

import Foundation

// MARK: - Welcome
struct LikeResponse: Codable {
    let data: LikeDataClass
    let result: LikeResult
}

// MARK: - DataClass
struct LikeDataClass: Codable {
    let isLike: Bool

    enum CodingKeys: String, CodingKey {
        case isLike = "is_like"
    }
}

// MARK: - Result
struct LikeResult: Codable {
    let message: String
    let status: Bool
}
