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
    
    private var data: [UIColor] = [.blue, .black, .red, .magenta, .brown, .darkGray, .yellow, .red, .yellow, .green, .link, .magenta]
    
    var presenter: OtherProfilePresenterInput!
    
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
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeightConstraint.constant = height
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
            case .personal:
                self.personalButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 16)
                self.personalBottomView.backgroundColor = Assets.mainRed.color
                self.advertismentButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
                self.advertismentBottomView.backgroundColor = .clear
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: ProfileCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: ProfileCollectionViewCell.id)
        collectionView.delegate = self
        collectionView.dataSource = self
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
        presenter.openSubscibersList()
    }
    
    @IBAction func openSubscriptionsList(_ sender: Any) {
        presenter.openSubsciptionsList()
    }
  
}

extension OtherProfileViewController: OtherProfilePresenterOutput {
    
    func pushUsersList(_ viewController: UserSearchListViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

    func setupUI() {
        setupNavigationBar()
        setupCollectionView()
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
    
}

extension OtherProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.id, for: indexPath) as! ProfileCollectionViewCell
//        cell.configure(data: data[indexPath.row])
        cell.backgroundColor = data[indexPath.row]
        return cell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        interactor.likedMeMatchingType(userId: data[indexPath.row].userId)
//        delegate?.openLikedMeMatching()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let widthPerItem = collectionView.frame.width / Constants.itemsInLine - Constants.interItemSpacing
        return CGSize(width: widthPerItem, height: widthPerItem / Constants.imageRatio)
    }

    func collectionView(_: UICollectionView, willDisplay _: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if interactor.loadMore(index: indexPath.row) {
//            loadLikedMe(showLoading: false)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

extension OtherProfileViewController {
    private enum Constants {
        static let itemsInLine: CGFloat = 3
        static let imageRatio: CGFloat = 9/16
        static let interItemSpacing: CGFloat = 2
    }
}
