//
//  OtherProfileViewController.swift
//  LikeTok
//
//  Created by Daniel on 20.02.22.
//

import UIKit

final class OtherProfileViewController: BaseViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var subscriptionsCountLabel: UILabel!
    @IBOutlet weak var subscribersCountLabel: UILabel!
    
    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sendMessageButton: UIButton!
    
    @IBOutlet private var advertismentButton: UIButton!
    @IBOutlet private var advertismentBottomView: UIView!
    
    @IBOutlet private var personalButton: UIButton!
    @IBOutlet private var personalBottomView: UIView!
    
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
        
    var presenter: OtherProfilePresenterInput!
    var collectionManager: ProfileCollectionViewManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        showLoader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCollectionViewSize()
    }
    
    private func updateCollectionViewSize() {
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeightConstraint.constant = height
        debugPrint("!--", height)
        self.view.layoutIfNeeded()
    }
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.isHidden = false
        let backButton = UIBarButtonItem(image: Assets.backButton.image, style: .plain, target: self, action: #selector(backButtonTap))
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = .black
    }

    private func update(with type: ContentType) {
        UIView.animate(withDuration: 0.3) {
            switch type {
            case .advertisment:
                self.advertismentButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 16)
                self.advertismentBottomView.backgroundColor = Assets.mainRed.color
                self.personalButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
                self.personalBottomView.backgroundColor = .clear
                self.collectionManager?.collectionType = .advertisment
            case .personal:
                self.personalButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 16)
                self.personalBottomView.backgroundColor = Assets.mainRed.color
                self.advertismentButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
                self.advertismentBottomView.backgroundColor = .clear
                self.collectionManager?.collectionType = .personal
            }
        }
    }
    
    private func setupButtons() {
        subscribeButton.layer.cornerRadius = 5
        subscribeButton.clipsToBounds = true
        
        sendMessageButton.layer.cornerRadius = 5
        sendMessageButton.clipsToBounds = true
        sendMessageButton.layer.borderColor = Assets.borderButton.color.cgColor
        sendMessageButton.layer.borderWidth = 1.5
    }
    
    private func updateSubscribeButton(_ isFollow: Bool) {
        if isFollow {
            subscribeButton.layer.borderColor = Assets.borderButton.color.cgColor
            subscribeButton.layer.borderWidth = 1.5
            subscribeButton.backgroundColor = .clear
            subscribeButton.setTitleColor(UIColor.black, for: .normal)
            subscribeButton.setTitle("Вы подписаны", for: .normal)
        } else {
            subscribeButton.backgroundColor = Assets.mainRed.color
            subscribeButton.setTitleColor(UIColor.white, for: .normal)
            subscribeButton.setTitle("Подписаться", for: .normal)
        }
    }
    
    @IBAction private func advertismentButtonTap(_ sender: Any) {
        update(with: .advertisment)
    }
    
    @IBAction private func personalButtonTap(_ sender: Any) {
        update(with: .personal)
    }
    
    @IBAction func followButtonTap(_ sender: Any) {
        presenter.followButtonTap()
        showLoader()
    }
    
    @objc private func backButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func openSubscibersList(_ sender: Any) {
//        presenter.openSubscibersList()
    }
    
    @IBAction func openSubscriptionsList(_ sender: Any) {
//        presenter.openSubsciptionsList()
    }
  
}

extension OtherProfileViewController: OtherProfilePresenterOutput {

    func reloadCollectionView() {
        collectionView.reloadData()
        updateCollectionViewSize()
    }
    
    func setAdvertisment(_ model: [FeedPost]) {
        collectionManager?.setAdvertisment(models: model)
    }
    
    func appendAdvertisment(_ model: [FeedPost]) {
        collectionManager?.appendAdvertisment(models: model)
        updateCollectionViewSize()
    }
    
    func onFetchFeedFailrue(_ error: NetworkError) {
        debugPrint(error.localizedDescription)
    }
    
    func pushUsersList(_ viewController: UserSearchListViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

    func setupUI() {
        setupNavigationBar()
        collectionManager = ProfileCollectionViewManager()
        collectionManager?.attach(collectionView, output: self)
        collectionManager?.collectionType = .advertisment
    }

    func onFetchProfileDataSuccess(_ model: OtherProfileServerDatum) {
        title = model.name
        if let preview = model.photo.preview {
            avatarImageView.kf.setImage(with: URL(string: preview))
        } else {
            avatarImageView.image = Assets.avatarDefaulth.image
        }
        usernameLabel.text = model.username
        descriptionLabel.text = model.dataDescription
        subscriptionsCountLabel.text = String(model.subscriptions)
        subscribersCountLabel.text = String(model.subscribers)
        setupButtons()
        updateSubscribeButton(model.isFollow)
        hideLoader()
    }
    
    func onFetchProfileDataFailure(_ error: NetworkError) {
        hideLoader()
        showToast(error.localizedDescription, toastType: .failured)
    }
    
    func onFollowSuccess(_ following: Bool, subscribersCount: Int) {
        subscribersCountLabel.text = String(subscribersCount)
        updateSubscribeButton(following)
        hideLoader()
    }
    
    func onFollowFailure(_ error: NetworkError) {
        hideLoader()
        showToast(error.localizedDescription, toastType: .failured)
    }
    
    func pushFeed(_ viewController: FeedViewViewController) {
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension OtherProfileViewController: ProfileCollectionViewOutput {

    func didTapVideo(_ type: FeedViewEnterOption, _ dataSourse: [FeedPost], index: Int) {
        presenter.didTapVideo(type, dataSourse, index: index)
    }
    
    func didChangeType(_ type: FeedViewEnterOption) {
        
    }
    
    func updateEmptyLabel(_ isEmpty: Bool) {
        
    }
    
    func loadMore(_ type: FeedViewEnterOption) {
        presenter.loadMore(type)
    }
    
}
