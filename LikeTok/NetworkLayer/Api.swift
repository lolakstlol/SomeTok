import Alamofire
import AlamofireMapper
import AlamofireNetworkActivityLogger
import AVFoundation

struct UploadResponse: Codable {
    let data: UploadDataClass
    let result: UploadResult
}

// MARK: - DataClass
struct UploadDataClass: Codable {
    let preview: String
}

// MARK: - Result
struct UploadResult: Codable {
    let message: String
    let status: Bool
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

protocol UploadCallback {
    func onSuccess(model: UploadResponse)
    func onFailure(_ error: Error)
}

enum Api {
    static var headers: HTTPHeaders = [:]
    public static func upload(_ fileData: Data, with key: String, fileExtension: String, to url: String, _ callback: UploadCallback) {
        Alamofire.upload(multipartFormData: { (data) in
            data.append(fileData, withName: key, fileName: "file\(Date().timeIntervalSince1970).\(fileExtension)", mimeType: "\(key)/*")
        }, to: url, method: .put, headers: Api.headers) { (encodingResult) in
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
        }
    }
    
    enum Comments: ApiMethod {
        case getInitialComments(uuid: String)
        case getComments(uuid: String, cursor: String)
        case postComments(uuid: String, text: String)
        
        public var request: DataRequest {
            switch self {
            case .getInitialComments(let uuid):
                
                let endPoint: String = "\(API.server)/user/post/\(uuid)/comments"
                let request = Alamofire.request(endPoint, method: .get, headers: Api.headers)
                return request.validate()
            
            case .postComments(let uuid, let text):
                
                let endPoint: String = "\(API.server)/user/post/\(uuid)/comments"
                let parameters: Parameters = ["message" : text]
                let request = Alamofire.request(endPoint, method: .post, parameters: parameters, headers: Api.headers)
                return request.validate()
                
            case .getComments(uuid: let uuid, cursor: let cursor):
                
                let endPoint: String = "\(API.server)/user/post/\(uuid)/comments"
                let parameters: Parameters = ["cursor" : cursor]
                let request = Alamofire.request(endPoint, method: .get, parameters: parameters, headers: Api.headers)
                return request.validate()
            }
        }
    }
    
    enum Camera: ApiMethod {
        case createPost(adv: Bool, title: String, text: String, tag: String, category: String)
        case publishPost(uuid: String)
        public var request: DataRequest {
            switch self {
            case .createPost(adv: let adv, title: let title, text: let text, let tag, let category):
                var params:Parameters = Parameters()
                if tag != "" {
                    params["tags"] = [tag]
                }
                if category != "" {
                    params["categories"] = [category]
                }
                params["adv"] = adv
                params["text"] = text
                params["title"] = title
                let request = Alamofire.request("\(API.server)/user/post", method: .post, parameters: params, encoding: URLEncoding(destination: .queryString), headers: Api.headers)
                return request.validate()
            case .publishPost(uuid: let uuid):
                var params:Parameters = Parameters()
                let request = Alamofire.request("\(API.server)/user/post/\(uuid)/publish", method: .put, parameters: params, encoding: URLEncoding(destination: .queryString), headers: Api.headers)
                return request.validate()
            }
        }
    }

    enum Feed: ApiMethod {
        case getInitialFeed(type: FeedViewEnterOption),
             getFeed(cursor: String, type: FeedViewEnterOption),
             createPostLike(postID: String),
             deletePostLike(postID: String)
        public var request: DataRequest {
            switch self {
            case let .getFeed(cursor, type):
                
                let endPoint: String = "\(API.server)/user/feed/\(type.rawValue)"
                let parameters: Parameters = [
                    "params": "",
                    "cursor": "\(cursor)"
                ]
            
                let request = Alamofire.request(endPoint, method: .get, parameters: parameters, headers: Api.headers)
                return request.validate()
                
            case let .getInitialFeed(type):
                
                let endpoint: String = "\(API.server)/user/feed/\(type.rawValue)"
                let parameters: Parameters = [
                    "params": ""
                ]
            
                let request = Alamofire.request(endpoint, method: .get, parameters: parameters, headers: Api.headers)
                return request.validate()
                
            case let .createPostLike(uuid):
                
                let endpoint: String = "\(API.server)/user/post/\(uuid)/like"
                let request = Alamofire.request(endpoint, method: .put, headers: Api.headers)
                return request.validate()
                
            case let .deletePostLike(uuid):
                
                let endpoint: String = "\(API.server)/user/post/\(uuid)/like"
                let request = Alamofire.request(endpoint, method: .put, headers: Api.headers)
                return request.validate()
            }
        }
    }
    
    enum Dictionary: ApiMethod {
        case city(name: String)
        case category(name: String)
        case country(name: String)
        case hashtag(name: String)
        public var request: DataRequest {
            switch self {
            case .city(let name):
                var params:Parameters = Parameters()
                params["name"] = name
                let request = Alamofire.request("\(API.server)/dictionary/cities", method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: Api.headers)
                return request.validate()
            case .category(let name):
                var params:Parameters = Parameters()
                params["name"] = name
                let request = Alamofire.request("\(API.server)/dictionary/categories", method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: Api.headers)
                return request.validate()
            case .country(let name):
                var params:Parameters = Parameters()
                params["name"] = name
                let request = Alamofire.request("\(API.server)/dictionary/countries", method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: Api.headers)
                return request.validate()
            case .hashtag(let name):
                var params:Parameters = Parameters()
                params["name"] = name
                let request = Alamofire.request("\(API.server)/dictionary/hashtags", method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: Api.headers)
                return request.validate()
            }
        }
    }
                
    enum Catalog: ApiMethod {
        case searchCategories(name: String)
        case searchAccounts(name: String)
        case searchVideos(tag: String)
        case categories(parent: CategoriesType?, filtres: CategoriesFiltres)
        public var request: DataRequest {
            switch self {
            case .searchCategories(name: let name):
                var params:Parameters = Parameters()
                params["name"] = name
                let request = Alamofire.request("\(API.server)/user/search/categories", method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: Api.headers)
                //request.request?.addValue(Locale.current.regionCode ?? "", forHTTPHeaderField: "LANG")
                return request.validate()
            case .searchAccounts(name: let name):
                var params:Parameters = Parameters()
                params["name"] = name
                let request = Alamofire.request("\(API.server)/user/search/account", method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: Api.headers)
                return request.validate()
            case .searchVideos(tag: let tag):
                var params: Parameters = Parameters()
                params["name"] = tag
                let request = Alamofire.request("\(API.server)/user/search/hashtag", method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: Api.headers)
                return request.validate()
            case .categories(parent: let parent, filtres: let filtres):
                var params:Parameters = Parameters()
                if let parent = parent {
                    params["parent_category"] = parent.rawValue
                }
                params["filters"] = [
                    "countries" : filtres.countries?.slug ?? "",
                    "cities" : filtres.cities?.slug ?? "",
                    "categories" : filtres.categories?.slug ?? ""
                ]
                let request = Alamofire.request("\(API.server)/user/mobile/feed", method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: Api.headers)
                return request.validate()
            }
        }
    }
    
    enum Auth: ApiMethod {
        case signup(email: String, name: String, pass: String),
             login (login: String, pass: String),
             confirmEmail(email: String, code: String),
             repeatCode(email: String),
             resetPass(email: String),
             confirmResetPass(email:String, pass: String, code: String),
             updateSettings(phone: String?, name: String?)
        public var request: DataRequest {
            switch self {
            case let .signup(email, name, pass):
                var params: Parameters = Parameters()
                params["email"] = email
                params["password"] = pass
                params["username"] = name
                params["type"] = "user"
                let request = Alamofire.request("\(API.server)/auth/signup", method: .post, parameters: params, encoding: JSONEncoding.default, headers: Api.headers)
                return request.validate()
            case let .login(login, pass):
                var params: Parameters = Parameters()
                params["login_or_email"] = login
                params["password"] = pass
                let request = Alamofire.request("\(API.server)/auth/login", method: .post, parameters: params, encoding: JSONEncoding.default, headers: Api.headers)
                return request.validate()
            case .confirmEmail(email: let email, code: let code):
                var params: Parameters = Parameters()
                params["email"] = email
                params["code_confirm"] = code
                let request = Alamofire.request("\(API.server)/auth/confirm", method: .put, parameters: params, encoding: JSONEncoding.default, headers: Api.headers)
                return request.validate()
            case .repeatCode(email: let email):
                var params: Parameters = Parameters()
                params["email"] = email
                let request = Alamofire.request("\(API.server)/auth/signup/code-repeat", method: .put, parameters: params, encoding: JSONEncoding.default, headers: Api.headers)
                return request.validate()
            case .resetPass(email: let email):
                var params: Parameters = Parameters()
                params["email"] = email
                let request = Alamofire.request("\(API.server)/auth/forgot", method: .put, parameters: params, encoding: JSONEncoding.default, headers: Api.headers)
                return request.validate()
            case .confirmResetPass(email: let email, pass: let pass, code: let code):
                var params: Parameters = Parameters()
                params["email"] = email
                params["password"] = pass
                params["code_confirm"] = code
                let request = Alamofire.request("\(API.server)/auth/password", method: .put, parameters: params, encoding: JSONEncoding.default, headers: Api.headers)
                return request.validate()
            case .updateSettings(phone: let phone, name: let name):
                var params: Parameters = Parameters()
                params["name"] = name
                params["phone"] = phone
                let request = Alamofire.request("\(API.server)/user/settings", method: .put, parameters: params, encoding: JSONEncoding.default, headers: Api.headers)
                return request.validate()
            }
        }
    }
    
    enum Profile: ApiMethod {
        case user(_ uuid: String)
        case settings
        case updateSettings(_ model: EditedProfileModel)
        case follow(_ uuid: String)
//        case feed(_ uuid: String)
        public var request: DataRequest {
            switch self {
            case .user(let uuid):
                let request = Alamofire.request("\(API.server)/user/\(uuid)", method: .get, encoding: URLEncoding(destination: .queryString), headers: Api.headers)
                //request.request?.addValue(Locale.current.regionCode ?? "", forHTTPHeaderField: "LANG")
                return request.validate()
                
            case .settings:
                let request = Alamofire.request("\(API.server)/user/settings", method: .get, encoding: URLEncoding(destination: .queryString), headers: Api.headers)
                //request.request?.addValue(Locale.current.regionCode ?? "", forHTTPHeaderField: "LANG")
                return request.validate()
            
            case .updateSettings(let model):
                var params: Parameters = Parameters()
                if let name = model.name, !name.isEmpty {
                    params["name"] = name
                }
                if let username = model.username, !username.isEmpty {
                    params["username"] = username
                }
                if let email = model.email, !email.isEmpty {
                    params["email"] = email
                }
                if let description = model.description, !description.isEmpty {
                    params["description"] = description
                }
                if let phone = model.phone, !phone.isEmpty {
                    params["phone"] = phone
                }
                if let country = model.country, !country.isEmpty {
                    params["country"] = country
                }
                if let city = model.city, !city.isEmpty  {
                    params["city"] = city
                }
                let request = Alamofire.request("\(API.server)/user/settings", method: .put, parameters: params, encoding: JSONEncoding.default, headers: Api.headers)
                return request.validate()
                
            case .follow(let uuid):
                let request = Alamofire.request("\(API.server)/user/\(uuid)/follow", method: .put, encoding: URLEncoding(destination: .queryString), headers: Api.headers)
                //request.request?.addValue(Locale.current.regionCode ?? "", forHTTPHeaderField: "LANG")
                return request.validate()
            }
        }
    }
    
    enum UserList: ApiMethod {
        case subscriptions
        case subscribers
        case friends
    
        public var request: DataRequest {
            switch self {
            case .subscriptions:
                let request = Alamofire.request("\(API.server)/user/subscriptions", method: .get, encoding: URLEncoding(destination: .queryString), headers: Api.headers)
                return request.validate()
            case .subscribers:
                let request = Alamofire.request("\(API.server)/user/subscribers", method: .get, encoding: URLEncoding(destination: .queryString), headers: Api.headers)
                return request.validate()
            case .friends:
                let request = Alamofire.request("\(API.server)/user/friends", method: .get, encoding: URLEncoding(destination: .queryString), headers: Api.headers)
                return request.validate()
            }
        }
    }
}
