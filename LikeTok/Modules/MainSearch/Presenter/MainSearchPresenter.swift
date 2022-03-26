import Foundation
import UIKit

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
    private let searchApiWorker: SearchApiWorker = SearchApiWorker()
    private let profileApiWorker: ProfileNetworkServiceProtocol = ProfileNetworkService()

    init(_ view: MainSearchPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
        
    }
    
    func loadAccounts(predict: String) {
        searchApiWorker.searchAccounts(tag: predict) { result in
            switch result {
            case .success(let accounts):
                self.view.setAccounts(models: accounts?.data.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadCategories(predict: String) {
        searchApiWorker.searchCategories(tag: predict) { result in
            switch result {
            case .success(let categories):
                self.view.setCategories(models: categories?.data?.data ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadVideos(predict: String) {
        searchApiWorker.searchTags(tag: predict) { result in
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
    
    func didTapVideo(_ dataSourse: [FeedPost], index: Int) {
        let feedViewController = FeedViewAssembler.createModule(type: .personal, collectionManager: FeedCollectionManager(), initialDataSourse: dataSourse, initialIndex: index)
        view.pushFeed(feedViewController)
    }
    
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
    
    func followButtonTap(_ uuid: String) {
        OtherProfileNetworkService(uuid: uuid).follow { [weak self] result in
            switch result {
            case .success(let followModel):
                if let following = followModel?.data.following {
                    self?.view.onFollowSuccess(following, uuid: uuid)
                } else {
                    self?.view.onFollowFailure(.noData)
                }
            
            case .failure(let error):
                self?.view.onFollowFailure(error)
            }
        }
    }
}
