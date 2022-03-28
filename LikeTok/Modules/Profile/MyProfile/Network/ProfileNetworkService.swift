//
//  ProfileNetworkService.swift
//  LikeTok
//
//  Created by Daniel on 19.02.22.
//

import Foundation

protocol ProfileNetworkServiceProtocol: AnyObject {
    func settings(completion: @escaping (Swift.Result<ProfileServerModel?, NetworkError>) -> Void)
    func updateSettings(_ model: EditedProfileModel, completion: @escaping (Swift.Result<BaseResponse?, NetworkError>) -> Void)
}

protocol OtherProfileNetworkServiceProtocol: AnyObject {
    func user(completion: @escaping (Swift.Result<OtherProfileServerModel?, NetworkError>) -> Void)
    func follow(completion: @escaping (Swift.Result<FollowResponse?, NetworkError>) -> Void)
}


final class FeedOtherNetworkService: FeedServiceProtocol {
    
    let uuid: String
    
    init(uuid: String) {
        self.uuid = uuid
    }
    
    func getInitialFeed(with offset: Int, type: FeedViewEnterOption, completion: @escaping (Result<FeedGlobalResponse, NetworkError>) -> Void) {
        Api.OtherProfile.getInitialFeed(type: type, uuid: uuid).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(FeedGlobalResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    try? self.catchError(data: response.data!, type: FeedGlobalResponse.self)
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func getFeed(with offset: Int, cursor: String, type: FeedViewEnterOption, completion: @escaping (Result<FeedGlobalResponse, NetworkError>) -> Void) {
        Api.OtherProfile.getFeed(cursor: cursor, uuid: uuid, type: type).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(FeedGlobalResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    try? self.catchError(data: response.data!, type: FeedGlobalResponse.self)
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func getPost(by postId: String, completion: @escaping (Result<FeedPost?, NetworkError>) -> Void) {

    }
    
    func deletePostLike(postId: String, completion: @escaping (Result<LikeResponse, NetworkError>) -> Void) {
        
    }
    
    func createPostLike(postId: String, completion: @escaping (Result<LikeResponse, NetworkError>) -> Void) {
        
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

final class FeedProfileNetworkService: FeedServiceProtocol {
    func getPost(by postId: String, completion: @escaping (Result<FeedPost?, NetworkError>) -> Void) {
        
    }
    
    func getInitialFeed(with offset: Int, type: FeedViewEnterOption, completion: @escaping (Result<FeedGlobalResponse, NetworkError>) -> Void) {
        Api.Profile.getInitialFeed(type: type).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(FeedGlobalResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    try? self.catchError(data: response.data!, type: FeedGlobalResponse.self)
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func getFeed(with offset: Int, cursor: String, type: FeedViewEnterOption, completion: @escaping (Result<FeedGlobalResponse, NetworkError>) -> Void) {
        Api.Profile.getFeed(cursor: cursor, type: type).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(FeedGlobalResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    try? self.catchError(data: response.data!, type: FeedGlobalResponse.self)
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func deletePostLike(postId: String, completion: @escaping (Result<LikeResponse, NetworkError>) -> Void) {
        
    }
    
    func createPostLike(postId: String, completion: @escaping (Result<LikeResponse, NetworkError>) -> Void) {
        
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

final class OtherProfileNetworkService: OtherProfileNetworkServiceProtocol {
    
    let uuid: String
    
    init(uuid: String) {
        self.uuid = uuid
    }
    
    func follow(completion: @escaping (Result<FollowResponse?, NetworkError>) -> Void) {
        Api.OtherProfile.follow(uuid).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(FollowResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func user(completion: @escaping (Swift.Result<OtherProfileServerModel?, NetworkError>) -> Void) {
        
        Api.OtherProfile.user(uuid).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(OtherProfileServerModel.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
}


final class ProfileNetworkService: ProfileNetworkServiceProtocol {
    
    func settings(completion: @escaping (Swift.Result<ProfileServerModel?, NetworkError>) -> Void) {
        
        Api.Profile.settings.request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(ProfileServerModel.self, from: data) {
                    completion(.success(response))
                } else {
                    try? self.catchError(data: response.data!, type: ProfileServerModel.self)
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func updateSettings(_ model: EditedProfileModel, completion: @escaping (Swift.Result<BaseResponse?, NetworkError>) -> Void) {
        
        Api.Profile.updateSettings(model).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            case 422: completion(.failure(.noData)) //
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
