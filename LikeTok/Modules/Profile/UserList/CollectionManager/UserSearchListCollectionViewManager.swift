//
//  UserListCollectionViewManager.swift
//  LikeTok
//
//  Created by Daniel on 20.03.22.
//

import UIKit
import class Foundation.NSObject

protocol UserSearchListCollectionViewOutput: AnyObject {
    func openOtherProfile(_ viewController: OtherProfileViewController)
    func followButtonTap(_ uuid: String)
    func updateEmptyLabel(_ isEmpty: Bool)
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
    
    var subscribersDataSourse: [UserListDatum] = []
    var subscriptionsDataSource: [UserListDatum] = []
    var friendsDataSource: [UserListDatum] = []

    var collectionType: UserSearchTypes = .subscribers {
        didSet {
//            output?.changeCollectionType(collectionType: collectionType)
            updatelayout()
        }
    }
    
    weak var output: UserSearchListCollectionViewOutput?
    
    
    // MARK: - Private methods
    
    private func updatelayout() {
//        switch collectionType {
//        case .categories:
//            setupCategoriesLayout()
//        case .videos:
//            setupVideosLayout()
//        case .accounts:
        setupPostLayout()
//        }
        collectionView?.reloadData()
    }
    
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
        switch collectionType {
        case .subscribers:
//            emptyLabel.isHidden = peeopleDataSource.count > 1 ? true : false
            output?.updateEmptyLabel(subscribersDataSourse.count > 1 ? true : false)
            return subscribersDataSourse.count
        case .subscriptions:
//            emptyLabel.isHidden = categoriesDataSource.count > 1 ? true : false
            output?.updateEmptyLabel(subscriptionsDataSource.count > 1 ? true : false)
            return subscriptionsDataSource.count
        case .friends:
//            emptyLabel.isHidden = videosDataSource.count > 1 ? true : false
            output?.updateEmptyLabel(friendsDataSource.count > 1 ? true : false)
            return friendsDataSource.count
        }
    }
    
    private func numberOfSections() -> Int {
       return 1
    }
    
    private func cellForItemAt(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionType {
        case .subscriptions:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserListCollectionViewCell", for: indexPath) as! UserSearchListCollectionViewCell
            cell.configure(with: subscriptionsDataSource[indexPath.row], delegate: self)
            return cell
        case .subscribers:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserListCollectionViewCell", for: indexPath) as! UserSearchListCollectionViewCell
            cell.configure(with: subscribersDataSourse[indexPath.row], delegate: self)
            return cell
        case .friends:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserListCollectionViewCell", for: indexPath) as! UserSearchListCollectionViewCell
            cell.configure(with: friendsDataSource[indexPath.row], delegate: self)
            return cell
        }
    }
    
     func appendVideos(models: [CategoriesPost]) {
        
    }
    
     func appendCategories(models: [CategoriesDatum]) {
        
    }
    
     func appendAccount(models: [SearchAccountsDatum]) {
        
    }
    
     func setSubscribers(models: [UserListDatum]) {
         subscribersDataSourse = models
         guard let collectionView = collectionView else {
             return
         }
         collectionView.reloadData()
    }
    
     func setSubscriptions(models: [UserListDatum]) {
         subscriptionsDataSource = models
         guard let collectionView = collectionView else {
             return
         }
         collectionView.reloadData()
    }
    
     func setFriends(models: [UserListDatum]) {
         friendsDataSource = models
         guard let collectionView = collectionView else {
             return
         }
         collectionView.reloadData()
    }
    
    func updateFollowState(_ following: Bool, uuid: String) {
//        for i in peeopleDataSource.indices where peeopleDataSource[i].uuid == uuid{
//            peeopleDataSource[i].isFollow = following
//        }
//        collectionView?.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionType {
        case .subscribers:
            let uuid = subscribersDataSourse[indexPath.row].uuid
            let otherProfileViewController = OtherProfileAssembler.createModule(uuid)
            output?.openOtherProfile(otherProfileViewController)
            
        default:
            debugPrint("add logic")
        }
    }
}

extension UserSearchListCollectionViewManager: UserSearchListCollectionViewCellDelegate {
    func followButtonTap(_ uuid: String) {
        output?.followButtonTap(uuid)
    }
}
