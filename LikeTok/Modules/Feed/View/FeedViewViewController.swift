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
    
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var addressStackView: UIStackView!
    @IBOutlet private var addressLabel: UILabel!
    @IBOutlet private var messageTextView: UITextView!
    @IBOutlet private var messageTextViewMinConstraint: NSLayoutConstraint!
    @IBOutlet private var inputSendButton: UIButton!
    @IBOutlet private var closeButton: UIButton!
    @IBOutlet private var hoverView: UIView!
    @IBOutlet private var bottomInputConstraint: NSLayoutConstraint!
    @IBOutlet private var hudView: UIView!
    @IBOutlet private var hudViewLabel: UILabel!
    @IBOutlet private var placeholderLabel: UILabel!
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
//        navigationController?.navigationBar.isHidden = true
//        tabBarController?.showTabBar(completion: nil)
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
        
        let addressRecognizer = UITapGestureRecognizer(target: self, action: #selector(addressLabelTouchUpInside))
        addressLabel.isUserInteractionEnabled = true
        addressLabel.addGestureRecognizer(addressRecognizer)
    }
    
    // MARK: - @IBActions

    @IBAction private func closeModuleAction(_ sender: Any) {
        presenter.closeButtonTouchUpInside()
    }
    
    @IBAction private func sendMessage(_ sender: Any) {
        returnToFirstState()
        messageTextView.resignFirstResponder()
        presenter.sendMessage(messageTextView.text)
        messageTextView.text = ""
        placeholderLabel.isHidden = !messageTextView.text.isEmpty
    }
    
    @objc private func addressLabelTouchUpInside() {
        presenter.addressLabelTouchUpInside()
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
    func setupLike(_ type: LikeType, at index: Int?) {
        collectionManager?.updateCellLikes(type: type, at: index)
    }
    
    func hideAddressStackView() {
        addressStackView.isHidden = true
    }
    
    func hideActivityIndicator() {
        activityIndicator.isHidden = true
    }
    
    func updateItem(with model: FeedResponse, at index: Int) {
        collectionManager?.updateItem(with: model, at: index)
    }
    
    func showDismissButton() {
        closeButton.isHidden = false
    }
    
    func setupUserFeed(with index: Int) {
        collectionManager?.setFeedIndex(index)
    }
    
    func setupAddress(with text: String) {
        addressLabel.text = text
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
