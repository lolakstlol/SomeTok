//
//  SignInSignInPresenterInput.swift
//  LikeTok
//
//  Created by Artem Holod on 27/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

protocol SignInPresenterInput: BasePresenting {
    func loginDidTap(email: String, pass: String)
}
