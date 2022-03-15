
import UIKit
import class Foundation.NSObject

protocol SearchCollectionViewOutput: AnyObject {
    func openOtherProfile(_ viewController: OtherProfileViewController)
    func followButtonTap(_ uuid: String)
    func updateEmptyLabel(_ isEmpty: Bool)
}

final class SearchCollectionViewManager: NSObject {
    
    // MARK: - Private properties

    private var collectionView: UICollectionView?
    
    // MARK: - Public properties
    
    enum SearchCollectionType: Int {
        case accounts
        case videos
        case categories
    }
    
    var videosDataSource: [CategoriesPost] = []
    var categoriesDataSource: [CategoriesDatum] = []
    var peeopleDataSource: [SearchAccountsDatum] = []

    var collectionType: SearchCollectionType = .categories {
        didSet {
//            output?.changeCollectionType(collectionType: collectionType)
            updatelayout()
        }
    }
    
    weak var output: SearchCollectionViewOutput?
    
//    weak var output: BPCollectionManagerProtocolOutput?
    
    // MARK: - Private methods
    
    private func updatelayout() {
        switch collectionType {
        case .categories:
            setupCategoriesLayout()
        case .videos:
            setupVideosLayout()
        case .accounts:
            setupPostLayout()
        }
        collectionView?.reloadData()
    }
    
    private func setupCategoriesLayout() {
        guard let collectionView = collectionView else {return }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        let sideInset = 10
        let width: CGFloat = collectionView.bounds.width - CGFloat(sideInset)
        layout.itemSize = CGSize(width: width, height: 246)
        layout.sectionInset = UIEdgeInsets(top: 20, left: CGFloat(sideInset), bottom: .zero, right: .zero)
        collectionView.reloadData()
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    private func setupVideosLayout() {
        guard let collectionView = collectionView else {return }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let sideInset = 10
        let width: CGFloat = (collectionView.bounds.width - CGFloat(sideInset * 2) - 5) / 2
        layout.itemSize = CGSize(width: width, height: 230)
        layout.sectionInset = UIEdgeInsets(top: .zero, left: CGFloat(sideInset), bottom: .zero, right: CGFloat(sideInset))
        collectionView.reloadData()
        collectionView.setCollectionViewLayout(layout, animated: false)
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
        case .accounts:
//            emptyLabel.isHidden = peeopleDataSource.count > 1 ? true : false
            output?.updateEmptyLabel(peeopleDataSource.count > 1 ? true : false)
            return peeopleDataSource.count
        case .categories:
//            emptyLabel.isHidden = categoriesDataSource.count > 1 ? true : false
            output?.updateEmptyLabel(categoriesDataSource.count > 1 ? true : false)
            return categoriesDataSource.count
        case .videos:
//            emptyLabel.isHidden = videosDataSource.count > 1 ? true : false
            output?.updateEmptyLabel(videosDataSource.count > 1 ? true : false)
            return videosDataSource.count
        }
    }
    
    private func numberOfSections() -> Int {
       return 1
    }
    
    private func cellForItemAt(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionType {
        case .accounts:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountsCollectionViewCell", for: indexPath) as! AccountsCollectionViewCell
            cell.configure(with: peeopleDataSource[indexPath.row], delegate: self)
            return cell
        case .videos:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
            cell.configure(with: videosDataSource[indexPath.row])
            return cell
        case .categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            cell.configure(with: categoriesDataSource[indexPath.row])
            return cell
        }
    }
    
     func appendVideos(models: [CategoriesPost]) {
        
    }
    
     func appendCategories(models: [CategoriesDatum]) {
        
    }
    
     func appendAccount(models: [SearchAccountsDatum]) {
        
    }
    
     func setAccounts(models: [SearchAccountsDatum]) {
         peeopleDataSource = models
         guard let collectionView = collectionView else {
             return
         }
         collectionView.reloadData()
    }
    
     func setCategories(models: [CategoriesDatum]) {
         categoriesDataSource = models
         guard let collectionView = collectionView else {
             return
         }
         collectionView.reloadData()
    }
    
     func setVideos(models: [CategoriesPost]) {
         videosDataSource = models
         guard let collectionView = collectionView else {
             return
         }
         collectionView.reloadData()
    }
    
    func updateFollowState(_ following: Bool, uuid: String) {
        for i in peeopleDataSource.indices where peeopleDataSource[i].uuid == uuid{
            peeopleDataSource[i].isFollow = following
        }
        collectionView?.reloadData()
    }

}

// MARK: - BPCollectionManagerProtocol

extension SearchCollectionViewManager {
    func attach(_ collectionView: UICollectionView, output: SearchCollectionViewOutput) {
        self.collectionView = collectionView
        self.output = output
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        let categoryCell = UINib.init(nibName: String(describing: CategoryCollectionViewCell.self), bundle: nil)
        let videoCell = UINib.init(nibName: String(describing: VideoCollectionViewCell.self), bundle: nil)
        let accountCell = UINib.init(nibName: String(describing: AccountsCollectionViewCell.self), bundle: nil)
        collectionView.register(categoryCell, forCellWithReuseIdentifier: String(describing: CategoryCollectionViewCell.self))
        collectionView.register(videoCell, forCellWithReuseIdentifier: String(describing: VideoCollectionViewCell.self))
        collectionView.register(accountCell, forCellWithReuseIdentifier: String(describing: AccountsCollectionViewCell.self))
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
}

// MARK: - UICollectionView

extension SearchCollectionViewManager: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
        case .accounts:
            let uuid = peeopleDataSource[indexPath.row].uuid
            let otherProfileViewController = OtherProfileAssembler.createModule(uuid)
            output?.openOtherProfile(otherProfileViewController)
            
        default:
            debugPrint("add logic")
        }
    }
}

extension SearchCollectionViewManager: AcoountCollectionViewCellDelegate {
    func followButtonTap(_ uuid: String) {
        output?.followButtonTap(uuid)
    }
}
