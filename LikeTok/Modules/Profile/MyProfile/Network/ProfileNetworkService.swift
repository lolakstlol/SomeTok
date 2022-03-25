//
//  ProfileNetworkService.swift
//  LikeTok
//
//  Created by Daniel on 19.02.22.
//

import Foundation

protocol ProfileNetworkServiceProtocol: AnyObject {
    func user(_ uuid: String, completion: @escaping (Swift.Result<OtherProfileServerModel?, NetworkError>) -> Void) 
    func settings(completion: @escaping (Swift.Result<ProfileServerModel?, NetworkError>) -> Void)
    func updateSettings(_ model: EditedProfileModel, completion: @escaping (Swift.Result<BaseResponse?, NetworkError>) -> Void)
    func follow(_ uuid: String, completion: @escaping (Swift.Result<FollowResponse?, NetworkError>) -> Void)
    
    func feedPersonal(completion: @escaping (Swift.Result<FeedGlobalResponse?, NetworkError>) -> Void)
    func feedPersonalMore(cursor: String, completion: @escaping (Swift.Result<FeedGlobalResponse?, NetworkError>) -> Void)
    func feedAdvertisment(completion: @escaping (Swift.Result<FeedGlobalResponse?, NetworkError>) -> Void)
    func feedAdvertismentMore(cursor: String, completion: @escaping (Swift.Result<FeedGlobalResponse?, NetworkError>) -> Void)
    
//    func feedPersonal(uuid: String, completion: @escaping (Swift.Result<FeedGlobalResponse?, NetworkError>) -> Void)
//    func feedPersonalMore(uuid: String, cursor: String, completion: @escaping (Swift.Result<FeedGlobalResponse?, NetworkError>) -> Void)
    func feedAdvertisment(uuid: String, completion: @escaping (Swift.Result<FeedGlobalResponse?, NetworkError>) -> Void)
    func feedAdvertismentMore(uuid: String, cursor: String, completion: @escaping (Swift.Result<FeedGlobalResponse?, NetworkError>) -> Void)
}

final class ProfileNetworkService: ProfileNetworkServiceProtocol {
    
    func feedAdvertisment(uuid: String, completion: @escaping (Result<FeedGlobalResponse?, NetworkError>) -> Void) {
        Api.Profile.feedAdvertismentOther(uuid).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(FeedGlobalResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func feedAdvertismentMore(uuid: String, cursor: String, completion: @escaping (Result<FeedGlobalResponse?, NetworkError>) -> Void) {
        Api.Profile.feedAdvertismentOtherMore(uuid: uuid, cursor).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(FeedGlobalResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func feedPersonalMore(cursor: String, completion: @escaping (Result<FeedGlobalResponse?, NetworkError>) -> Void) {
        Api.Profile.feedPersonalMore(cursor).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(FeedGlobalResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func feedAdvertismentMore(cursor: String, completion: @escaping (Result<FeedGlobalResponse?, NetworkError>) -> Void) {
        Api.Profile.feedAdvertismentMore(cursor).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(FeedGlobalResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    
    func feedPersonal(completion: @escaping (Result<FeedGlobalResponse?, NetworkError>) -> Void) {
        Api.Profile.feedPersonal.request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(FeedGlobalResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func feedAdvertisment(completion: @escaping (Result<FeedGlobalResponse?, NetworkError>) -> Void) {
        Api.Profile.feedAdvertisment.request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(FeedGlobalResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    
    func follow(_ uuid: String, completion: @escaping (Result<FollowResponse?, NetworkError>) -> Void) {
        Api.Profile.follow(uuid).request.responseJSON { response in
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
    
    func user(_ uuid: String, completion: @escaping (Swift.Result<OtherProfileServerModel?, NetworkError>) -> Void) {
        
        Api.Profile.user(uuid).request.responseJSON { response in
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
