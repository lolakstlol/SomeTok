//
//  Constants.swift
//  LikeTok
//
//  Created by Daniel on 7.11.21.
//

import UIKit

enum Constants {
    enum Feed {
        static let minFeedIndexDifference = 5
        static let cellMenuTopConstraint: CGFloat = UIScreen.main.bounds.height / 8.45
        static let deleteMenuHeight: CGFloat = 207
        static let minScrollSizeToRefresh: CGFloat = 120
        static let topBottomInputInsetConstraint: CGFloat = 10
        static let rightLeftInputInsetConstraint: CGFloat = 16
        static let standartBottomInputConstraint: CGFloat = 8
        static let rightInputWithButtonInsetConstraint: CGFloat = 16
        static let maxMessageTextViewMinHeightConstraint: CGFloat = 128
        static let minMessageTextViewMinHeightConstraint: CGFloat = 44
        static let messageTextViewLineHeight: CGFloat = 20
        static let maxMessageTextViewNumberOfLines: Int = 5
    }
}
