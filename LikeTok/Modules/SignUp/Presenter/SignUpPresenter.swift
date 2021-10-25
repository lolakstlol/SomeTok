//
//  SignUpSignUpPresenter.swift
//  LikeTok
//
//  Created by Artem Holod on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

final class SignUpPresenter {
    private unowned let view: SignUpPresenterOutput

    init(_ view: SignUpPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
     
    }

}

extension SignUpPresenter: SignUpPresenterInput {

}
