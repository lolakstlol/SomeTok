//
//  MyProfileViewController.swift
//  LikeTok
//
//  Created by Daniel on 17.02.22.
//

import UIKit

enum ContentType: String {
    case advertisment = "material_products"
    case personal = "digital_products"
}

final class MyProfileViewController: BaseViewController {
    
    @IBOutlet private var navigationLabel: UILabel!
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var subscriptionsCountLabel: UILabel!
    @IBOutlet private var subscribersCountLabel: UILabel!
    @IBOutlet private var friendsCountLabel: UILabel!
    @IBOutlet private var emptyLabel: UILabel!
    
    @IBOutlet private var collectionView: UICollectionView!
    
    @IBOutlet private var editButton: UIButton!
    @IBOutlet private var referalButton: UIButton!
    @IBOutlet private var balanceButton: UIButton!
    
    @IBOutlet private var advertismentButton: UIButton!
    @IBOutlet private var advertismentBottomView: UIView!
    
    @IBOutlet private var personalButton: UIButton!
    @IBOutlet private var personalBottomView: UIView!
    
    @IBOutlet private var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var presenter: MyProfilePresenterInput!
    var collectionManager: ProfileCollectionViewManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        showLoader()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCollectionViewSize()
    }
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.isHidden = true
    }

    private func updateCollectionViewSize() {
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeightConstraint.constant = height
        debugPrint("!--", height)
        self.view.layoutIfNeeded()
    }
    
    private func setupButtons() {
        editButton.layer.cornerRadius = 5
        editButton.clipsToBounds = true
        editButton.layer.borderColor = Assets.borderButton.color.cgColor
        editButton.layer.borderWidth = 1.5
        
        referalButton.layer.cornerRadius = 5
        referalButton.clipsToBounds = true
        referalButton.layer.borderColor = Assets.borderButton.color.cgColor
        referalButton.layer.borderWidth = 1.5
        
        balanceButton.layer.cornerRadius = 5
        balanceButton.clipsToBounds = true
        balanceButton.layer.borderColor = Assets.borderButton.color.cgColor
        balanceButton.layer.borderWidth = 1.5
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
    
    @IBAction private func advertismentButtonTap(_ sender: Any) {
        update(with: .advertisment)
    }
    
    @IBAction private func personalButtonTap(_ sender: Any) {
        update(with: .personal)
    }
    
    @IBAction private func editButtonTap(_ sender: Any) {
        presenter.editButtonTap()
    }
    
    @IBAction func moreButtonTap(_ sender: Any) {
        let settingsController = SettingsAssembler.createModule()
        settingsController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    @IBAction func openSubscribersList(_ sender: Any) {
        let userListViewController = UserSearchListAssembler.createModule(selectedSearchType: .subscribers, baseController: .my)
        userListViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(userListViewController, animated: true)
    }
    
    @IBAction func openSubscriptionsList(_ sender: Any) {
        let userListViewController = UserSearchListAssembler.createModule(selectedSearchType: .subscriptions,  baseController: .my)
        userListViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(userListViewController, animated: true)
    }
    
    @IBAction func openFriendsList(_ sender: Any) {
        let userListViewController = UserSearchListAssembler.createModule(selectedSearchType: .friends,  baseController: .my)
        userListViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(userListViewController, animated: true)
    }
    
}

extension MyProfileViewController: MyProfilePresenterOutput {
    
    func setupUI() {
        setupButtons()
        setupNavigationBar()
//        setupCollectionView()
        collectionManager = ProfileCollectionViewManager()
        collectionManager?.attach(collectionView, output: self)
        collectionManager?.collectionType = .advertisment
        
        avatarImageView.layer.cornerRadius = 35
        avatarImageView.clipsToBounds = true
    }
    
    func setPersonalFeed(_ models: [FeedPost]) {
        collectionManager?.setPersonal(models: models)
    }
    
    func setAdvertismentFeed(_ models: [FeedPost]) {
        collectionManager?.setAdvertisment(models: models)
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
        updateCollectionViewSize()
    }
    
    func appendPersonal(_ model: [FeedPost]) {
        collectionManager?.appendPersonal(models: model)
    }
    
    func appendAdvertisment(_ model: [FeedPost]) {
        collectionManager?.appendAdvertisment(models: model)
    }
    
    func onFetchFeedFailrue(_ error: NetworkError) {
        
    }
    
    func onFetchProfileDataSuccess(_ model: ProfileModel) {
        navigationLabel.text = model.name
        if let preview = model.photo.preview {
            avatarImageView.kf.setImage(with: URL(string: preview))
        } else {
            avatarImageView.image = Assets.avatarDefaulth.image
        }
        emptyLabel.text = "У вас пока нет публикаций"
        usernameLabel.text = model.username
        descriptionLabel.text = model.description
        subscriptionsCountLabel.text = String(model.subscriptions)
        subscribersCountLabel.text = String(model.subscribers)
        friendsCountLabel.text = String(model.friends)
        hideLoader()
    }
    
    func onFetchProfileDataFailure(_ error: NetworkError) {
        hideLoader()
        showToast(error.localizedDescription, toastType: .failured)
    }
    
    func onEditButtonTap(_ viewController: EditProfileViewController) {
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushFeed(_ viewController: FeedViewViewController) {
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}


extension MyProfileViewController: ProfileCollectionViewOutput {
    func didChangeType(_ type: FeedViewEnterOption) {
        
    }
    
    func loadMore(_ type: FeedViewEnterOption) {
        presenter.loadMore(type)
    }
    
    func didTapVideo(_ type: FeedViewEnterOption, _ dataSourse: [FeedPost], index: Int) {
        presenter.didTapVideo(type, dataSourse, index: index)
    }
    
    func updateEmptyLabel(_ isEmpty: Bool) {
        emptyLabel.isHidden = isEmpty
    }
    
    
}
