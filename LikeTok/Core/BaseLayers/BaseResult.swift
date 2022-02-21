//
//  BaseResult.swift
//  LikeTok
//
//  Created by Daniel on 20.02.22.
//

import Foundation

struct BaseResponse: Codable {
    let data: BaseDataClass
    let result: BaseResult
}

// MARK: - DataClass
struct BaseDataClass: Codable {
    let uuid: String?
}

// MARK: - Result
struct BaseResult: Codable {
    let message: String
    let status: Bool
}
