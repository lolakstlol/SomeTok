//
//  FeedNewPresenter.swift
//  LikeTok
//
//  Created by Daniel on 17.01.22.
//

import Foundation

final class FeedNewPresenter {
    
    private unowned let view: FeedNewPresenterOutput
    private var feedService: FeedServiceProtocol?
    private var selectedItem: FeedResponse?
    private var type: FeedViewEnterOption = .advertisment {
        didSet {
            view.onChangedFilter()
        }
    }
    
    private var cursor: String? = nil

    var selectedUUID: String? {
        return selectedItem?.uuid
    }
    
    init(_ view: FeedNewPresenterOutput, _ feedService: FeedServiceProtocol, type: FeedViewEnterOption) {
        self.view = view
        self.type = type
        self.feedService = feedService
    }

    func viewDidLoad() {
        fetchInitialFeed()
    }

}

private extension FeedNewPresenter {
    
    func fetchInitialFeed() {
        feedService?.getInitialFeed(with: 0, type: type) { [weak self] result in
            self?.handleFeedRequstResult(result: result)
        }
    }
    
    func fetchMoreFeed(_ cursor: String) {
        feedService?.getFeed(with: 0, cursor: cursor, type: type, completion: { [weak self] result in
            self?.handleFeedRequstResult(result: result)
        })
    }
    
    
    func createPostLike(_ uuid: String) {
        feedService?.createPostLike(postId: uuid, completion: { [weak self] result in
            switch result {
            case .success(let likeData):
//                likeData.data.isLike
                self?.view.onLikeSuccess()
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self?.view.onLikeFailed()
            }
        })
    }
    
    func handleFeedRequstResult(result: Result<FeedGlobalResponse, NetworkError>) {
        switch result {
        case .success(let items):
            self.view.onFetchFeed(items.data.data)
            self.cursor = items.data.meta.cursor
            
        case .failure(let error):
            debugPrint(error.localizedDescription)
            
        }
    }
}

extension FeedNewPresenter: FeedNewPresenterInput {
    
    func updateSelectedItemLike() {
       
    }
    
    func didTapComments() {
        guard let uuid = selectedItem?.uuid else {
            return
        }
        view.onTapComments(uuid)
    }
    
    func selectItem(_ item: FeedResponse) {
        self.selectedItem = item
    }
    
    func updateFeedType(_ type: FeedViewEnterOption) {
        self.type = type
    }
    
    func reloadFeed() {
        fetchInitialFeed()
    }

    func fetchMoreFeed() {
        if let cursor = cursor {
            fetchMoreFeed(cursor)
        }
    }
    
    func likeAction() {
        guard let uuid = selectedItem?.uuid else {
            return
        }
        createPostLike(uuid)
    }
}
