//
//  FeedViewFeedViewInteractor.swift
//  marketplace
//
//  Created by Mikhail Lutskii on 20/11/2020.
//  Copyright © 2020 BSL. All rights reserved.
//
import Foundation
import CoreLocation

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
    
    func getFeed(with offset: Int, cursor: String) {
        isFeedLoading = true
        feedService.getFeed(with: offset, cursor: cursor, type: type, completion: { [weak output] result in
            output?.didReceivedFeed(with: offset, result: result)
            self.isFeedLoading = false
        })
    }
    
    func getInitialFeed(with offset: Int) {
        isFeedLoading = true
        feedService.getInitialFeed(with: offset, type: type) { [weak output] result in
            output?.didReceivedFeed(with: offset, result: result)
            self.isFeedLoading = false
        }
    }
    
    func updateType(_ type: FeedViewEnterOption) {
        self.type = type
    }
    
    func stopVideo() {
        output?.stopVideo()
    }
    
    func screenTapAction() {
        output?.didTapScreen()
    }
        
//        Api.feed.getFeed.request.responseJSON { response in
//            let code = response.response?.statusCode ?? 0
//            switch code {
//            case 200:
//                if let data = response.data, let response = try? JSONDecoder().decode(FeedGlobalResponse.self, from: data) {
//                    debugPrint("parse ok")
////                    completion(.success(response))
//                } else {
////                    completion(.failure(.deserialization))
//                }
//            default:
//                break
//            }
//        }
//        output?.didReceivedPost(with: .success(FeedResponse(uuid: "", adv: true, author: UserResponse(type: "", uuid: "", isFollow: false, isFriend: "", username: "", name: "", lastActive: "", photo: UserPhoto(preview: "")), title: "", text: "", isLiked: true, media: [Media(uuid: "", type: "", preview: "", original: "")], likes: 1, comments: 1, tags: [""], categories: [""], url: "")))
//        self.isFeedLoading = false
        
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
    func getPost(by postId: String, completion: @escaping (_ items: Swift.Result<FeedResponse?, NetworkError>) -> Void)
    func getInitialFeed(with offset: Int, type: FeedViewEnterOption, completion: @escaping (Result<FeedGlobalResponse, NetworkError>) -> Void)
    func getFeed(with offset: Int, cursor: String, type: FeedViewEnterOption, completion: @escaping (Result<FeedGlobalResponse, NetworkError>) -> Void)
    func deletePostLike(postId: String, completion: @escaping (Swift.Result<LikeResponse, NetworkError>) -> Void)
    func createPostLike(postId: String, completion: @escaping (Swift.Result<LikeResponse, NetworkError>) -> Void)
//    func getBusniessList(model: GetBusinessListRequestModel,
//                         completion: @escaping (_ result: Result<GetBusniessListResponse?, NetworkAPI.NetworkError>) -> Void)
}

final class FeedService: FeedServiceProtocol {
    
    func getPost(by uuid: String, completion: @escaping (Swift.Result<FeedResponse?, NetworkError>) -> Void) {
//        let request = GetCurrentPostRequest(uuid)
//        NetworkAPI.shared.sendRequest(request: request, completion: completion)
    }

    
    func getFeed(with offset: Int, cursor: String, type: FeedViewEnterOption, completion: @escaping (Swift.Result<FeedGlobalResponse, NetworkError>) -> Void) {
//        let request = FeedRequest(userId, offset)
//        Api.feed.getFeed.request.responseJSON(completionHandler: completion)
        Api.Feed.getFeed(cursor: cursor, type: type).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(FeedGlobalResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.deserialization))
                }
            default:
                completion(.failure(.badRequest))
                break
            }
        }
//        NetworkAPI.shared.sendRequest(request: request, completion: completion)
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
    
    func getInitialFeed(with offset: Int, type: FeedViewEnterOption, completion: @escaping (Swift.Result<FeedGlobalResponse, NetworkError>) -> Void) {
//        let request = FeedRequest(userId, offset)
//        Api.feed.getFeed.request.responseJSON(completionHandler: completion)
        Api.Feed.getInitialFeed(type: type).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(FeedGlobalResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    try? self.catchError(data: response.data!, type: FeedGlobalResponse.self)
                    completion(.failure(.deserialization))
                    
                }
            default:
                completion(.failure(.badRequest))
                break
            }
        }
//        NetworkAPI.shared.sendRequest(request: request, completion: completion)
    }
    
    func createPostLike(postId: String, completion: @escaping (Swift.Result<LikeResponse, NetworkError>) -> Void) {
        Api.Feed.createPostLike(postID: postId).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(LikeResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    try? self.catchError(data: response.data!, type: LikeResponse.self)
                    completion(.failure(.deserialization))
                    
                }
            default:
                completion(.failure(.badRequest))
                break
            }
        }
    }
        
//        let request = CreateLikeRequest(postId: postId)
//        NetworkAPI.shared.sendRequest(request: request, completion: completion)
    
    func deletePostLike(postId: String, completion: @escaping (Swift.Result<LikeResponse, NetworkError>) -> Void) {
        Api.Feed.createPostLike(postID: postId).request.responseJSON { response in
            let code = response.response?.statusCode ?? 0
            switch code {
            case 200:
                if let data = response.data, let response = try? JSONDecoder().decode(LikeResponse.self, from: data) {
                    completion(.success(response))
                } else {
                    try? self.catchError(data: response.data!, type: LikeResponse.self)
                    completion(.failure(.deserialization))
                    
                }
            default:
                completion(.failure(.badRequest))
                break
            }
        }
//        let request = DeleteLikeRequest(postId: postId)
//        NetworkAPI.shared.sendRequest(request: request, completion: completion)
    }
}
