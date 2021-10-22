import Alamofire
import AlamofireMapper
import AlamofireNetworkActivityLogger

class EUploadedFile: Codable {
    var url: String = ""
}


class API  {
    
    //http://cdn.fliji.com/api/v1/documentation
    private static var PROTOCOL: String = "https://"
    private static var SERVER: String = "cdn.likeeng.uk"
    private static var API_PATH: String = "/api/v1"
    
    static var server: String{
        get {
            return "\(PROTOCOL)\(SERVER)\(API_PATH)"
        }
    }
}

protocol uploadCallback {
    func onSuccess(model: EUploadedFile)
    func onFailed()
}

enum Api {
    static var headers: HTTPHeaders = [:]
    public static func upload(_ fileData: Data, with key: String, fileExtension: String, to url: String, _ callback: uploadCallback) {
        Alamofire.upload(multipartFormData: { (data) in
            data.append(fileData, withName: key, fileName: "file\(Date().timeIntervalSince1970).\(fileExtension)", mimeType: "\(key)/*")
        }, to: url, method: .post, headers: Api.headers) { (encodingResult) in
            switch encodingResult {
            case .success(let uploadRequest, let streamingFromDisk, let streamFileURL):
                uploadRequest.uploadProgress(closure: { (prg) in
                    let progr = prg.fractionCompleted
                    print("upload progress:\(progr)")
                    DispatchQueue.main.async() {
                        if (progr == 1){
                            //Обработка сервера
                        }
                    }
                })
                uploadRequest.validate().responseObject { (response: DataResponse<EUploadedFile>) in
                    switch response.result {
                    case .success(let value):
                        callback.onSuccess(model: value)
                        print("# uploadRequest: success")
                    case .failure(let error):
                        print(error)
                        callback.onFailed()
                        print("# uploadRequest: error")
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    enum auth: ApiMethod {
        case signup(email: String, name: String, pass: String),
             login (login: String, pass: String)
        public var request: DataRequest {
            switch self {
            case let .signup(email, name, pass):
                var params:Parameters = Parameters()
                params["email"] = email
                params["password"] = pass
                params["username"] = name
                let request = Alamofire.request("\(API.server)/auth/signup", method: .post, parameters: params, encoding: JSONEncoding.default, headers: Api.headers)
                return request.validate()
            case let .login(login, pass):
                var params:Parameters = Parameters()
                params["email"] = login
                params["password"] = pass
                let request = Alamofire.request("\(API.server)/auth/login", method: .post, parameters: params, encoding: JSONEncoding.default, headers: Api.headers)
                return request.validate()
            }
        }
    }
}
