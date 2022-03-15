//
//  CommentsCellConfigurator.swift
//  LikeTok
//
//  Created by Daniel on 22.01.22.
//

import UIKit

final class CommentsCellConfigurator: CellConfiguration {
    static var cellIdentifier: String = CommentCell.cellIdentifier
    
    private let model: CommentsDatum
    var imageTapAction: ((_ userId: String, _ profileType: String) -> Void)?
    
    init(_ model: CommentsDatum) {
        self.model = model
    }
    
    func setupCell(_ cell: UIView) {
//        guard let cell = cell as? CommentCell else { return }
//        let time = AppDateFormatter.shared.howLongAgoWithDate(with: model.createdAt) ?? ""
//        let name = model.author.name
//        let text = model.message
//        cell.configure(CommentDataModel(text: text, username: name, avatar: model.author.photo.preview, time: time))
//        cell.imageTapAction = { [weak self] in
//            guard let self = self else { return }
//            self.imageTapAction?(self.model.user.userId, self.model.user.profileType)
//        }

    }
    
    func getCellSize(viewSize: CGSize?) -> CGSize {
        guard let viewSize = viewSize else {
            return .zero
        }
        return viewSize
    }
}

struct CommentDataModel {
    let text: String
    let username: String
    let avatar: String?
    let time: String
}
