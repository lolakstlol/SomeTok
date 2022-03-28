//
//  ChangePasswordPresenter.swift
//  LikeTok
//
//  Created by Daniel on 24.03.22.
//

import Foundation
import UIKit

final class ChangePasswordPresenter {
    
    private unowned let view: ChangePasswordPresenterOutput
    private let apiWorker = AuthApiWorker()
    private var isKeyboardAppears: Bool = false
    
    var onFinishFlow: EmptyClosure? = nil
    var userEmail: String? = ""
    
    init(_ view: ChangePasswordPresenterOutput) {
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
}


extension ChangePasswordPresenter: ChangePasswordPresenterInput {
    func changePassword(oldPassword: String, newPassword: String) {
        if oldPassword.isValidPassword && newPassword.isValidPassword {
            apiWorker.changePassword(oldPassword: oldPassword, newPassword: newPassword, completion: { [weak self] response in
                switch response {
                case .success(_):
                    self?.view.onResetPasswordSucess()
                case .failure(let error):
                    self?.view.onResetPasswordFailure(error)
                }
            })
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
