//
//  ProfileCollectionViewManager.swift
//  LikeTok
//
//  Created by Daniel on 24.03.22.
//

import UIKit
import class Foundation.NSObject

protocol ProfileCollectionViewOutput: AnyObject {
    func didChangeType(_ type: FeedViewEnterOption)
    func updateEmptyLabel(_ isEmpty: Bool)
    func loadMore(_ type: FeedViewEnterOption)
    func didTapVideo(_ type: FeedViewEnterOption, _ dataSourse: [FeedPost], index: Int)
}

final class ProfileCollectionViewManager: NSObject {
    
    // MARK: - Private properties

    private var collectionView: UICollectionView?
    
    // MARK: - Public properties
    
    private var advertismentDataSourse: [FeedPost] = []
    private var personalDataSource: [FeedPost] = []
    
    private var currentDataSourse: [FeedPost] {
        get {
            switch collectionType {
            case .advertisment:
                return advertismentDataSourse
            case .personal:
                return personalDataSource
            default:
                return []
            }
        }
        
        set {
            switch collectionType {
            case .advertisment:
                advertismentDataSourse = newValue
            case .personal:
                personalDataSource = newValue
            default:
                break
            }
        }

    }
    
    var collectionType: FeedViewEnterOption? {
        didSet {
            guard let collectionType = collectionType else {
                return
            }
            output?.didChangeType(collectionType)
            collectionView?.reloadData()
        }
    }
    
    weak var output: ProfileCollectionViewOutput?
    
    
    // MARK: - Private methods
    
//    private func setupPostLayout() {
//        guard let collectionView = collectionView else {return }
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 0
//        let widthPerItem = collectionView.frame.width / Constants.itemsInLine - Constants.interItemSpacing
//        layout.itemSize = CGSize(width: widthPerItem, height: widthPerItem / Constants.imageRatio)
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        collectionView.reloadData()
//        collectionView.setCollectionViewLayout(layout, animated: false)
//    }
    
    private func numberOfItemsInSection(section: Int) -> Int {
        output?.updateEmptyLabel(currentDataSourse.count > 0 ? true : false)
        return currentDataSourse.count
    }
    
    private func numberOfSections() -> Int {
       return 1
    }
    
    private func cellForItemAt(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
        cell.configure(with: currentDataSourse[indexPath.row])
        return cell
    }
    
    func clearCurrentDataSourse() {
        currentDataSourse.removeAll()
    }
    
    func appendAdvertisment(models: [FeedPost]) {
        var indexPathes = [IndexPath]()
        for index in advertismentDataSourse.count..<advertismentDataSourse.count + models.count {
            indexPathes.append(IndexPath(row: index, section: .zero))
        }
        advertismentDataSourse += models
        collectionView?.insertItems(at: indexPathes)
    }
    
    func appendPersonal(models: [FeedPost]) {
        personalDataSource += models
        collectionView?.reloadData()
    }
    
    func setAdvertisment(models: [FeedPost]) {
        advertismentDataSourse = models
        collectionView?.reloadData()
    }
    
    func setPersonal(models: [FeedPost]) {
        personalDataSource = models
        collectionView?.reloadData()
    }

}

// MARK: - BPCollectionManagerProtocol

extension ProfileCollectionViewManager {
    func attach(_ collectionView: UICollectionView, output: ProfileCollectionViewOutput) {
        self.collectionView = collectionView
        self.output = output
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        let videoCell = UINib.init(nibName: String(describing: VideoCollectionViewCell.self), bundle: nil)
        collectionView.register(videoCell, forCellWithReuseIdentifier: String(describing: VideoCollectionViewCell.self))
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
}

// MARK: - UICollectionView

extension ProfileCollectionViewManager: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        debugPrint("12312412", numberOfItemsInSection(section: section))
        return numberOfItemsInSection(section: section)
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let widthPerItem = collectionView.frame.width / Constants.itemsInLine - Constants.interItemSpacing
        return CGSize(width: widthPerItem, height: widthPerItem / Constants.imageRatio)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let uuid = currentDataSourse[indexPath.row].uuid else {
//            return
//        }
//        let otherProfileViewController = OtherProfileAssembler.createModule(uuid)
//        output?.openOtherProfile(otherProfileViewController)
        guard let collectionType = collectionType else {
            return
        }
        output?.didTapVideo(collectionType, currentDataSourse, index: indexPath.row)
    }
}

extension ProfileCollectionViewManager {
    private enum Constants {
        static let itemsInLine: CGFloat = 3
        static let imageRatio: CGFloat = 9/16
        static let interItemSpacing: CGFloat = 2
    }
}


//
//
//func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
//    return data.count
//}
//
//func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.id, for: indexPath) as! ProfileCollectionViewCell
////        cell.configure(data: data[indexPath.row])
//    cell.backgroundColor = data[indexPath.row]
//    return cell
//}
//
//func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        interactor.likedMeMatchingType(userId: data[indexPath.row].userId)
////        delegate?.openLikedMeMatching()
//}
//
//func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
//    let widthPerItem = collectionView.frame.width / Constants.itemsInLine - Constants.interItemSpacing
//    return CGSize(width: widthPerItem, height: widthPerItem / Constants.imageRatio)
//}
//
//func collectionView(_: UICollectionView, willDisplay _: UICollectionViewCell, forItemAt indexPath: IndexPath) {
////        if interactor.loadMore(index: indexPath.row) {
////            loadLikedMe(showLoading: false)
////        }
//}
//
//

