//
//  ResetPasswordResetPasswordPresenter.swift
//  LikeTok
//
//  Created by Danik on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation
import UIKit

enum PasswordRecoveryError: String, Error {
    case badEmailError
    case responseError
    case noUserError
    
    var text: String {
        switch self {
        case .badEmailError:
            return Strings.ResetPassword.Email.badEmail
        case .responseError:
            return Strings.ResetPassword.Email.responseError
        case .noUserError:
            return Strings.ResetPassword.Email.noUserError
        }
        
    }
}

final class PasswordRecoveryFirstPresenter {
    
    private unowned let view: PasswordRecoveryFirstPresenterOutput
    private var isKeyboardAppears: Bool = false
    private let apiWorker = AuthApiWorker()
    var onFinishFlow: EmptyClosure? = nil
    
    init(_ view: PasswordRecoveryFirstPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
        view.onViewDidLoad()
    }
    
    
    private func processError(_ error: NetworkError) -> PasswordRecoveryError {
        switch error {
        case .other(let statusCode):
            return statusCode == 422 ? .noUserError: .responseError
        default:
            return .responseError
        }
    }

}

extension PasswordRecoveryFirstPresenter: PasswordRecoveryFirstPresenterInput {
    
//    func showCodeConfirm(model: SignUpUserModel, ) {
//        let vc = AuthCodeAssembler.createModule(model: model) {
//            completion()
//        }
//        navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    func signIn(completion: @escaping EmptyClosure) {
//        let vc = SignInAssembler.createModule {
//            completion()
//        }
//        navigationController?.pushViewController(vc, animated: true)
//    }
    
    func onComplete() {
        onFinishFlow?()
    }
    
    func showAlert(_ error: NetworkError) {
        let recoveryError = processError(error)
        let alert = UIAlertController(title: Strings.ResetPassword.error, message: recoveryError.text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view.onShowAlert(alert)
    }
    

    func resetPassword(_ email: String) {
        if email.isValidEmail {
            apiWorker.recoveryPassword(email) { [weak self] response in
                switch response {
                case .success(_):
                    self?.view.onResetPasswordSucess(completion: {
                        self?.onFinishFlow?()
                    })
                case .failure(let error):
                    self?.view.onResetPasswordFailure(error)
                }
            }
        } else {
            self.view.onResetPasswordSucess(completion: {
                self.onFinishFlow?()
            })
//            view.onResetPasswordFailure(.badRequest)
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
