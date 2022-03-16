//
//  CommentCell.swift
//  Marketplace
//
//  Created by Mikhail Lutskiy on 29.11.2020.
//  Copyright © 2020 BSL. All rights reserved.
//

import UIKit
import Kingfisher

protocol CommentCellOutput: AnyObject {
    func imageTapAction(_ uuid: String)
}

final class CommentCell: UITableViewCell {
    
    // MARK: - @IBOutlets

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
    private var uuid: String?
    
    weak var output: CommentCellOutput?
        
    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
//        profileImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupImageAction()
    }
    
    // MARK: - Public methods

    func configure(_ data: CommentsDatum, output: CommentCellOutput) {
        self.output = output
        uuid = data.uuid
        commentLabel.text = data.message
        usernameLabel.text = data.author.name
        timeLabel.text = AppDateFormatter.shared.howLongAgoWithDate(with: data.createdAt) ?? ""
        
        if let avatar = data.author.photo.preview {
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
        guard let uuid = uuid else {
            return
        }
        output?.imageTapAction(uuid)
    }
}
