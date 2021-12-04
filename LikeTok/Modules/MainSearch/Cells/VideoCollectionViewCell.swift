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
    
    func configure(with model: CategoriesPost) {
        if model.media?.count ?? 0 > 0 {
            imageView.setImageFromUrl(urlImage: model.media?[0].preview ?? "")
        } else {
            imageView.backgroundColor = .black
        }
        imageView.contentMode = .scaleAspectFill
        titleLabel.text = model.author?.username
    }
}
