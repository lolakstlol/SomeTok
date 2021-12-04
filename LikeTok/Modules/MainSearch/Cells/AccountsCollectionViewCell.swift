//
//  AccountsCollectionViewCell.swift
//  LikeTok
//
//  Created by Artem Holod on 28.11.21.
//

import UIKit

class AccountsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var subscribeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    
    private func setupView() {
        avatarImage.layer.cornerRadius = 22
        updateSubscribeButton(isFollow: false)
    }
    
    private func updateSubscribeButton(isFollow: Bool) {
        subscribeButton.layer.cornerRadius = 5
        subscribeButton.layer.borderColor =  Assets.darkGrayText.color.cgColor
        subscribeButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        if isFollow {
            subscribeButton.setTitle(Strings.Search.Accounts.unsub, for: .normal)
            subscribeButton.setTitleColor(Assets.darkGrayText.color, for: .normal)
            subscribeButton.backgroundColor = .white
            subscribeButton.layer.borderWidth = 1
        } else {
            subscribeButton.setTitle(Strings.Search.Accounts.sub, for: .normal)
            subscribeButton.setTitleColor(.white, for: .normal)
            subscribeButton.backgroundColor = Assets.mainRed.color
            subscribeButton.layer.borderWidth = 0
        }
    }
    
    func configure(with model: SearchAccountsDatum) {
        updateSubscribeButton(isFollow: model.isFollow)
        loginLabel.text = model.username ?? ""
        subTitleLabel.text = model.name ?? ""
        avatarImage.setImageFromUrl(urlImage: model.photo.preview ?? "")
    }
}
