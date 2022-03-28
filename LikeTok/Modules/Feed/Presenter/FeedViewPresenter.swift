//
//  FeedViewFeedViewPresenter.swift
//  marketplace
//
//  Created by Mikhail Lutskii on 20/11/2020.
//  Copyright © 2020 BSL. All rights reserved.
//
// swiftlint:disable file_length

import Foundation
import UIKit.UIImage
import os.log

final class FeedViewPresenter {
    private let interactor: FeedViewInteractorInput
    private weak var view: FeedViewPresenterOutput?
    private var post: FeedPost?
    private var postIndex: Int?
    private var initialDataSourse: [FeedPost]
    private var cursor: String = ""
    
    init(_ interactor: FeedViewInteractorInput,
         _ view: FeedViewPresenterOutput,
         _ initialDataSourse: [FeedPost],
         _ initialCursor: String,
         _ initialIndex: Int) {
        self.interactor = interactor
        self.view = view
        self.initialDataSourse = initialDataSourse
        self.cursor = initialCursor
        self.postIndex = initialIndex
    }

    func viewDidLoad() {
        interactor.attach(self)
        view?.setupUI()
        if initialDataSourse.isEmpty {
            interactor.getInitialFeed(with: .zero)
            interactor.getUser()
            view?.setNavigationBarHidden(true)
        } else {
            setupInitialConfigurators(with: .zero)
            view?.setNavigationBarHidden(false)
            view?.setInitialIndex(postIndex ?? 0)
        }
    }
    
    func viewDidAppear() {
        interactor.playVideo()
    }
    
    func viewWillDisappear() {
        interactor.stopVideo()
    }
    
    private func feedFailureBlock(error: (NetworkError)) {
        switch error {
        case .other(statusCode: let statusCode):
            if statusCode == 426 {
                DispatchQueue.main.async {
                    self.view?.updateConfigurators([])
                }
            }
        default:
            DispatchQueue.main.async {
                self.view?.updateConfigurators([])
            }
        }
    }
    
    private func setupInitialConfigurators(with offset: Int) {
        guard !initialDataSourse.isEmpty else {
            return
        }
//        self.cursor = response.data.meta.cursor ?? ""
        var feedConfigurators = [FeedCellConfigurator]()
        initialDataSourse.forEach {
            var isMainFeed = true
            switch interactor.type {
            case .mainAdvertisment, .mainAll:
                isMainFeed = false
            default:
                isMainFeed = true
            }
            let configurator = FeedCellConfigurator($0, isMainFeed: isMainFeed)
            feedConfigurators.append(configurator)
        }
        guard feedConfigurators.count != .zero else { return }
        DispatchQueue.main.async {
            self.view?.hideActivityIndicator()
            if offset != .zero, self.interactor.configurators != nil {
                self.interactor.configurators! += feedConfigurators
                self.view?.updateConfigurators(feedConfigurators)//self.interactor.configurators ?? [])
            } else {
                if let post = self.initialDataSourse.first {
                    self.interactor.setCurrentPost(post)
                }
                self.interactor.configurators = feedConfigurators
                self.view?.updateConfigurators(feedConfigurators)
            }
        }
    }
    
    @objc private func userWasSubscribed(notification: NSNotification) {
//        guard let isSubscribed = notification.userInfo?[post?.user.userId ?? ""] as? Bool else { return }
//        post?.user.isSubscribed = isSubscribed
    }
}

// MARK: - FeedViewPresenterInput

extension FeedViewPresenter: FeedViewPresenterInput {
    func subscribeTapAction() {
//        guard interactor.isAuthorized(), let post = post else {
//            router.presentAuthModule {}
//            return
//        }
//
//        if !(post.user.isSubscribed ?? false) {
//            interactor.subscribe(userId: post.user.userId)
    }
    
//    func updateFeedEnterOption(_ enterOption: FeedViewEnterOption){
////        interactor.updateType(type)
////        getFeedWithScrollToTop()
//        delegate?.didChangedPage(with: enterOption)
//    }
    
    func screenTapAction() {
        interactor.screenTapAction()
    }
    
    func shouldShowFilledLikes() -> Bool {
        return interactor.isAuthorized()
    }
    
    func shouldShowActivityIndicator() -> Bool {
        switch self.interactor.type {
        case .mainFollowing:
            return true
        default:
            return false
        }
    }

    func setCommentsCount(with count: Int) {
        post?.comments = count
        guard let post = self.post, let index = self.postIndex else { return }
        self.view?.updateItem(with: post, at: index)
    }

    func likeTouchUpInside(_ type: LikeActionType) {
        guard interactor.isAuthorized(), let post = post else {
//            router.presentAuthModule {}
            return
        }
//
        if post.isLiked {
            guard type == .iconTap else { return }
            interactor.deleteLike()
            likeAction(.empty)
        } else {
            interactor.createLike()
            likeAction(.filled)
        }

//        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    func shareTouchUpInside(postUUID: String) {
        print(postUUID)
        interactor.createShareLink(postUUID: postUUID)
    }

    func isMoreButtonVisible() -> Bool {
        return !interactor.isUserFeed
    }
    
    func feedIsScrollingToEnd(with offset: Int) {
        guard !cursor.isEmpty else {
            return
        }
        interactor.getFeed(with: offset, cursor: cursor)
    }
    
    func closeButtonTouchUpInside() {
//        router.dismiss()
    }
    
    func profileTouchUpInside() {
        guard let uuid = post?.author.uuid else { return }
        view?.openProfile(uuid)
//        switch interactor.type {
//        case .profilePosts:
//            router.dismiss()
//        default:
//            if post?.user.profileType == Constants.Profile.business {
//                router.presentBussniesUserProfile(profileId: userId)
//            } else {
//                router.presentUserProfile(userId: userId)
//            }
//        }
    }
    
    func moreTouchUpInside() {
//        guard interactor.isAuthorized() else {
//            router.presentAuthModule {}
//            return
//        }
//
//        router.presentDeleteModule(postId: post?.postId, userId: post?.user.userId) { [weak self] in
//            guard let self = self, let postIndex = self.postIndex else { return }
//            switch self.interactor.type {
//            case .profilePosts:
//                self.interactor.configurators = nil
//                self.interactor.getFeed(with: .zero)
//                self.view?.scrollToTop()
//            case .main:
//                let count = self.interactor.configurators?.count ?? .zero
//                self.interactor.configurators?.removeLast(count - postIndex)
//                self.interactor.getFeed(with: postIndex)
//            default:
//                return
//            }
//        }
    }

    func setCurrentPost(_ post: FeedPost) {
        self.post = post
        interactor.setCurrentPost(post)
        postIndex = (interactor.configurators?.firstIndex(where: { $0.getModel().uuid == post.uuid })) ?? .zero
    }
    
    func openComments() {
        guard let post = post else { return }
        view?.openComments(post.uuid)

//        guard let post = post else { return }
//        router.openComments(postId: post.postId, userId: post.user.userId)
    }
    
    func getFeed() {
        interactor.getInitialFeed(with: .zero)
    }
    
    func getFeedWithScrollToTop() {
//        interactor.configurators = []
        interactor.getInitialFeed(with: .zero)
        view?.scrollToTop()
        view?.clearConfigurators()
    }
    
    func shareLink(link: String) {
        
           // Setting url
           let secondActivityItem : NSURL = NSURL(string: link)!
           
           let activityViewController : UIActivityViewController = UIActivityViewController(
               activityItems: [secondActivityItem], applicationActivities: nil)
           
           // This lines is for the popover you need to show in iPad
           activityViewController.popoverPresentationController?.sourceView = (view as! UIViewController).view
           
           // Pre-configuring activity items
           activityViewController.activityItemsConfiguration = [
           UIActivity.ActivityType.message
           ] as? UIActivityItemsConfigurationReading
           
           // Anything you want to exclude
           activityViewController.excludedActivityTypes = [
               UIActivity.ActivityType.postToWeibo,
               UIActivity.ActivityType.print,
               UIActivity.ActivityType.assignToContact,
               UIActivity.ActivityType.saveToCameraRoll,
               UIActivity.ActivityType.addToReadingList,
               UIActivity.ActivityType.postToFlickr,
               UIActivity.ActivityType.postToVimeo,
               UIActivity.ActivityType.postToTencentWeibo,
               UIActivity.ActivityType.postToFacebook
           ]
           
           activityViewController.isModalInPresentation = true
           (view as! UIViewController).present(activityViewController, animated: true, completion: nil)
    }
}

// MARK: - FeedViewInteractorOutput

extension FeedViewPresenter: FeedViewInteractorOutput {
    func didReceivedShareLink(with link: String) {
        shareLink(link: link)
    }
    
    func didTapScreen() {
        view?.tapScreenAction()
    }
    
    func stopVideo() {
        view?.stopVideo()
    }
    
    func playVideo() {
        view?.playVideo()
    }
    
    func didReceivedPost(with result: Result<FeedPost?, NetworkError>) {
        switch result {
         case .success(let response):
             guard let categoriesRespone = response else {
//                 router.dismiss()
                 return
             }
             var isMainFeed = true
             switch interactor.type {
             case .mainAll, .mainAdvertisment:
                 isMainFeed = false
             default:
                 isMainFeed = true
             }
             let feedConfigurators = FeedCellConfigurator(categoriesRespone, isMainFeed: isMainFeed)
             DispatchQueue.main.async { [weak self] in
                 self?.view?.updateConfigurators([feedConfigurators])
//                 switch self?.interactor.type {
//                 case .singlePost(let postId, let flag):
////                     if let userId = UserDefaultsManager.shared.userId, flag {
////                         self?.router.openComments(postId: postId, userId: userId)
////                     }
//                     print(" didReceivedPost .single post")
//                 default: break
//                 }
             }
         case .failure:
             DispatchQueue.main.async {
                 self.view?.updateConfigurators([])
//                 self.router.dismiss()
             }
         }
    }
    
    func didReceivedFeed(with offset: Int, result: Result<FeedGlobalResponse, NetworkError>) {
        switch result {
        case .success(let response):
            let categoriesRespone = response.data.data
            self.cursor = response.data.meta.cursor ?? ""
//            DispatchQueue.main.async {
//                self.view?.updateConfigurators([])
//            }
            var feedConfigurators = [FeedCellConfigurator]()
            categoriesRespone.forEach {
                var isMainFeed = true
                switch interactor.type {
                case .mainAdvertisment, .mainAll:
                    isMainFeed = false
                default:
                    isMainFeed = true
                }
                let configurator = FeedCellConfigurator($0, isMainFeed: isMainFeed)
                feedConfigurators.append(configurator)
            }
            guard feedConfigurators.count != .zero else { return }
            DispatchQueue.main.async {
                self.view?.hideActivityIndicator()
                if offset != .zero, self.interactor.configurators != nil {
                    self.interactor.configurators! += feedConfigurators
                    self.view?.updateConfigurators(feedConfigurators)//self.interactor.configurators ?? [])
                } else {
                    if let post = categoriesRespone.first {
                        self.interactor.setCurrentPost(post)
                    }
                    self.interactor.configurators = feedConfigurators
                    self.view?.updateConfigurators(feedConfigurators)
                }
            }
        case .failure(let error):
            switch error {
            case .notAuthorized:
                NotificationCenter.default.post(name: .userLoggedOut, object: self)
            default:
                feedFailureBlock(error: error)
            }
        }
    }
    
    func didReceivedUser(with result: Result<UserInfoResponse?, NetworkError>) {
        switch result {
        case .success(let response):
            guard let user = response else { return }
            DispatchQueue.main.async {
//                self.view?.setupAddress(with: user.location?.address ?? "")
            }
        case .failure(let error):
            os_log("@", error.localizedDescription)
        }
    }
    
    func didCreateLike(with result: Result<LikeResponse, NetworkError>) {
        switch result {
        case .success(_):
            debugPrint("put like success")
        case .failure(let error):
            debugPrint(error.localizedDescription)
        }
    }
    
    func didDeleteLike(with result: Result<LikeResponse, NetworkError>) {
        switch result {
        case .success(_):
            debugPrint("delete like success")
        case .failure(let error):
            debugPrint(error.localizedDescription)
        }
    }
    
    func likeAction(_ type: LikeType) {
        view?.setupLike(type, at: postIndex)
        post?.isLiked.toggle()
        post?.likes += type == .filled ? 1 : -1
        guard let post = self.post, let index = self.postIndex else { return }
        self.view?.updateItem(with: post, at: index)
    }
    
    func didSubscribe(with result: Result<SubscribeResponse?, NetworkError>) {
        switch result {
        case .success:
            DispatchQueue.main.async {
                self.post?.author.isFollow = true
                guard let post = self.post, let index = self.postIndex else { return }
                self.view?.updateItem(with: post, at: index)

//                NotificationCenter.default.post(name: .userWasSubscribed, object: nil, userInfo: [post.user.userId: post.user.isSubscribed ?? false])
            }
        case .failure(let error):
            os_log("@", error.localizedDescription)
        }
    }
    
    func didUnsubscribe(with result: Result<SubscribeResponse?, NetworkError>) {
        switch result {
        case .success:
            DispatchQueue.main.async {
                self.post?.author.isFollow = false
                guard let post = self.post, let index = self.postIndex else { return }
                self.view?.updateItem(with: post, at: index)

//                NotificationCenter.default.post(name: .userWasSubscribed, object: nil, userInfo: [post.user.userId: post.user.isSubscribed ?? false])
            }
        case .failure(let error):
            os_log("@", error.localizedDescription)
        }
    }
    
    func didSetUserId(with index: Int) {
        view?.setupUserFeed(with: index)
    }
    
}

