//
//  CommentsApiWorker.swift
//  LikeTok
//
//  Created by Daniel on 23.01.22.
//

import Foundation

protocol CommentsApiWorkerProtocol: AnyObject {
    func getComments(uuid: String, completion: @escaping (Swift.Result<CommentsResponse, NetworkError>) -> Void)
    func postComment(uuid: String, message: String, completion: @escaping (Swift.Result<PostedCommentResponse, NetworkError>) -> Void)
}

final class CommentsApiWorker: CommentsApiWorkerProtocol {
    
    func getComments(uuid: String, completion: @escaping (Swift.Result<CommentsResponse, NetworkError>) -> Void) {
        Api.Comments.getComments(uuid: uuid).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(CommentsResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func postComment(uuid: String, message: String, completion: @escaping (Swift.Result<PostedCommentResponse, NetworkError>) -> Void) {
        Api.Comments.postComments(uuid: uuid, text: message).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(PostedCommentResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
}
