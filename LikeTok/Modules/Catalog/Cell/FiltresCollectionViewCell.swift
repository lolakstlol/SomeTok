//
//  FiltresCollectionViewCell.swift
//  LikeTok
//
//  Created by Artem Holod on 4.12.21.
//

import UIKit

class FiltresCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10
        containerView.layer.borderColor = Assets.darkGrayText.color.cgColor
        containerView.layer.borderWidth = 1
        titleLabel.text = Strings.Filtres.plug
    }

}
