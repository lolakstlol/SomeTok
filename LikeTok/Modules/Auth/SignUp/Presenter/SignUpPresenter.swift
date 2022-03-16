//
//  SignUpSignUpPresenter.swift
//  LikeTok
//
//  Created by Artem Holod on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class SignUpPresenter {
    
    private unowned let view: SignUpPresenterOutput
    private var isKeyboardAppears: Bool = false

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
    func showKeyboard(_ info: KeyboardObserver.KeyboardInfo) {
        if !isKeyboardAppears {
            let kbSize = info.keyboardBounds
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
            isKeyboardAppears = true
            view.onShowKeyboard(insets)
        }
    }
    
    func hideKeyboard() {
        if isKeyboardAppears {
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            isKeyboardAppears = false
            view.onHideKeyboard(insets)
        }
    }
    
    
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
                debugPrint(error.localizedDescription)
//                self?.view.onSignInFailure("Пользователь с таким логином уже существует. Попробуйте использовать другой.")
            }
        }
    }
    

}
