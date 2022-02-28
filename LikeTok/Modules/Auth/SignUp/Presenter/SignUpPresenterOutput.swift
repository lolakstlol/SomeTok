//
//  SignUpSignUpPresenterOutput.swift
//  LikeTok
//
//  Created by Artem Holod on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

protocol SignUpPresenterOutput: AnyObject {
    func setupView()
    func onShowKeyboard(_ insets: UIEdgeInsets)
    func onHideKeyboard(_ insets: UIEdgeInsets)
    func showCodeConfirm(model: SignUpUserModel ,completion: @escaping EmptyClosure)
    func signIn(completion: @escaping EmptyClosure)
    func onSignInFailure(_ error: String)
}
