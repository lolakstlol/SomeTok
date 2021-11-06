//
//  FeedViewFeedViewInteractor.swift
//  marketplace
//
//  Created by Mikhail Lutskii on 20/11/2020.
//  Copyright © 2020 BSL. All rights reserved.
//
import Foundation

final class FeedViewInteractor {
    private weak var output: FeedViewInteractorOutput?
    private let feedService: FeedServiceProtocol

    private var post: FeedResponse?
    private var isFeedLoading = false
    var isUserFeed = false
    var type: FeedViewEnterOption
    var configurators: [FeedCellConfigurator]?
    
    init(_ type: FeedViewEnterOption,
         _ feedService: FeedServiceProtocol){
        self.type = type
        self.feedService = feedService
    }
}

extension FeedViewInteractor: FeedViewInteractorInput {
    func attach(_ output: FeedViewInteractorOutput) {
        self.output = output
    }
    
    func getFeed(with offset: Int) {
//        switch type {
//        case .profilePosts(let info):
//            guard !isFeedLoading, configurators == nil else { return }
//            isFeedLoading = true
//
//            feedService.getFeed(by: info.0, with: offset) { [weak output] result in
//                output?.didReceivedFeed(with: offset, result: result)
//                self.isFeedLoading = false
//            }
//            self.output?.didSetUserId(with: info.1)
//        case .main:
//            guard !isFeedLoading else { return }
//            isFeedLoading = true
//
//            feedService.getFeed(by: nil, with: offset) { [weak output] result in
//                output?.didReceivedFeed(with: offset, result: result)
//                self.isFeedLoading = false
//            }
//        case .singlePost(let postId, _):
//            feedService.getPost(by: postId) { [weak output] result in
//                output?.didReceivedPost(with: result)
//            }
//        }
    }
    
    func subscribe(userId: String) {
//        subscriptionsService.subscribe(userId: userId) { [weak output] result in
//            output?.didSubscribe(with: result)
//        }
    }
    
    func unsubscribe(userId: String) {
//        subscriptionsService.unsubscribe(userId: userId) { [weak output] result in
//            output?.didUnsubscribe(with: result)
//        }
    }
    
    func createLike() {
//        guard let postId = post?.postId else { return }
//        feedService.createPostLike(postId: postId) { [weak output] result in
//            output?.didCreateLike(with: result)
//        }
    }
    
    func deleteLike() {
//        guard let postId = post?.postId else { return }
//        feedService.deletePostLike(postId: postId) { [weak output] result in
//            output?.didDeleteLike(with: result)
//        }
    }
    
    func isAuthorized() -> Bool {
//        return UserDefaultsManager.shared.userId != .none
        return true
    }
    
    func getUser() {
//        accountService.getUser(userId: UserDefaultsManager.shared.userId) { [weak output] result in
//            output?.didReceivedUser(with: result)
//        }
    }
    
    func sendMessage(_ message: String) {
//        guard let post = post, messageFormatter.isValid(message) else { return }
//
//        if isUserFeed {
//            commentsService.sendComment(postId: post.postId, text: messageFormatter.formatted(message)) { [weak output] result in
//                output?.didSendComment(with: result)
//            }
//        } else {
//            chatService.createChat(recipients: [post.user.userId],
//                                   messageType: .postReplay(message,
//                                                            post.media?.first?.payload.mainImageUrl ?? "", post.postId)) { [weak output] result in
//                output?.didSendChatMessage(with: result)
//            }
//        }
    }
    
    func setCurrentPost(_ post: FeedResponse) {
//        self.post = post
//        isUserFeed = post.user.userId == UserDefaultsManager.shared.userId
    }
}

protocol FeedServiceProtocol {
    func getPost(by postId: String, completion: @escaping (_ items: Result<FeedResponse?, NetworkError>) -> Void)
    func getFeed(by userId: String?, with offset: Int, completion: @escaping (_ items: Result<[FeedResponse]?, NetworkError>) -> Void)
    func deletePostLike(postId: String, completion: @escaping EmptyClosure)
    func createPostLike(postId: String, completion: @escaping EmptyClosure)
//    func getBusniessList(model: GetBusinessListRequestModel,
//                         completion: @escaping (_ result: Result<GetBusniessListResponse?, NetworkAPI.NetworkError>) -> Void)
}

final class FeedService: FeedServiceProtocol {
    
    func getPost(by postId: String, completion: @escaping (Result<FeedResponse?, NetworkError>) -> Void) {
//        let request = GetCurrentPostRequest(postId)
//        NetworkAPI.shared.sendRequest(request: request, completion: completion)
    }

    func getFeed(by userId: String?, with offset: Int, completion: @escaping (Result<[FeedResponse]?, NetworkError>) -> Void) {
//        let request = FeedRequest(userId, offset)
//        NetworkAPI.shared.sendRequest(request: request, completion: completion)
    }
    
    func createPostLike(postId: String, completion: @escaping EmptyClosure) {
//        let request = CreateLikeRequest(postId: postId)
//        NetworkAPI.shared.sendRequest(request: request, completion: completion)
    }
    
    func deletePostLike(postId: String, completion: @escaping EmptyClosure) {
//        let request = DeleteLikeRequest(postId: postId)
//        NetworkAPI.shared.sendRequest(request: request, completion: completion)
    }
}
