//
//  ResetPasswordResetPasswordPresenterInput.swift
//  LikeTok
//
//  Created by Danik on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

protocol ResetPasswordEmailPresenterInput: BasePresenting {
    func showKeyboard(_ info: KeyboardObserver.KeyboardInfo)
    func hideKeyboard()
    func showAlert()
    func resetPassword(_ email: String)

}
