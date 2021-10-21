//
//  OnboardingCollectionViewCell.swift
//  LikeTok
//
//  Created by Daniil Stelchenko on 20.10.21.
//

import UIKit

final class OnboardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    static var identifier = "OnboardingCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configureCell(_ data: OnboardingPage) {
        imageView.image = data.image
        titleLabel.text = data.title
        descriptionLabel.text = data.description
    }

}
