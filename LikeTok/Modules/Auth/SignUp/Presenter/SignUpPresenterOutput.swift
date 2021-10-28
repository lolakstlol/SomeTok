//
//  SignUpSignUpPresenterOutput.swift
//  LikeTok
//
//  Created by Artem Holod on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

protocol SignUpPresenterOutput: AnyObject {
    func setupView()
    func showCodeConfirm(model: SignUpUserModel ,completion: @escaping EmptyClosure)
    func signIn(completion: @escaping EmptyClosure)
}
