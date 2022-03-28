//
//  ProfileCollectionViewCell.swift
//  LikeTok
//
//  Created by Daniel on 17.02.22.
//

import UIKit

final class ProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    static var id = "ProfileCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
