//
//  ResetPasswordResetPasswordPresenter.swift
//  LikeTok
//
//  Created by Danik on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation
import UIKit


enum PasswordRecoveryError: Error, LocalizedError {
    case invalidEmail
    
    var errorDescription: String? {
        get {
            switch self {
            case .invalidEmail:
                return Strings.ResetPassword.Email.badEmail
            }
        }
    }
}


final class PasswordRecoveryFirstPresenter {
    
    private unowned let view: PasswordRecoveryFirstPresenterOutput
    private var isKeyboardAppears: Bool = false
    private let apiWorker = AuthApiWorker()
    
    init(_ view: PasswordRecoveryFirstPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
        view.onViewDidLoad()
    }
    
    
    func viewWillAppear() {
        view.onViewWillAppear()
    }
    
    
    private func configureAlert(_ error: Error) -> UIAlertController {
        let alert = UIAlertController(title: Strings.ResetPassword.error, message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }

}

extension PasswordRecoveryFirstPresenter: PasswordRecoveryFirstPresenterInput {
    
    func showAlert(_ error: Error) {
        let alert = configureAlert(error)
        view.onShowAlert(alert)
    }

    func resetPassword(_ email: String) {
        if email.isValidEmail {
            apiWorker.recoveryPassword(email) { [weak self] response in
                switch response {
                case .success(_):
                    self?.view.onResetPasswordSucess()
                case .failure(let error):
                    self?.view.onResetPasswordFailure(error)
                }
            }
        } else {
            view.onResetPasswordFailure(PasswordRecoveryError.invalidEmail)
        }
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
