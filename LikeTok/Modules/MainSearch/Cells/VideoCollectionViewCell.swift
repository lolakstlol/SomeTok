//
//  VideoCollectionViewCell.swift
//  LikeTok
//
//  Created by Artem Holod on 28.11.21.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(with model: CategoriesPost) {
        if model.media?.count ?? 0 > 0 {
            imageView.setImageFromUrl(urlImage: model.media?[0].preview ?? "")
        } else {
            imageView.backgroundColor = .black
        }
        imageView.contentMode = .scaleAspectFill
        titleLabel.text = model.author?.username
    }
    
    func configure(with model: FeedPost) {
        if model.media.count > 0 {
            debugPrint("----", model.media)
            imageView.setImageFromUrl(urlImage: model.media[0].preview)
        } else {
            imageView.backgroundColor = .black
        }
        imageView.contentMode = .scaleAspectFill
        titleLabel.isHidden = true
//        titleLabel.text = model.author.username
    }
}
