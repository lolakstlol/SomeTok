import Foundation

final class SearchApiWorker {
    func searchTags(tag: String, completion: @escaping (Swift.Result<SearchTagsResponse?, NetworkError>) -> Void) {
        Api.Catalog.searchVideos(tag: tag).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(SearchTagsResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    try? self.catchError(data: response.data!, type: SearchTagsResponse.self)
                    completion(.failure(.deserialization))
                }
            case 204: completion(.failure(.noData))
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func searchAccounts(tag: String, completion: @escaping (Swift.Result<SearchAccountsResponse?, NetworkError>) -> Void) {
        Api.Catalog.searchAccounts(name: tag).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(SearchAccountsResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    try? self.catchError(data: response.data!, type: SearchAccountsResponse.self)
                    completion(.failure(.deserialization))
                }   
            case 204: completion(.failure(.noData))
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func searchCategories(tag: String, completion: @escaping (Swift.Result<CategoriesResponse?, NetworkError>) -> Void) {
        Api.Catalog.searchCategories(name: tag).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(CategoriesResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    try? self.catchError(data: response.data!, type: CategoriesResponse.self)
                    completion(.failure(.deserialization))
                }
            case 204: completion(.failure(.noData))
            default: completion(.failure(.undefined))
            }
        }
    }
    
    func getCatalogFeed(type: CategoriesType, filtres: CategoriesFiltres, completion: @escaping (Swift.Result<CategoriesResponse?, NetworkError>) -> Void) {
        Api.Catalog.categories(parent: type, filtres: filtres).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(CategoriesResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    try? self.catchError(data: response.data!, type: CategoriesResponse.self)
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