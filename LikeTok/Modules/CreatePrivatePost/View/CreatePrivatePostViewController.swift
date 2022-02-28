//
//  CreatePrivatePostCreatePrivatePostViewController.swift
//  LikeTok
//
//  Created by Artem Holod on 22/02/2022.
//  Copyright © 2022 LikeTok. All rights reserved.
//

import UIKit

final class CreatePrivatePostViewController: BaseViewController {
	var presenter: CreatePrivatePostPresenterInput!
    private let keyboardObserver = KeyboardObserver()
    private lazy var tapWhenKeyboardAppears = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        addKeyboardObservers()
    }
    
    @IBAction func uploadbuttonDidTap(_ sender: Any) {
        presenter.uploadVideo(with: descriptionTextView.text)
    }
}

extension CreatePrivatePostViewController: CreatePrivatePostPresenterOutput {
    func didPublishPost() {
//        guard let tabBar = tabBarController as? TabBarViewController else { return }
//        tabBar.returnToPreviositem()
        navigationController?.popToRootViewController(animated: false)
    }

    func setupView() {
        descriptionTextView.delegate = self
        previewImageView.layer.cornerRadius = 5
        uploadButton.layer.cornerRadius = 10
        uploadButton.setTitle(Strings.Camera.upload, for: .normal)
        title = Strings.Camera.Publication.nonad
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Assets.backButton.image, style: .plain, target: self, action: #selector(backButton))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc private func backButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupPreview(preview: Data) {
        if let image = UIImage(data: preview) {
            previewImageView.image = image
        }
    }
    
    private func addKeyboardObservers() {
        keyboardObserver.keyboardWillShow = { [weak self] info in
            guard let self = self else { return }
            self.keyboardWillShow(info)
        }

        keyboardObserver.keyboardWillHide = { [weak self] info in
            guard let self = self else { return }
            self.keyboardWillHide(info)
        }
    }
   
    private func keyboardWillHide(_ info: KeyboardObserver.KeyboardInfo) {
         view.removeGestureRecognizer(tapWhenKeyboardAppears)
         presenter.hideKeyboard()

    }

    private func keyboardWillShow(_ info: KeyboardObserver.KeyboardInfo) {
         view.addGestureRecognizer(tapWhenKeyboardAppears)
         presenter.showKeyboard(info)
    }
    
    func onShowKeyboard(_ insets: UIEdgeInsets) {
         scrollView.contentInset = insets
         scrollView.scrollIndicatorInsets = insets

         UIView.animate(withDuration: 0.4) {
             self.view.setNeedsLayout()
         }
    }
    
    func onHideKeyboard(_ insets: UIEdgeInsets) {

         scrollView.contentInset = insets
         scrollView.scrollIndicatorInsets = insets
        
         UIView.animate(withDuration: 0.4) {
             self.view.setNeedsLayout()
         }
    }
}

extension CreatePrivatePostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Strings.Camera.descriptionPlaceholder
            textView.textColor = UIColor.lightGray
        }
    }
}
