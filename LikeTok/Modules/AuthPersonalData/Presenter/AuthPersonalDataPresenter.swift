//
//  AuthPersonalDataAuthPersonalDataPresenter.swift
//  LikeTok
//
//  Created by Artem Holod on 31/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

final class AuthPersonalDataPresenter {
    private unowned let view: AuthPersonalDataPresenterOutput

    init(_ view: AuthPersonalDataPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
     
    }

}

extension AuthPersonalDataPresenter: AuthPersonalDataPresenterInput {

}
