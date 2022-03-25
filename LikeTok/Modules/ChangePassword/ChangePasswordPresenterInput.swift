//
//  ChangePasswordPresenterInput.swift
//  LikeTok
//
//  Created by Daniel on 24.03.22.
//

import Foundation

protocol ChangePasswordPresenterInput: BasePresenting {
    func changePassword(oldPassword: String, newPassword: String)
    func showKeyboard(_ info: KeyboardObserver.KeyboardInfo)
    func hideKeyboard()
    func showAlert(_ error: Error)
}
