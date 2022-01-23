//
//  CommentsViewController.swift
//  LikeTok
//
//  Created by Daniel on 21.01.22.
//

import UIKit

final class CommentsViewController: UIViewController {

    @IBOutlet private var commentContainerView: UIView!
    @IBOutlet private var commentBorderedView: UIView!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var sendButton: UIButton!
    @IBOutlet private var messagePlaceholderLabel: UILabel!
    @IBOutlet private var commentTextView: UITextView!
    @IBOutlet private var minHeightConstraint: NSLayoutConstraint!
    
    private enum Constants {
        static let topBottomInputInsets: CGFloat = 11
        static let leftInputInsets: CGFloat = 16
        static let rightInputInsets: CGFloat = 47
        static let lineHeight: CGFloat = 20
        static let maxLineHeight: CGFloat = 124
        static let maxNumberOfLines: Int = 4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        commentBorderedView.layer.cornerRadius = 24
        commentBorderedView.clipsToBounds = true
        commentBorderedView.layer.borderColor = UIColor(red: 235/255, green: 234/255, blue: 236/255, alpha: 1).cgColor
        commentBorderedView.layer.borderWidth = 1
    }
    
//    func setupUI() {
//        showLoader()
//        tableView.contentInset = .init(top: 0, left: 0, bottom: messageInputView.frame.height, right: 0)

//        tableManager.attach(tableView)
//        tableManager.output = self
//        messageTextView.layer.borderColor = Asset.Colors.General.gray1.color.cgColor
//        messageTextView.delegate = self
//        messageTextView.textContainerInset = UIEdgeInsets(top: Constants.topBottomInputInsets,
//                                                          left: Constants.leftInputInsets,
//                                                          bottom: Constants.topBottomInputInsets,
//                                                          right: Constants.rightInputInsets)
//
//        sendButton.isEnabled = false
//
//        let tap = UITapGestureRecognizer(target: self, action: #selector(hideCover))
//        coverView.addGestureRecognizer(tap)
//
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(self,
//                                       selector: #selector(keyboardWillShow(notification:)),
//                                       name: UIResponder.keyboardWillShowNotification,
//                                       object: nil)
//        notificationCenter.addObserver(self,
//                                       selector: #selector(keyboardWillHide(notification:)),
//                                       name: UIResponder.keyboardWillHideNotification,
//                                       object: nil)
//
//        tableManager.cellImageTapAction = { userId, profileType in
//            self.presenter.cellImageTouchUpInside(userId, profileType)
//        }
//    }


}

extension CommentsViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        let resultValue = presenter.textViewShouldBeginEditing()
//        coverView.isHidden = !resultValue
//        return resultValue
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
//        coverView.isHidden = true
        minHeightConstraint.constant = Constants.lineHeight
    }
    
    func textViewDidChange(_ textView: UITextView) {
        sendButton.isEnabled = !textView.text.isEmpty
        messagePlaceholderLabel.isHidden = !textView.text.isEmpty
//        tableView.contentInset = .init(top: .zero, left: .zero, bottom: messageInputView.frame.height, right: .zero)
        
        if textView.numberOfLines > Constants.maxNumberOfLines {
            textView.isScrollEnabled = true
            minHeightConstraint.constant = Constants.maxLineHeight
        } else if textView.numberOfLines == Constants.maxNumberOfLines {
            textView.isScrollEnabled = false
        } else {
            minHeightConstraint.constant -= Constants.lineHeight
        }
    }
}
