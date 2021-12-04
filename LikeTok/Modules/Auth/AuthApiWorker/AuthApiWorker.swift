import Alamofire
import Foundation

enum NetworkError: Error {
    case noUrlRequest
    case deserialization
    case notAuthorized
    case noData
    case badRequest
    case urlSessionError(error: String)
    case other(statusCode: Int)
    case undefined
    case parsing
    case upgradeRequired
    case lostConnection
    case success
}

struct SignUpUserModel {
    let email: String
    let pass: String
    let name: String
}

final class AuthApiWorker {
    
    func signUP(username: String, mail: String, password: String, completion: @escaping (Swift.Result<SignUpResponse?, NetworkError>) -> Void) {
        Api.auth.signup(email: mail, name: username, pass: password).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(SignUpResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func updateSettings(name: String?, phone: String?, completion: @escaping (Swift.Result<SignUpResponse?, NetworkError>) -> Void) {
        Api.auth.updateSettings(phone: phone, name: name).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(SignUpResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func signIn(username: String, password: String, completion: @escaping (Swift.Result<SignInResponse?, NetworkError>) -> Void) {
        Api.auth.login(login: username, pass: password).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(SignInResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func confirmMail(code: String, mail: String, completion: @escaping (Swift.Result<SignUpResponse?, NetworkError>) -> Void) {
        Api.auth.confirmEmail(email: mail, code: code).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(SignUpResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func repeatCode( mail: String, completion: @escaping (Swift.Result<SignUpResponse?, NetworkError>) -> Void) {
        Api.auth.repeatCode(email: mail).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(SignUpResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func recoveryPassword(_ email: String, completion: @escaping (Swift.Result<RecoveryPasswordCodeResponse?, NetworkError>) -> Void) {
        Api.auth.resetPass(email: email).request.responseJSON { response in
            guard let statusCode = response.response?.statusCode
            else {
                return
            }
            switch statusCode {
            case 200:
                if let data = response.data,
                   let response = try? JSONDecoder().decode(RecoveryPasswordCodeResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
                
            }
        }
    }
    
    func recoveryPassword(_ email: String, password: String, code: String, completion: @escaping (Swift.Result<RecoveryPasswordCodeResponse?, NetworkError>) -> Void) {
        Api.auth.confirmResetPass(email: email, pass: password, code: code).request.responseJSON { response in
            guard let statusCode = response.response?.statusCode
            else {
                return
            }
            switch statusCode {
            case 200:
                if let data = response.data,
                   let response = try? JSONDecoder().decode(RecoveryPasswordCodeResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default: completion(.failure(.undefined))
                
            }
        }
    }
    
    func uploadAvatar(image: UIImage, completion: @escaping (Swift.Result<Any?, NetworkError>) -> Void) {
    //        Api.profile.uploadAvatar(image: image) { result in
    //            print(result)
    //        }.request.responseJSON { response in
    //            print(response)
    //        }
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
