//
//  AccountsCollectionViewCell.swift
//  LikeTok
//
//  Created by Artem Holod on 28.11.21.
//

import UIKit

protocol AcoountCollectionViewCellDelegate: AnyObject {
    func followButtonTap(_ uuid: String)
}

final class AccountsCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var loginLabel: UILabel!
    @IBOutlet private weak var subscribeButton: UIButton!
    
    private var uuid: String?
    
    weak var delegate: AcoountCollectionViewCellDelegate?
    
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
    
    func configure(with model: SearchAccountsDatum, delegate: AcoountCollectionViewCellDelegate) {
        self.delegate = delegate
        self.uuid = model.uuid
        updateSubscribeButton(isFollow: model.isFollow)
        loginLabel.text = model.username ?? ""
        subTitleLabel.text = model.name ?? ""
        if let urlString = model.photo.preview {
            avatarImage.kf.setImage(with: URL(string: urlString))
        } else {
            avatarImage.image = Assets.avatarDefaulth.image
        }
    }
    
    @IBAction func followButtonTap(_ sender: Any) {
        guard let uuid = uuid else {
            return
        }
        delegate?.followButtonTap(uuid)
    }
}
