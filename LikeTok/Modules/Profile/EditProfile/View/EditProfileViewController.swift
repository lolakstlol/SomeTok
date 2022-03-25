//
//  EditProfileViewController.swift
//  LikeTok
//
//  Created by Daniel on 19.02.22.
//

import UIKit
import PhotosUI

class EditProfileViewController: BaseViewController {

    @IBOutlet weak var navigationLabel: UILabel!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
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
    
    @IBAction func doneButtonTap(_ sender: Any) {
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
    
    @IBAction func backButtonTap(_ sender: Any) {
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
        showToast(error.localizedDescription, toastType: .failured)
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
        
        cityTextField.delegate = self
        countyTextField.delegate = self
    }
    
    func setupNavigationBar() {
        navigationLabel.text = "Изменить профиль"
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.isHidden = true
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
        showToast(error.localizedDescription, toastType: .failured)
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

extension EditProfileViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case cityTextField:
            let vc = FilterCurrentAssembler.createModule(type: .city, completion: { [weak self] data in
                guard let selectedCity = data as? CityDictionary
                else {
                    return
                }
                self?.cityTextField.text = selectedCity.name
            })
            navigationController?.pushViewController(vc, animated: true)
        case countyTextField:
            let vc = FilterCurrentAssembler.createModule(type: .country, completion: { data in
                guard let selectedCountry = data as? CountryDictionary
                else {
                    return
                }
                self.countyTextField.text = selectedCountry.name
            })
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        return false
    }
}
