//
//  ResetPasswordNewPasswordResetPasswordNewPasswordPresenterInput.swift
//  LikeTok
//
//  Created by Danik on 24/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

protocol ResetPasswordNewPasswordPresenterInput: BasePresenting {
    func showAlert()
    func resetPassword(_ password: String)
    func showKeyboard(_ info: KeyboardObserver.KeyboardInfo)
    func hideKeyboard()
}
