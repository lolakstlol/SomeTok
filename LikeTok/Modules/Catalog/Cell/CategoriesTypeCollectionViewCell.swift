//
//  CategoriesTypeCollectionViewCell.swift
//  LikeTok
//
//  Created by Artem Holod on 4.12.21.
//

import UIKit

enum CategoriesType: String {
    case material = "material_products"
    case digital = "digital_products"
}

protocol CategoriesTypeCollectionViewCellOutput: AnyObject {
    func didChangeType(type: CategoriesType)
}

class CategoriesTypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var materialButton: UIButton!
    
    weak var delegate: CategoriesTypeCollectionViewCellOutput?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        firstButton.setTitle(Strings.Search.Categories.first, for: .normal)
        materialButton.setTitle(Strings.Search.Categories.second, for: .normal)
        materialButton.layer.cornerRadius = 14
        firstButton.layer.cornerRadius = 14
        containerView.layer.cornerRadius = 17
    }
    
    func configure(withType: CategoriesType) {
        UIView.animate(withDuration: 0.3) {
            switch withType {
            case .material:
                self.materialButton.setTitleColor(.white, for: .normal)
                self.materialButton.backgroundColor = Assets.mainRed.color
                self.firstButton.setTitleColor(Assets.darkGrayText.color, for: .normal)
                self.firstButton.backgroundColor = .clear
            case .digital:
                self.firstButton.setTitleColor(.white, for: .normal)
                self.firstButton.backgroundColor = Assets.mainRed.color
                self.materialButton.setTitleColor(Assets.darkGrayText.color, for: .normal)
                self.materialButton.backgroundColor = .clear
            }
        }
    }

    @IBAction func secondButtonDidTap(_ sender: Any) {
        configure(withType: .material)
        delegate?.didChangeType(type: .material)
    }
    
    @IBAction func firstButtonDidTap(_ sender: Any) {
        configure(withType: .digital)
        delegate?.didChangeType(type: .digital)
    }
}
