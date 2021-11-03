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
    let apiWorker = AuthApiWorker()
    var finishFlow: EmptyClosure? = nil
    
    init(_ view: SignUpPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
        view.setupView()
    }

}

extension SignUpPresenter: SignUpPresenterInput {
    
    func loginDidTap() {
        view.signIn {
            self.finishFlow?()
        }
    }
    
    func signUP(email: String, name: String, pass: String) {
        apiWorker.signUP(username: name, mail: email, password: pass) { [weak self] result in
            switch result {
            case .success(let response):
                if response?.result.status == true {
                    self?.view.showCodeConfirm(model: SignUpUserModel(email: email,
                                                                      pass: pass,
                                                                      name: name)) {
                        self?.finishFlow?()
                    }
                } else {
                    // handle
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    

}
