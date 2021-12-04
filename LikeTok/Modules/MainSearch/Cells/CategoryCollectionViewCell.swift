//
//  CategoryCollectionViewCell.swift
//  LikeTok
//
//  Created by Artem Holod on 28.11.21.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionPhotosView: UICollectionView!
    @IBOutlet weak var categoryAvatar: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var moreLabel: UILabel!
    var posts: [CategoriesPost] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryAvatar.backgroundColor = .clear
        let videoCell = UINib.init(nibName: String(describing: VideoCollectionViewCell.self), bundle: nil)
        collectionPhotosView.register(videoCell, forCellWithReuseIdentifier: String(describing: VideoCollectionViewCell.self))
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let sideInset = 10
        let width: CGFloat = 147
        layout.itemSize = CGSize(width: width, height: 197)
        layout.sectionInset = UIEdgeInsets(top: .zero, left: CGFloat(sideInset), bottom: .zero, right: CGFloat(sideInset))
        collectionPhotosView.showsHorizontalScrollIndicator = false
        collectionPhotosView.dataSource = self
        collectionPhotosView.reloadData()
        collectionPhotosView.setCollectionViewLayout(layout, animated: false)
    }
    
    func configure(with model: CategoriesDatum) {
        categoryTitle.text = model.name
        posts = model.posts ?? []
        collectionPhotosView.reloadData()
        moreLabel.text = Strings.Search.more
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        collectionPhotosView.reloadData()
    }
}

extension CategoryCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
        cell.configure(with: posts[indexPath.row])
        return cell
    }
}
