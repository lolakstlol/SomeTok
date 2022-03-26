//
//  CategoryCollectionViewCell.swift
//  LikeTok
//
//  Created by Artem Holod on 28.11.21.
//

import UIKit

protocol CategoryCollectionViewCellDelegate: AnyObject {
    func didTapVideo(_ dataSourse: [FeedPost], index: Int)
}

final class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionPhotosView: UICollectionView!
    @IBOutlet weak var categoryAvatar: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var moreLabel: UILabel!
    
    var posts: [FeedPost] = []
    weak var delegate: CategoryCollectionViewCellDelegate?
    
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
        collectionPhotosView.delegate = self
        collectionPhotosView.reloadData()
        collectionPhotosView.setCollectionViewLayout(layout, animated: false)
    }
    
    func configure(with model: CategoriesDatum, delegate: CategoryCollectionViewCellDelegate) {
        self.delegate = delegate
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

extension CategoryCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapVideo(posts, index: indexPath.row)
    }
}
