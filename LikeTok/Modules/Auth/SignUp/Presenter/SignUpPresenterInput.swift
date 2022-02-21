//
//  SignUpSignUpPresenterInput.swift
//  LikeTok
//
//  Created by Artem Holod on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

protocol SignUpPresenterInput: BasePresenting {
    func showKeyboard(_ info: KeyboardObserver.KeyboardInfo)
    func hideKeyboard()
    func signUP(email: String, name: String, pass: String)
    func loginDidTap()
}
