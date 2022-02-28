import UIKit
import Alamofire

final class CameraApiWorker {
    
    class EUploadedFile: Codable {
        var url: String = ""
    }
    
    public static func upload(_ fileData: Data, with key: String, fileExtension: String, to url: String, _ callback: UploadCallback) {
        Alamofire.upload(multipartFormData: { (data) in
            data.append(fileData, withName: key, fileName: "file\(Date().timeIntervalSince1970).\(fileExtension)", mimeType: "\(key)/*")
        }, to: url, method: .post, headers: Api.headers) { (encodingResult) in
            switch encodingResult {
            case .success(let uploadRequest, _, _):
                uploadRequest.uploadProgress(closure: { (prg) in
                    let progr = prg.fractionCompleted
                    print("upload progress:\(progr)")
                    DispatchQueue.main.async() {
                        if (progr == 1){
                            //Обработка сервера
                        }
                    }
                })
                uploadRequest.validate().responseObject { (response: DataResponse<UploadResponse>) in
                    switch response.result {
                    case .success(let value):
                        callback.onSuccess(model: value)
                        print("# uploadRequest: success")
                    case .failure(let error):
                        print(error)
                        callback.onFailure(error)
                        print("# uploadRequest: error")
                    }
                }
                
            case .failure(let error):
                print(error)
            }
            //**//
        }
    }
    
    func recoveryPassword(_ email: String, password: String, code: String, completion: @escaping (Swift.Result<RecoveryPasswordCodeResponse?, NetworkError>) -> Void) {
        Api.Auth.confirmResetPass(email: email, pass: password, code: code).request.responseJSON { response in
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
