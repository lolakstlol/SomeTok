//
//  ResetPasswordResetPasswordPresenter.swift
//  LikeTok
//
//  Created by Danik on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

final class ResetPasswordEmailPresenter {
    private unowned let view: ResetPasswordEmailPresenterOutput

    init(_ view: ResetPasswordEmailPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
     
    }

}

extension ResetPasswordEmailPresenter: ResetPasswordEmailPresenterInput {

    func resetPassword(_ email: String) {
        
    }
    
}
