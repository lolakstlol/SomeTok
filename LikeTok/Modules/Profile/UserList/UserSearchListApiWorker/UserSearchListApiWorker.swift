//
//  UserListApiWorker.swift
//  LikeTok
//
//  Created by Daniel on 20.03.22.
//

import Foundation

final class UserSearchListApiWorker {
    
    func searchFriends(completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
        Api.UserList.friends.request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(UserSearchListResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    try? self.catchError(data: response.data!, type: UserSearchListResponse.self)
                    completion(.failure(.deserialization))
                }
            case 204: completion(.failure(.noData))
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func searchSubscribers(completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
        Api.UserList.subscribers.request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(UserSearchListResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    try? self.catchError(data: response.data!, type: UserSearchListResponse.self)
                    completion(.failure(.deserialization))
                }
            case 204: completion(.failure(.noData))
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func searchSubscriptions(completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
        Api.UserList.subscriptions.request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(UserSearchListResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    try? self.catchError(data: response.data!, type: UserSearchListResponse.self)
                    completion(.failure(.deserialization))
                }
            case 204: completion(.failure(.noData))
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
