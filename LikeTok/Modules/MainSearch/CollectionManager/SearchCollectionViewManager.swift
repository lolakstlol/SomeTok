
import UIKit
import class Foundation.NSObject

final class SearchCollectionViewManager: NSObject {
    
    // MARK: - Private properties

    private var collectionView: UICollectionView?
    
    // MARK: - Public properties
    
    enum SearchCollectionType: Int {
        case accounts
        case videos
        case categories
    }

    var collectionType: SearchCollectionType = .categories {
        didSet {
//            output?.changeCollectionType(collectionType: collectionType)
            updatelayout()
        }
    }
    
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
        layout.sectionInset = UIEdgeInsets(top: .zero, left: CGFloat(sideInset), bottom: .zero, right: .zero)
        collectionView.setCollectionViewLayout(layout, animated: true)
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
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func setupPostLayout() {
        guard let collectionView = collectionView else {return }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        let sideInset = 10
        let width: CGFloat = (collectionView.bounds.width - CGFloat(sideInset * 2))
        layout.itemSize = CGSize(width: width, height: 44)
        layout.sectionInset = UIEdgeInsets(top: .zero, left: CGFloat(sideInset), bottom: .zero, right: CGFloat(sideInset))
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func numberOfItemsInSection(section: Int) -> Int {
        return 40
    }
    
    private func numberOfSections() -> Int {
       return 1
    }
    
    private func cellForItemAt(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionType {
        case .accounts:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountsCollectionViewCell", for: indexPath)
            //configurator.setupCell(cell)
            return cell
        case .videos:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath)
            //configurator.setupCell(cell)
            return cell
        case .categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath)
            //configurator.setupCell(cell)
            return cell
        }
    }

}

// MARK: - BPCollectionManagerProtocol

extension SearchCollectionViewManager {
    func attach(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
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
       print(indexPath)
    }
}
