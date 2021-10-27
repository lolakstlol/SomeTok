//
//  ResetPasswordResetPasswordPresenter.swift
//  LikeTok
//
//  Created by Danik on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation
import UIKit

final class ResetPasswordEmailPresenter {
    
    private unowned let view: ResetPasswordEmailPresenterOutput
    private var isKeyboardAppears: Bool = false

    init(_ view: ResetPasswordEmailPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
        view.onViewDidLoad()
    }

}

extension ResetPasswordEmailPresenter: ResetPasswordEmailPresenterInput {

    func resetPassword(_ email: String) {
        email.isValidEmail ? view.onResetPasswordSucess() : view.onResetPasswordFailure()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: Strings.ResetPassword.error, message: Strings.ResetPassword.Email.error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
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
