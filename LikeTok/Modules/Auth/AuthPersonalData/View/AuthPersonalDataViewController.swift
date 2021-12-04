import UIKit
import PhotosUI

final class AuthPersonalDataViewController: BaseViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarContainer: UIView!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var nameLabel: InsetTextField!
    @IBOutlet weak var numberLabel: InsetTextField!
    var presenter: AuthPersonalDataPresenterInput!
    let imagePickerController = UIImagePickerController()
    var avatarImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func continueButtonDidTap(_ sender: Any) {
        presenter.continueButtonDidTap(name: nameLabel.text, phone: numberLabel.text)
    }
    
    @objc
    func avatarDidTap() {
        presenter.avatarDidTap()
    }
    
    private func showImagePicker(_ mediaTypes: [String]) {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = mediaTypes
        present(imagePickerController, animated: true, completion: nil)
    }
}

extension AuthPersonalDataViewController: AuthPersonalDataPresenterOutput {
    func openPickerView() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = false
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func setupView() {
        numberLabel.placeholder = Strings.AuthPersonalData.number
        nameLabel.placeholder = Strings.AuthPersonalData.namePlaceholder
        titleLabel.text = Strings.AuthPersonalData.title
        subtitleLabel.text = Strings.AuthPersonalData.subTitle
        continueButton.setTitle(Strings.AuthPersonalData.button, for: .normal)
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(avatarDidTap))
        gesture.numberOfTapsRequired = 1
        avatarView?.isUserInteractionEnabled = true
        avatarView?.addGestureRecognizer(gesture)
        avatarView.layer.cornerRadius = 65
    }
}

extension AuthPersonalDataViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        avatarView.image = image
        presenter.uploadAvatar(image: image)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else { return }
        avatarView.image = image
        presenter.uploadAvatar(image: image)
    }
}
