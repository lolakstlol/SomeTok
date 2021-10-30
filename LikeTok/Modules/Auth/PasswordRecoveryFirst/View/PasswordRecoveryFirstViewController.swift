//
//  ResetPasswordResetPasswordViewController.swift
//  LikeTok
//
//  Created by Danik on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class PasswordRecoveryFirstViewController: BaseViewController {
    
     @IBOutlet private weak var titleLabel: UILabel!
     @IBOutlet private weak var textLabel: UILabel!
     @IBOutlet private weak var scrollView: UIScrollView!
     @IBOutlet private weak var resumeButton: UIButton!
     @IBOutlet private weak var emailTextField: InsetTextField!
     
     private let keyboardObserver = KeyboardObserver()
     private lazy var tapWhenKeyboardAppears = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
     
     var presenter: PasswordRecoveryFirstPresenterInput!

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
        guard let email = emailTextField.text else {
            return
        }
        presenter.resetPassword(email)
    }
}

extension PasswordRecoveryFirstViewController: PasswordRecoveryFirstPresenterOutput {
     
     func onResetPasswordFailure(_ error: NetworkError) {
//          presenter.showAlert(error)
          presenter.onComplete()
     }
     
     func onViewDidLoad() {
          titleLabel.text = Strings.ResetPassword.Email.title
          titleLabel.textColor = Assets.blackText.color
          
          textLabel.text = Strings.ResetPassword.Email.text
          textLabel.textColor = Assets.darkGrayText.color
          
          emailTextField.backgroundColor = Assets.lightGray.color
          emailTextField.textColor = Assets.blackText.color
          
          resumeButton.setTitle(Strings.ResetPassword.Email.resume, for: .normal)
          resumeButton.setTitleColor(Assets.whiteText.color, for: .normal)
          resumeButton.tintColor = Assets.whiteText.color
          resumeButton.backgroundColor = Assets.mainRed.color
          resumeButton.layer.cornerRadius = 10
     }
     
     func onResetPasswordSucess(completion: @escaping EmptyClosure) {
          let vc = PasswordRecoverySecondAssembler.createModule {
               completion()
          }
          navigationController?.pushViewController(vc, animated: true)
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
