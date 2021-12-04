import Foundation

struct SearchPaginationModel {
    var page: Int
    var lastpredict: String?
}

enum MainSearchTypes {
    case people
    case tags
    case categories
}

final class MainSearchPresenter {
    private unowned let view: MainSearchPresenterOutput
    private let apiWorker: SearchApiWorker = SearchApiWorker()

    init(_ view: MainSearchPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
        
    }
    
    func loadAccounts(predict: String) {
        apiWorker.searchAccounts(tag: predict) { result in
            switch result {
            case .success(let accounts):
                self.view.setAccounts(models: accounts?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadCategories(predict: String) {
        apiWorker.searchCategories(tag: predict) { result in
            switch result {
            case .success(let categories):
                self.view.setCategories(models: categories?.data?.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadVideos(predict: String) {
        apiWorker.searchTags(tag: predict) { result in
            switch result {
            case .success(let videos):
                self.view.setVideos(models: videos?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MainSearchPresenter: MainSearchPresenterInput {
    func load(predict: String, type: MainSearchTypes) {
        switch type {
        case .people:
            loadAccounts(predict: predict)
        case .tags:
            loadVideos(predict: predict)
        case .categories:
            loadCategories(predict: predict)
        }
    }
}
