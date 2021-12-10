//
//  NetworkApi.swift
//  LikeTok
//
//  Created by Daniel on 9.12.21.
//

import Alamofire
import Foundation
import os.log

final class NetworkAPI {
    typealias SendRequestCompletion<Request: BaseRequestProtocol> =
        (Swift.Result<Request.Response?, NetworkError>) -> Void
    typealias SendLiveRequestCompletion<Request: BaseRequestProtocol> =
        (Swift.Result<Request.Response?, NetworkError>) -> Void
    typealias SendMockRequestCompletion<Request: BaseRequestProtocol> =
        (Swift.Result<Request.Response?, NetworkError>) -> Void
    
    static let shared = NetworkAPI()
    private let networkReachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    private var attemps = 0
    private var maxAttemps = 10
    private init() {}

    func listenForReachability(_ completion: @escaping (NetworkError) -> Void) {
        networkReachabilityManager?.startListening()
    }

    private func sendLiveRequest<Request: BaseRequestProtocol>(request: Request,
                                                               completion:
                                                                @escaping SendLiveRequestCompletion<Request>) {
        guard let urlRequest = request.urlRequest else {
            completion(.failure(.noUrlRequest))
            return
        }

        Alamofire.request(urlRequest).responseJSON(queue: .global()) { dataResponse in
            print(dataResponse.result)
            if let code = dataResponse.response?.statusCode {
                switch code {
                case 200 ... 299:
                    self.attemps = 0
                    if let data = dataResponse.data {
                        try? self.catchError(data: data, type: Request.Response.self)
                        if let response = try? JSONDecoder().decode(Request.Response.self, from: data) {
                            completion(.success(response))
                        } else {
                            completion(.failure(.deserialization))
                        }
                    } else {
                        if let headers = dataResponse.response?.allHeaderFields {
                            let baseResponse = BaseResponse()
                            baseResponse.headers = headers
                            completion(.success(baseResponse as? Request.Response))
                        } else {
                            completion(.failure(.noData))
                        }
                    }
                case 400:
                    completion(.failure(.badRequest))
                case 401:
                    completion(.failure(.notAuthorized))
                case 426:
                    completion(.failure(.upgradeRequired))
                case 500:
                    self.attemps += 1
                    if self.attemps <= self.maxAttemps {
                        self.sendRequest(request: request, completion: completion)
                    } else {
                        completion(.failure(.other(statusCode: code)))
                    }
                default:
                    #if Debug
                        os_log("Error in request: ")
                        dump(request)
                    #endif
                    completion(.failure(.other(statusCode: code)))
                    return
                }
            } else {
                completion(.failure(.undefined))
            }
        }
    }
    
    func sendRequest<Request: BaseRequestProtocol>(request: Request,
                                                   completion:
                                                    @escaping SendRequestCompletion<Request>) {
            sendLiveRequest(request: request) { completion($0) }
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
