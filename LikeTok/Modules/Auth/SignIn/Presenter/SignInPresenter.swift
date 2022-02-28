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
    let apiWorker = AuthApiWorker()
    var finishFlow: EmptyClosure? = nil
    
    init(_ view: SignInPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
        view.setupView()
    }

}

extension SignInPresenter: SignInPresenterInput {
    
    func onPasswordRecoveryTap() {
        view.showPasswordRecovery()
    }
    
    func loginDidTap(email: String, pass: String) {
        apiWorker.signIn(username: email, password: pass) { [weak self] result in
            switch result {
            case .success(let response):
                if let token = response?.data.token,
                   let userId = response?.data.uuid {
                    AccountManager.saveUserId(userId: userId)
                    AccountManager.saveAccount(token: token)
                    self?.finishFlow?()
                } else {
                    self?.view.onSignInFailed(NetworkError.noData.localizedDescription)
                    // something went wrong
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self?.view.onSignInFailed("Ошибка авторизации, пожалуйста проверьте введенные данные.")
            }
        }
    }
    

}
