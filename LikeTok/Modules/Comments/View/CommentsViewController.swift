//
//  CommentsViewController.swift
//  LikeTok
//
//  Created by Daniel on 21.01.22.
//

import UIKit
import PanModal


final class CommentsViewController: BaseViewController {

    @IBOutlet private var panView: UIView!
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var commentContainerView: UIView!
    @IBOutlet private var commentBorderedView: UIView!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var sendButton: UIButton!
    @IBOutlet private var coverView: UIView!
    @IBOutlet private var messagePlaceholderLabel: UILabel!
    @IBOutlet private var commentTextView: UITextView!
    @IBOutlet private var minHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var bottomConstraint: NSLayoutConstraint!
    
    private var comments: [CommentsDatum] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var presenter: CommentsPresenterInput!
    
    private enum Constants {
        static let lineHeight: CGFloat = 20
        static let maxLineHeight: CGFloat = 80
        static let maxNumberOfLines: Int = 4
    }
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    // MARK: - @IBActions
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame: CGRect = view.convert(keyboardScreenEndFrame, from: view.window)
        
        bottomConstraint.constant = keyboardViewEndFrame.height
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.coverView.alpha = 0.3
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.constant = 44
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.coverView.alpha = 0
        }
    }
    
    @objc private func hideCover() {
        commentTextView.resignFirstResponder()
    }
    
    @IBAction func sendButtonTap(_ sender: Any) {
        presenter.sendComment(commentTextView.text)
        commentTextView.text = ""
        showLoader()
    }
}

extension CommentsViewController: CommentsPresenterOutput {
    func onCommentPostSuccess(_ newComment: CommentsDatum) {
        hideLoader()
        comments.append(newComment)
        DispatchQueue.main.async {
            self.tableView.scrollToBottom()
        }
    }
    
    func onCommentPostFailure(_ error: NetworkError) {
        hideLoader()
        showToast(error.localizedDescription, toastType: .failured)
    }
    
    
    func openOtherProfile(_ viewController: OtherProfileViewController) {
//        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func onScrolledToBottom() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
    }
    
    func onListEnd() {
        tableView.tableFooterView = nil
    }
    
    func onCommentPosted() {
        commentTextView.text = ""
        hideLoader()
        presenter.fetchMoreComments()
    }
    
    func setupComments(_ comments: [CommentsDatum]) {
        self.comments += comments
    }
    
    func setupUI() {
        
        coverView.alpha = 0
        commentTextView.delegate = self
        
        panView.layer.cornerRadius = 2
        panView.clipsToBounds = true
        
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        commentContainerView.addShadow(location: .top, opacity: 0.05)
        
        commentBorderedView.layer.cornerRadius = 24
        commentBorderedView.clipsToBounds = true
        commentBorderedView.layer.borderColor = UIColor(red: 235/255, green: 234/255, blue: 236/255, alpha: 1).cgColor
        commentBorderedView.layer.borderWidth = 1
//        showLoader()
        tableView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nibOfClass: CommentCell.self)
        tableView.contentInsetAdjustmentBehavior = .never
        
        sendButton.layer.cornerRadius = 20
        sendButton.clipsToBounds = true
        sendButton.isEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideCover))
        coverView.addGestureRecognizer(tap)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillShow(notification:)),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillHide(notification:)),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)

    }
}

extension CommentsViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height) {
            presenter.fetchMoreComments()
        }
    }
}


extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.cellIdentifier, for: indexPath) as! CommentCell
        let model = comments[indexPath.row]
        cell.configure(model, output: self)
        return cell
    }
    
}

extension CommentsViewController: CommentCellOutput {
    func imageTapAction(_ uuid: String) {
        presenter.profileTapAction(uuid)
    }
}

extension CommentsViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        let resultValue = presenter.textViewShouldBeginEditing()
//        coverView.isHidden = !resultValue
//        return resultValue
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        minHeightConstraint.constant = Constants.lineHeight
    }
    
    func textViewDidChange(_ textView: UITextView) {
        sendButton.isEnabled = !textView.text.isEmpty
        messagePlaceholderLabel.isHidden = !textView.text.isEmpty
        
        if textView.text.isEmpty {
            minHeightConstraint.constant = Constants.lineHeight
            textView.isScrollEnabled = false
        } else if textView.numberOfLines > Constants.maxNumberOfLines {
            textView.isScrollEnabled = true
            minHeightConstraint.constant = Constants.maxLineHeight
        } else if textView.numberOfLines == Constants.maxNumberOfLines {
            textView.isScrollEnabled = false
        } else {
            minHeightConstraint.constant -= Constants.lineHeight
        }
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}


extension CommentsViewController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeight
    }
    
    var showDragIndicator: Bool {
        return false
    }
    
    var panModalBackgroundColor: UIColor {
        return .clear
    }
}
