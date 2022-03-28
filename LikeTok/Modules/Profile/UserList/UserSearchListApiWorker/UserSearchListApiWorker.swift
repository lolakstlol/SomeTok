//
//  UserListApiWorker.swift
//  LikeTok
//
//  Created by Daniel on 20.03.22.
//

import Foundation


final class UserSearchListOtherApiWorker {
    
    let uuid: String
    
    init(uuid: String) {
        self.uuid = uuid
    }
    
    func loadSubscribersOther(completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
        Api.UserList.subscribersOther(uuid).request.responseJSON { response in
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
    
    func loadSubscriptionsOther(completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
        Api.UserList.subscriptionsOther(uuid).request.responseJSON { response in
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
    
    func searchSubscribers(predicate: String, completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
        Api.UserList.searchSubscribersOther(predicate, uuid).request.responseJSON { response in
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
    
    func searchSubscriptions(predicate: String, completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
        Api.UserList.searchSubscriptionsOther(predicate, uuid).request.responseJSON { response in
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
    
    func searchSubscribers(cursor: String, completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
        Api.UserList.subscribersOtherMore(cursor, uuid).request.responseJSON { response in
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
    
    func searchSubscriptions(cursor: String, completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
        Api.UserList.subscriptionsOtherMore(cursor, uuid).request.responseJSON { response in
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


final class UserSearchListApiWorker {
  
    
//MARK: - My
    
    func loadFriends(completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
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
    
    func loadSubscribers(completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
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
    
    func loadSubscriptions(completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
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
    
    func searchFriends(predicate: String, completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
        Api.UserList.searchFriends(predicate).request.responseJSON { response in
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
    
    func searchSubscribers(predicate: String, completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
        Api.UserList.searchSubscribers(predicate).request.responseJSON { response in
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
    
    func searchSubscriptions(predicate: String, completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
        Api.UserList.searchSubscriptions(predicate).request.responseJSON { response in
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
    
    func searchFriends(cursor: String, completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
        Api.UserList.friendsMore(cursor).request.responseJSON { response in
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
    
    func searchSubscribers(cursor: String, completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
        Api.UserList.subscribersMore(cursor).request.responseJSON { response in
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
    
    func searchSubscriptions(cursor: String, completion: @escaping (Swift.Result<UserSearchListResponse?, NetworkError>) -> Void) {
        Api.UserList.subscriptionsMore(cursor).request.responseJSON { response in
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
