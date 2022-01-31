//
//  CommentCell.swift
//  Marketplace
//
//  Created by Mikhail Lutskiy on 29.11.2020.
//  Copyright © 2020 BSL. All rights reserved.
//

import UIKit
import Kingfisher

final class CommentCell: UITableViewCell {
    
    // MARK: - @IBOutlets

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
    var imageTapAction: VoidHandler?
    
    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupImageAction()
    }
    
    // MARK: - Public methods

    func configure(_ data: CommentDataModel) {
        commentLabel.text = data.text
        usernameLabel.text = data.username
        timeLabel.text = data.time
        
        if let avatar = data.avatar {
            profileImageView.kf.setImage(with: URL(string: avatar))
        } else {
            profileImageView.image = Assets.avatarDefaulth.image
        }

    }
    
    // MARK: - Private methods
    
    private func setupImageAction() {
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTouchUpInside)))
        profileImageView.isUserInteractionEnabled = true
    }
    
    // MARK: - @IBActions
    
    @IBAction private func imageTouchUpInside() {
        imageTapAction?()
    }
}
