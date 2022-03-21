//
//  UserListViewController.swift
//  LikeTok
//
//  Created by Daniel on 20.03.22.
//

import UIKit

class UserSearchListViewController: BaseViewController {

    @IBOutlet weak var subscribersButton: UIButton!
    @IBOutlet weak var subscribtionsButton: UIButton!
    @IBOutlet weak var friendsButton: UIButton!
    @IBOutlet weak var subscribersTagView: UIView!
    @IBOutlet weak var subscribtionsButtonTagView: UIView!
    @IBOutlet weak var friendsTagView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var clearSearchButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var backButoon: UIButton!
    
    fileprivate let unselectedColor: UIColor = Assets.classicBGGray.color
    fileprivate let selectedColor: UIColor = Assets.mainRed.color
    
    var collectionManager: UserSearchListCollectionViewManager?
    var selectedSearchType: UserSearchTypes = .subscribers {
        didSet {
            switch selectedSearchType {
            case .subscriptions:
                emptyLabel.text = Strings.Search.Plug.people
//                presenter.load(.subscriptions)
            case .subscribers:
                emptyLabel.text = Strings.Search.Plug.tags
//                presenter.load(.subscribers)
            case .friends:
                emptyLabel.text = Strings.Search.Plug.categories
            }
        }
    }
    
    var presenter: UserSearchListPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        subscribersButton.setTitle(Strings.Search.Control.accounts, for: .normal)
        subscribtionsButton.setTitle(Strings.Search.Control.categories, for: .normal)
        friendsButton.setTitle(Strings.Search.Control.tags, for: .normal)
        select(type: selectedSearchType)
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emptyLabel.text = Strings.Search.Plug.people
        filterButton.setTitle("", for: .normal)
        backButoon.setTitle("", for: .normal)
        setupCollection()
        collectionManager = UserSearchListCollectionViewManager()
        collectionManager?.attach(collectionView, output: self)
        collectionManager?.collectionType = .subscribers
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let sideInset = 10
        let width: CGFloat = (view.bounds.width - CGFloat(sideInset * 2) - 5) / 2
        layout.itemSize = CGSize(width: width, height: 230)
        layout.sectionInset = UIEdgeInsets(top: .zero, left: CGFloat(sideInset), bottom: .zero, right: CGFloat(sideInset))
        collectionView.setCollectionViewLayout(layout, animated: true)
    }

    private func select(type: UserSearchTypes) {
        clearAllTags()
        switch type {
        case .subscriptions:
            UIView.animate(withDuration: 0.2) {
                self.subscribersTagView.backgroundColor = self.selectedColor
            }
            collectionManager?.collectionType = .subscriptions
        case .subscribers:
            UIView.animate(withDuration: 0.2) {
                self.subscribtionsButtonTagView.backgroundColor = self.selectedColor
            }
            collectionManager?.collectionType = .subscribers
        case .friends:
            UIView.animate(withDuration: 0.2) {
                self.friendsTagView.backgroundColor = self.selectedColor
            }
            collectionManager?.collectionType = .friends
        }
        selectedSearchType = type
        view.endEditing(true)
    }
    
    private func clearAllTags() {
        [subscribersTagView, subscribtionsButtonTagView, friendsTagView].forEach {
            $0?.backgroundColor = unselectedColor
        }
    }
    @IBAction func clearButtonDidTap(_ sender: Any) {
        searchTextField.text = ""
        clearSearchButton.isHidden = true
//        collectionManager?.setVideos(models: [])
//        collectionManager?.setCategories(models: [])
//        collectionManager?.setAccounts(models: [])
//        collectionView.reloadData()
    }
    
    @IBAction func backButtonDidtap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func subscribersDidTap(_ sender: Any) {
        select(type: .subscribers)
    }
    
    @IBAction func subscriptionsDidTap(_ sender: Any) {
        select(type: .subscriptions)
    }
    
    @IBAction func friendsDidTap(_ sender: Any) {
        select(type: .friends)
    }
}

extension UserSearchListViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text?.isEmpty ?? true) {
            clearSearchButton.isHidden = true
        } else {
            clearSearchButton.isHidden = false
        }
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField.text == "") {
            clearSearchButton.isHidden = true
//            collectionManager?.setVideos(models: [])
//            collectionManager?.setCategories(models: [])
//            collectionManager?.setAccounts(models: [])
//            collectionView.reloadData()
        } else {
            clearSearchButton.isHidden = false
        }
        guard let predict = textField.text, predict != "" else {
            return
        }
//        presenter.load(predict: predict, type: selectedSearchType)
    }
}

extension UserSearchListViewController: UserSearchListOutput {
    func setSubscriptions(models: [UserListDatum]) {
        collectionManager?.setSubscriptions(models: models)
    }
    
    func setSubscribers(models: [UserListDatum]) {
        collectionManager?.setSubscribers(models: models)
    }
    
    func setFriends(models: [UserListDatum]) {
        collectionManager?.setFriends(models: models)
    }
    
    func onFollowSuccess(_ following: Bool, uuid: String) {
        collectionManager?.updateFollowState(following, uuid: uuid)
    }
    
    func onFollowFailure(_ error: NetworkError) {
        showToast(error.localizedDescription, toastType: .failured)
    }
}

extension UserSearchListViewController: UserSearchListCollectionViewOutput {
    func updateEmptyLabel(_ isEmpty: Bool) {
        emptyLabel.isHidden = isEmpty
    }
    
    func openOtherProfile(_ viewController: OtherProfileViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func followButtonTap(_ uuid: String) {
        presenter.followButtonTap(uuid)
    }
}
