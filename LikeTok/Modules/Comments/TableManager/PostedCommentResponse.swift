//
//  PostedCommentResponse.swift
//  LikeTok
//
//  Created by Daniel on 29.01.22.
//

import Foundation

// MARK: - Welcome
struct PostedCommentResponse: Codable {
    let data: PostedCommentDataClass
    let result: PostedCommentResult
}

// MARK: - DataClass
struct PostedCommentDataClass: Codable {
    let data: CommentsDatum
}

// MARK: - Result
struct PostedCommentResult: Codable {
    let message: String
    let status: Bool
}

