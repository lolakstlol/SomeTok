//
//  ResetPasswordNewPasswordResetPasswordNewPasswordViewController.swift
//  LikeTok
//
//  Created by Danik on 24/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class ResetPasswordNewPasswordViewController: BaseViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var enterPasswordTextField: InsetTextField!
    @IBOutlet private weak var confrimPasswordTextField: InsetTextField!
    @IBOutlet private weak var resumeButton: UIButton!
    
    private let keyboardObserver = KeyboardObserver()
    private lazy var tapWhenKeyboardAppears = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    
    var presenter: ResetPasswordNewPasswordPresenterInput!

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
    
    @IBAction func onResumeButtonTap(_ sender: Any) {
        guard let passwordOne = enterPasswordTextField.text,
              let passwordTwo = confrimPasswordTextField.text, passwordOne == passwordTwo
        else {
            return
        }
        presenter.resetPassword(passwordOne)
    }
    
}

extension ResetPasswordNewPasswordViewController: ResetPasswordNewPasswordPresenterOutput {
    
    func onViewDidLoad() {
        titleLabel.text = Strings.ResetPassword.NewPassword.title
        titleLabel.textColor = Assets.blackText.color
        
        textLabel.text = Strings.ResetPassword.NewPassword.text
        textLabel.textColor = Assets.darkGrayText.color
        
        enterPasswordTextField.backgroundColor = Assets.lightGray.color
        enterPasswordTextField.textColor = Assets.blackText.color
        
        confrimPasswordTextField.backgroundColor = Assets.lightGray.color
        confrimPasswordTextField.textColor = Assets.blackText.color
        
        resumeButton.setTitle(Strings.ResetPassword.NewPassword.resume, for: .normal)
        resumeButton.setTitleColor(Assets.whiteText.color, for: .normal)
        resumeButton.tintColor = Assets.whiteText.color
        resumeButton.backgroundColor = Assets.mainRed.color
        resumeButton.layer.cornerRadius = 10
    }
    
    func onResetPasswordSucess() {
        
    }
    
    func onResetPasswordFailure() {
        presenter.showAlert()
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
