//
//  ChangePasswordViewController.swift
//  LikeTok
//
//  Created by Daniel on 24.03.22.
//

import UIKit

final class ChangePasswordViewController: BaseViewController {
    
    @IBOutlet private weak var navigationLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var oldPasswordTextField: InsetTextField!
    @IBOutlet private weak var newPasswordTextField: InsetTextField!
    @IBOutlet private weak var newPasswordConfrimTextField: InsetTextField!
    @IBOutlet private weak var resumeButton: UIButton!
    
    private let keyboardObserver = KeyboardObserver()
    private lazy var tapWhenKeyboardAppears = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    
    var presenter: ChangePasswordPresenterInput!

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
    
    @IBAction private func onResumeButtonTap(_ sender: Any) {
        guard let oldPassword = oldPasswordTextField.text,
              let newPassword = newPasswordTextField.text,
              let newPasswordConfrim = newPasswordConfrimTextField.text
        else {
            return
        }
        if newPassword == newPasswordConfrim {
            presenter.changePassword(oldPassword: oldPassword, newPassword: newPassword)
            showLoader()
        } else {
            showToast("Проверьте новый пароль", toastType: .failured)
        }
    }
    
    @IBAction func recoverButtonTap(_ sender: Any) {
    
    }

    @IBAction func backButtonTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func forgotPasswordButtonTap(_ sender: Any) {
        let controller = PasswordRecoveryFirstAssembler.createModule()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ChangePasswordViewController: ChangePasswordPresenterOutput {
    
    func onViewDidLoad() {
        titleLabel.text = "Смена пароля"//Strings.PasswordRecovery.Second.title
        titleLabel.textColor = Assets.blackText.color
        
        oldPasswordTextField.backgroundColor = Assets.lightGray.color
        oldPasswordTextField.textColor = Assets.blackText.color
//        oldPasswordTextField.placeholder = Strings.PasswordRecovery.Second.code
        
        newPasswordTextField.backgroundColor = Assets.lightGray.color
        newPasswordTextField.textColor = Assets.blackText.color
//        newPasswordTextField.placeholder = Strings.PasswordRecovery.Second.enterThePassword
        
        newPasswordConfrimTextField.backgroundColor = Assets.lightGray.color
        newPasswordConfrimTextField.textColor = Assets.blackText.color
//        newPasswordTextField.placeholder = Strings.PasswordRecovery.Second.enterThePassword
        
        resumeButton.setTitle(Strings.PasswordRecovery.Second.resume, for: .normal)
        resumeButton.setTitleColor(Assets.whiteText.color, for: .normal)
        resumeButton.tintColor = Assets.whiteText.color
        resumeButton.backgroundColor = Assets.mainRed.color
        resumeButton.layer.cornerRadius = 10
        
    }
    
    func onViewWillAppear() {
        navigationLabel.text = "Смена пароля"
        navigationController?.navigationBar.isHidden = true
    }
    
    func onResetPasswordSucess() {
        hideLoader()
        showToast("Пароль успешно изменен", toastType: .successed)
//        navigationController?.popToViewController(ofClass: SignInViewController.self, animated: true)
    }
    
    func onResetPasswordFailure(_ error: T) {
//        presenter.showAlert(error)
        hideLoader()
        showToast(error.localizedDescription, toastType: .failured)
    }
    
    func onShowAlert(_ alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
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
