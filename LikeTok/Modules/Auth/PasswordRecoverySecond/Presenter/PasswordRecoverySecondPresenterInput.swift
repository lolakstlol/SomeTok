//
//  ResetPasswordNewPasswordResetPasswordNewPasswordPresenterInput.swift
//  LikeTok
//
//  Created by Danik on 24/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

protocol PasswordRecoverySecondPresenterInput: BasePresenting {
    func resetPassword(_ password: String, code: String)
    func showKeyboard(_ info: KeyboardObserver.KeyboardInfo)
    func showAlert(_ error: Error)
    func hideKeyboard()
}
