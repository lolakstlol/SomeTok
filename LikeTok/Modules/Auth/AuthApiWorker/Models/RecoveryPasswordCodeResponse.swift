//
//  RecoveryPasswordCodeResponse.swift
//  LikeTok
//
//  Created by Daniil Stelchenko on 29.10.21.
//

import Foundation

// MARK: - Welcome
struct RecoveryPasswordCodeResponse: Codable {
    let data: RecoveryPasswordDataClass
    let result: RecoveryPasswordResult
}

// MARK: - DataClass
struct RecoveryPasswordDataClass: Codable {
}

// MARK: - Result
struct RecoveryPasswordResult: Codable {
    let message: String
    let status: Bool
}

