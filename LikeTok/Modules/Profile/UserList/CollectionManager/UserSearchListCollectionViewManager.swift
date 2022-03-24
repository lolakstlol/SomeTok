//
//  UserListCollectionViewManager.swift
//  LikeTok
//
//  Created by Daniel on 20.03.22.
//

import UIKit
import class Foundation.NSObject

protocol UserSearchListCollectionViewOutput: AnyObject {
    func didChangeType(_ type: UserSearchTypes)
    func openOtherProfile(_ viewController: OtherProfileViewController)
    func followButtonTap(_ uuid: String)
    func updateEmptyLabel(_ isEmpty: Bool)
    func loadMore(_ type: UserSearchTypes)
}

final class UserSearchListCollectionViewManager: NSObject {
    
    // MARK: - Private properties

    private var collectionView: UICollectionView?
    
    // MARK: - Public properties
    
    enum SearchCollectionType: Int {
        case accounts
        case videos
        case categories
    }
    
    private var subscribersDataSourse: [UserListDatum] = []
    private var subscriptionsDataSource: [UserListDatum] = []
    private var friendsDataSource: [UserListDatum] = []
    
    private var currentDataSourse: [UserListDatum] {
        get {
            switch collectionType {
            case .friends:
                return friendsDataSource
            case .subscriptions:
                return subscriptionsDataSource
            case .subscribers:
                return subscribersDataSourse
            default:
                return []
            }
        }
        
        set {
            switch collectionType {
            case .friends:
                friendsDataSource = newValue
            case .subscriptions:
                subscriptionsDataSource = newValue
            case .subscribers:
                subscribersDataSourse = newValue
            default:
                break
            }
        }

    }
    
    var collectionType: UserSearchTypes? {
        didSet {
            guard let collectionType = collectionType else {
                return
            }
            output?.didChangeType(collectionType)
            setupPostLayout()
        }
    }
    
    weak var output: UserSearchListCollectionViewOutput?
    
    
    // MARK: - Private methods
    
    private func setupPostLayout() {
        guard let collectionView = collectionView else {return }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        let sideInset = 10
        let width: CGFloat = (collectionView.bounds.width - CGFloat(sideInset * 2))
        layout.itemSize = CGSize(width: width, height: 44)
        layout.sectionInset = UIEdgeInsets(top: 10, left: CGFloat(sideInset), bottom: .zero, right: CGFloat(sideInset))
        collectionView.reloadData()
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    private func numberOfItemsInSection(section: Int) -> Int {
        output?.updateEmptyLabel(currentDataSourse.count > 0 ? true : false)
        return currentDataSourse.count
    }
    
    private func numberOfSections() -> Int {
       return 1
    }
    
    private func cellForItemAt(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserSearchListCollectionViewCell", for: indexPath) as! UserSearchListCollectionViewCell
        cell.configure(with: currentDataSourse[indexPath.row], delegate: self)
        return cell
    }
    
    func clearCurrentDataSourse() {
        currentDataSourse.removeAll()
    }
    
    
    func appendSubscribers(models: [UserListDatum]) {
         subscribersDataSourse += models
         collectionView?.reloadData()
    }
    
    func appendFriends(models: [UserListDatum]) {
         friendsDataSource += models
         collectionView?.reloadData()
    }
    
    func appendSubscriptions(models: [UserListDatum]) {
         subscriptionsDataSource += models
         collectionView?.reloadData()
    }
    
    func setSubscribers(models: [UserListDatum]) {
         subscribersDataSourse = models
         collectionView?.reloadData()
    }
    
    func setSubscriptions(models: [UserListDatum]) {
         subscriptionsDataSource = models
         collectionView?.reloadData()
    }
    
    func setFriends(models: [UserListDatum]) {
         friendsDataSource = models
         collectionView?.reloadData()
    }
    
    func updateFollowState(_ following: Bool, uuid: String) {
        for i in currentDataSourse.indices where currentDataSourse[i].uuid == uuid {
            currentDataSourse[i].isFollow = following
        }
        collectionView?.reloadData()
    }

}

// MARK: - BPCollectionManagerProtocol

extension UserSearchListCollectionViewManager {
    func attach(_ collectionView: UICollectionView, output: UserSearchListCollectionViewOutput) {
        self.collectionView = collectionView
        self.output = output
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        let accountCell = UINib.init(nibName: String(describing: UserSearchListCollectionViewCell.self), bundle: nil)
        collectionView.register(accountCell, forCellWithReuseIdentifier: String(describing: UserSearchListCollectionViewCell.self))
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
}

// MARK: - UICollectionView

extension UserSearchListCollectionViewManager: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellForItemAt(collectionView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        debugPrint("willDisplay", indexPath)
        guard indexPath.row == currentDataSourse.count - 1,
            let collectionType = collectionType else {
            return
        }
        output?.loadMore(collectionType)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let uuid = currentDataSourse[indexPath.row].uuid else {
            return
        }
        let otherProfileViewController = OtherProfileAssembler.createModule(uuid)
        output?.openOtherProfile(otherProfileViewController)
    }
}

extension UserSearchListCollectionViewManager: UserSearchListCollectionViewCellDelegate {
    func followButtonTap(_ uuid: String) {
        output?.followButtonTap(uuid)
    }
}
