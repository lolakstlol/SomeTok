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
}

final class ProfileNetworkService: ProfileNetworkServiceProtocol {
    
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
