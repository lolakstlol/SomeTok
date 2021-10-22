//
//  ResetPasswordResetPasswordPresenter.swift
//  LikeTok
//
//  Created by Danik on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

final class ResetPasswordPresenter {
    private unowned let view: ResetPasswordPresenterOutput

    init(_ view: ResetPasswordPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
     
    }

}

extension ResetPasswordPresenter: ResetPasswordPresenterInput {

    func resetPassword(_ email: String) {
        
    }
    
}
