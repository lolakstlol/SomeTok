//
//  CommentsApiWorker.swift
//  LikeTok
//
//  Created by Daniel on 23.01.22.
//

import Foundation

protocol CommentsApiWorkerProtocol: AnyObject {
    func getInitialComments(uuid: String, completion: @escaping (Swift.Result<CommentsResponse, NetworkError>) -> Void)
    func getComments(uuid: String, cursor: String, completion: @escaping (Swift.Result<CommentsResponse, NetworkError>) -> Void)
    func postComment(uuid: String, message: String, completion: @escaping (Swift.Result<PostedCommentResponse, NetworkError>) -> Void)
}

final class CommentsApiWorker: CommentsApiWorkerProtocol {
    
    func getInitialComments(uuid: String, completion: @escaping (Swift.Result<CommentsResponse, NetworkError>) -> Void) {
        Api.Comments.getInitialComments(uuid: uuid).request.responseJSON { response in
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
    
    func getComments(uuid: String, cursor: String, completion: @escaping (Swift.Result<CommentsResponse, NetworkError>) -> Void) {
        Api.Comments.getComments(uuid: uuid, cursor: cursor).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(CommentsResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    try? self.catchError(data: response.data!, type: CommentsResponse.self)
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
            case 201:
                if let data = response.data, let response = try? JSONDecoder().decode(PostedCommentResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    try? self.catchError(data: response.data!, type: PostedCommentResponse.self)
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    private func catchError<T: Decodable>(data: Data, type: T.Type) throws {
        let decoder = JSONDecoder()
        do {
            _ = try decoder.decode(type.self, from: data)
        } catch let decError as DecodingError {
            print("------------...........---------------")
            print(type.self)
            print(decError)
            print(decError.localizedDescription)
            print(decError.failureReason as Any)
            print("------------...........---------------")
        }
    }
}
