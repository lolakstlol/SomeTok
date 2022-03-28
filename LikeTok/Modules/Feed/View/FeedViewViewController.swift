//
//  FeedViewFeedViewViewController.swift
//  marketplace
//
//  Created by Mikhail Lutskii on 20/11/2020.
//  Copyright © 2020 BSL. All rights reserved.
//

import UIKit
import Kingfisher

final class FeedViewViewController: BaseViewController {
    
    // MARK: - @IBOutlets
    
    @IBOutlet private var customNavigationView: UIView!
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public properties

    var presenter: FeedViewPresenterInput!
    var collectionManager: FeedCollectionManagement?

    // MARK: - Lifecycle

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    @IBAction private func backButtonTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private methods
    
    @objc private func updateFeed() {
        presenter.getFeedWithScrollToTop()
    }
    
    @objc private func updateSettings() {
//        DispatchQueue.main.async { [weak self] in
//            self?.setupAddress(with: UserDefaultsManager.shared.lastUserLocation ?? "")
    
    }
}

// MARK: - FeedViewPresenterOutput

extension FeedViewViewController: FeedViewPresenterOutput {
    func setInitialIndex(_ index: Int) {
        collectionManager?.scrollToIndex(index)
    }
    
    func setNavigationBarHidden(_ hidden: Bool) {
        customNavigationView.isHidden = hidden
    }
    
    func tapScreenAction() {
//        collectionManager?.tapScreenAction()
    }
    
    func stopVideo() {
        collectionManager?.stopVideo()
    }
    
    func playVideo() {
        collectionManager?.playVideo()
    }
    
    func openComments(_ uuid: String) {
        let commentsViewController = CommentsAssembler.createModule(delegate: self, uuid: uuid)
        presentPanModal(commentsViewController)
    }
    
    func openProfile(_ uuid: String) {
        let otherProfileViewController = OtherProfileAssembler.createModule(uuid)
//        otherProfileViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(otherProfileViewController, animated: true)
    }
    
    func setupLike(_ type: LikeType, at index: Int?) {
        collectionManager?.updateCellLikes(type: type, at: index)
    }
    
    func hideActivityIndicator() {
        activityIndicator.isHidden = true
    }
    
    func updateItem(with model: FeedPost, at index: Int) {
        collectionManager?.updateItem(with: model, at: index)
    }
    
    func setupUserFeed(with index: Int) {
        collectionManager?.setFeedIndex(index)
    }
    
    func setupUI() {
        showLoader()
        collectionManager?.attach(collectionView)
        collectionManager?.output = self
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(updateFeed),
                                       name: .updateFeed,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(updateSettings),
                                       name: .updateSettings,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(updateFeed),
                                       name: .userAuthorized,
                                       object: nil)
        
    }
    
    func updateConfigurators(_ configurators: [FeedCellConfigurator]) {
        collectionManager?.update(with: configurators)
        hideLoader()
    }
    
    func clearConfigurators() {
        collectionManager?.clearConfigurators()
    }
    
    func scrollToTop() {
        collectionManager?.scrollToIndex(.zero)
    }
}

// MARK: - FeedCollectionOutput

extension FeedViewViewController: FeedCollectionOutput {
    func showActivityIndicator() {
        guard activityIndicator.isHidden, presenter.shouldShowActivityIndicator() else { return }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        activityIndicator.isHidden.toggle()
        presenter.getFeed()
    }
    
    func isMoreButtonVisible() -> Bool {
        return presenter.isMoreButtonVisible()
    }
    
    func attach() -> FeedCellActionsOutput {
        return self
    }
    
    func requestNextPosts(offset: Int) {
        presenter.feedIsScrollingToEnd(with: offset)
    }
    
    func selectFeedItem(_ item: FeedPost) {
        presenter.setCurrentPost(item)
    }
    
    func shouldShowFilledLikes() -> Bool {
        return presenter.shouldShowFilledLikes()
    }
}

// MARK: - FeedCellActionsOutput

extension FeedViewViewController: FeedCellActionsOutput {
    func shareTapAction(postUUID: String) {
        presenter.shareTouchUpInside(postUUID: postUUID)
    }
    
    func subscribeTapAction() {
        presenter.subscribeTapAction()
    }
    
    func moreTapAction() {
        presenter.moreTouchUpInside()
    }
    
    func commentsTapAction() {
        presenter.openComments()
    }
    
    func profileTapAction() {
        presenter.profileTouchUpInside()
    }
    
    func likeTapAction(_ type: LikeActionType) {
        presenter.likeTouchUpInside(type)
    }
    
    func screenTapAction() {
        presenter.screenTapAction()
    }
}

extension FeedViewViewController: CommentsDelegate {
    func updateCommentCount(_ count: Int) {
        presenter.setCommentsCount(with: count)
    }
}

extension FeedViewViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}

extension Notification.Name {
    static let setFCMToken = Notification.Name("FCMToken")
    static let updateFeed = Notification.Name(rawValue: "updateFeed")
    static let updateSettings = Notification.Name(rawValue: "updateSettings")
    static let hasUnviewedNotifications = Notification.Name(rawValue: "hasUnviewedNotifications")
    static let needUpdateNotificationsBadge = Notification.Name(rawValue: "needUpdateNotificationsBadge")
    static let hasntUnviewedNotifications = Notification.Name(rawValue: "hasntUnviewedNotifications")
    static let userUpdated = Notification.Name("userUpdated")
    static let userAuthorized = Notification.Name("userAuthorized")
    static let userLoggedOut = Notification.Name("userLoggedOut")
    static let changeFloatingBasketVisibility = Notification.Name(rawValue: "changeFloatingBasketVisibility")
    static let shouldUpdateBusinessesList = Notification.Name(rawValue: "shouldUpdateBusinessesList")
    static let updateCurrentChat = Notification.Name("UpdateCurrentChat")
    static let updateChatList = Notification.Name("UpdateChatList")
    static let updateNotificationsList = Notification.Name("UpdateNotificationsList")
    static let userWasSubscribed = Notification.Name("userWasSubscribed")

    static let applicationDidBecomeActive = Notification.Name(rawValue: "applicationDidBecomeActive")
}
