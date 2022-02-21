//
//  EditProfileViewController.swift
//  LikeTok
//
//  Created by Daniel on 19.02.22.
//

import UIKit
import PhotosUI

class EditProfileViewController: BaseViewController {

    @IBOutlet weak var usernameTextField: InsetTextField!
    @IBOutlet weak var loginTextField: InsetTextField!
    @IBOutlet weak var emailTextField: InsetTextField!
    @IBOutlet weak var phoneNumberTextField: InsetTextField!
    @IBOutlet weak var countyTextField: InsetTextField!
    @IBOutlet weak var cityTextField: InsetTextField!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    
    private let imagePickerController = UIImagePickerController()
    private var avatarImage: UIImage? = nil
    private var avatarString: String? = nil
    
    private let keyboardObserver = KeyboardObserver()
    private lazy var tapWhenKeyboardAppears = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    
    var presenter: EditProfilePresenterInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        addKeyboardObservers()
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
    
    private func showImagePicker(_ mediaTypes: [String]) {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = mediaTypes
        present(imagePickerController, animated: true, completion: nil)
    }

    @objc private func doneButtonTap() {
        showLoader()
        let newModel = EditProfileModel(avatar: avatarString,
                                        name: usernameTextField.text ?? "",
                                        username: loginTextField.text ?? "",
                                        email: emailTextField.text ?? "",
                                        phone: phoneNumberTextField.text ?? "",
                                        country: countyTextField.text ?? "",
                                        city: cityTextField.text ?? "",
                                        description: descriptionTextField.text ?? "")
        presenter.onDoneButtonTap(newModel)
    }
    
    @objc private func backButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func avatarDidTap() {
        presenter.avatarDidTap()
    }
    
}

extension EditProfileViewController: EditProfilePresenterOutput {
    func onUploadPhotoSuccess(_ preview: String) {
        avatarString = preview
        hideLoader()
    }
    
    func onUploadPhotoFailure(_ error: Error) {
        hideLoader()
        showToast(error.localizedDescription)
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
    
    func setupUI() {
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(avatarDidTap))
        gesture.numberOfTapsRequired = 1
        avatarImageView?.isUserInteractionEnabled = true
        avatarImageView?.addGestureRecognizer(gesture)
        avatarImageView.layer.cornerRadius = 65
        avatarImageView.clipsToBounds = true
        
        title = "Изменить профиль"
        navigationController?.setNavigationBarHidden(false, animated: false)
        let backButton = UIBarButtonItem(image: Assets.backButton.image, style: .plain, target: self, action: #selector(backButtonTap))
        let dotsBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonTap))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = dotsBarButtonItem
        navigationController?.navigationItem.rightBarButtonItem?.tintColor = .systemRed
        navigationController?.navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    func openPickerView() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = false
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func onUpdateSuccess() {
        hideLoader()
        navigationController?.popViewController(animated: true)
    }
    
    func onUpdateFailure(_ error: NetworkError) {
        hideLoader()
        showToast(error.localizedDescription)
    }
    
    func setupUserData(_ model: EditProfileModel) {
        avatarImageView.kf.setImage(with: URL(string: model.avatar ?? ""))
        usernameTextField.text = model.name
        loginTextField.text = model.username
        emailTextField.text = model.email
        phoneNumberTextField.text = model.phone
        countyTextField.text = model.country
        cityTextField.text = model.city
        descriptionTextField.text = model.description
    }
    
}

extension EditProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        avatarImageView.image = image
        presenter.uploadAvatar(image: image)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        showLoader()
        guard let image = info[.originalImage] as? UIImage else { return }
        avatarImageView.image = image
        presenter.uploadAvatar(image: image)
    }
}
