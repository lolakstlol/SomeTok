//
//  SignInSignInPresenter.swift
//  LikeTok
//
//  Created by Artem Holod on 27/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

final class SignInPresenter {
    private unowned let view: SignInPresenterOutput

    init(_ view: SignInPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
        view.setupView()
    }

}

extension SignInPresenter: SignInPresenterInput {

}
