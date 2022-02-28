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
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    
	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction func uploadbuttonDidTap(_ sender: Any) {
    }
}

extension CreatePrivatePostViewController: CreatePrivatePostPresenterOutput {
    
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
