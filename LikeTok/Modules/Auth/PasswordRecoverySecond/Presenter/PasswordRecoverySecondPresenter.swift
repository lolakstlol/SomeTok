//
//  ResetPasswordNewPasswordResetPasswordNewPasswordPresenter.swift
//  LikeTok
//
//  Created by Danik on 24/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation
import UIKit

final class PasswordRecoverySecondPresenter {
    
    private unowned let view: PasswordRecoverySecondPresenterOutput
    private let apiWorker = AuthApiWorker()
    private var isKeyboardAppears: Bool = false
    var onFinishFlow: EmptyClosure? = nil
    
    init(_ view: PasswordRecoverySecondPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
        view.onViewDidLoad()
    }
    
    func viewWillAppear() {
        view.onViewWillAppear()
    }
    
    private func configureAlert(_ error: Error) -> UIAlertController {
        let alert = UIAlertController(title: Strings.PasswordRecovery.error, message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
    
    func resetPassword(_ email: String, password: String, code: String) {
//        if email.isValidEmail {
//            apiWorker.recoveryPassword(email, password: password, code: code) { [weak self] response in
//                switch response {
//                case .success(_):
//                    self?.view.onResetPasswordSucess()
//                case .failure(let error):
//                    self?.view.onResetPasswordFailure(error)
//                }
//            }
//        } else {
//            self.view.onResetPasswordSucess()

//            view.onResetPasswordFailure(PasswordRecoveryError.invalidEmail)
//        }
    }
}


extension PasswordRecoverySecondPresenter: PasswordRecoverySecondPresenterInput {
    
    func resetPassword(_ password: String, code: String) {
        if password.isValidPassword {
            
        } else {
            view.onResetPasswordFailure(PasswordRecoveryError.invalidPassword)
        }
    }
    
    func showAlert(_ error: Error) {
        let alert = configureAlert(error)
        view.onShowAlert(alert)
    }
    
    func showKeyboard(_ info: KeyboardObserver.KeyboardInfo) {
        if !isKeyboardAppears {
            let kbSize = info.keyboardBounds
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
            isKeyboardAppears = true
            view.onShowKeyboard(insets)
        }

    }
    
    func hideKeyboard() {
        if isKeyboardAppears {
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            isKeyboardAppears = false
            view.onHideKeyboard(insets)
        }
    }

}
