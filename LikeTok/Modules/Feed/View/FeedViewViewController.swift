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
    
    @IBOutlet private var advertisingFilterButton: UIButton!
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var subscribesFilterButton: UIButton!
    @IBOutlet private var generalFilterButton: UIButton!
    @IBOutlet private var messageTextView: UITextView!
    @IBOutlet private var messageTextViewMinConstraint: NSLayoutConstraint!
    @IBOutlet private var inputSendButton: UIButton!
    @IBOutlet private var hoverView: UIView!
    @IBOutlet private var bottomInputConstraint: NSLayoutConstraint!
    @IBOutlet private var hudView: UIView!
    @IBOutlet private var hudViewLabel: UILabel!
    @IBOutlet private var placeholderLabel: UILabel!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var filterButtonsCollections: [UIButton]!
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
//        navigationController?.navigationBar.isHidden = true
//        tabBarController?.showTabBar(completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    // MARK: - Private methods
    
    private func returnToFirstState() {
        hoverView.isHidden = true
        inputSendButton.isHidden = true
        messageTextView.textContainerInset = UIEdgeInsets(top: Constants.Feed.topBottomInputInsetConstraint,
                                                          left: Constants.Feed.rightLeftInputInsetConstraint,
                                                          bottom: Constants.Feed.topBottomInputInsetConstraint,
                                                          right: Constants.Feed.rightLeftInputInsetConstraint)
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideHover))
        hoverView.addGestureRecognizer(tap)
        
    }
    
    private func updateFilterButtons(selectedButton: UIButton) {
        filterButtonsCollections.forEach {
            $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
            $0.titleLabel?.tintColor = .systemGray5
        }
        selectedButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        selectedButton.titleLabel?.tintColor = .white
    }
    
    // MARK: - @IBActions
    @IBAction private func subscribesFilterTap(_ sender: UIButton) {
        updateFilterButtons(selectedButton: sender)
        presenter.updateFeedType(.subscriptions)
    }
    
    @IBAction func advertismentFilterTap(_ sender: UIButton) {
        updateFilterButtons(selectedButton: sender)
        presenter.updateFeedType(.advertisment)
    }
    
    @IBAction func generalFilterTap(_ sender: UIButton) {
        updateFilterButtons(selectedButton: sender)
        presenter.updateFeedType(.general)
    }
    
    @IBAction private func sendMessage(_ sender: Any) {
        returnToFirstState()
        messageTextView.resignFirstResponder()
        presenter.sendMessage(messageTextView.text)
        messageTextView.text = ""
        placeholderLabel.isHidden = !messageTextView.text.isEmpty
    }
    
    @objc private func updateFeed() {
        presenter.getFeedWithScrollToTop()
    }
    
    @objc private func hideHover() {
        returnToFirstState()
        messageTextView.resignFirstResponder()
    }
    
    @objc private func updateSettings() {
//        DispatchQueue.main.async { [weak self] in
//            self?.setupAddress(with: UserDefaultsManager.shared.lastUserLocation ?? "")
    
    }
}

// MARK: - Keyboard logic

extension FeedViewViewController {
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        bottomInputConstraint.constant = keyboardViewEndFrame.height - view.safeAreaInsets.bottom
            + Constants.Feed.standartBottomInputConstraint
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        bottomInputConstraint.constant = Constants.Feed.standartBottomInputConstraint
    }
}

// MARK: - FeedViewPresenterOutput

extension FeedViewViewController: FeedViewPresenterOutput {
    
    func tapScreenAction() {
        collectionManager?.tapScreenAction()
    }
    
    func stopVideo() {
        collectionManager?.stopVideo()
    }
    
    func setupLike(_ type: LikeType, at index: Int?) {
        collectionManager?.updateCellLikes(type: type, at: index)
    }
    
    func hideActivityIndicator() {
        activityIndicator.isHidden = true
    }
    
    func updateItem(with model: FeedResponse, at index: Int) {
        collectionManager?.updateItem(with: model, at: index)
    }
    
    func setupUserFeed(with index: Int) {
        collectionManager?.setFeedIndex(index)
    }
    
    func setupUI() {
        showLoader()
        
        hudView.isHidden = true
//        messageTextView.layer.borderColor = Asset.Colors.General.white.color.withAlphaComponent(0.6).cgColor
//        messageTextView.delegate = self
        collectionManager?.attach(collectionView)
        collectionManager?.output = self
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillShow(notification:)),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillHide(notification:)),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
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
        notificationCenter.addObserver(self,
                                       selector: #selector(updateFeed),
                                       name: .userLoggedOut,
                                       object: nil)
        setupGestures()
        
    }
    
    func updateConfigurators(_ configurators: [FeedCellConfigurator]) {
        collectionManager?.update(with: configurators)
        hideLoader()
    }
    
    func scrollToTop() {
        collectionManager?.scrollToTop()
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
    
    func selectFeedItem(_ item: FeedResponse) {
        presenter.setCurrentPost(item)
    }
    
    func shouldShowFilledLikes() -> Bool {
        return presenter.shouldShowFilledLikes()
    }
}

// MARK: - FeedCellActionsOutput

extension FeedViewViewController: FeedCellActionsOutput {
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
    
    func shareTapAction(_ image: UIImage) {
        presenter.shareTouchUpInside(image)
    }
    
    func screenTapAction() {
        presenter.screenTapAction()
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
