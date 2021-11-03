//
//  ResetPasswordResetPasswordPresenterInput.swift
//  LikeTok
//
//  Created by Danik on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

protocol PasswordRecoveryFirstPresenterInput: BasePresenting {
    func showKeyboard(_ info: KeyboardObserver.KeyboardInfo)
    func hideKeyboard()
    func showAlert(_ error: Error)
    func resetPassword(_ email: String)
}
