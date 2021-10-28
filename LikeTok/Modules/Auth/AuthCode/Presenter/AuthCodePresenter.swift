//
//  AuthCodeAuthCodePresenter.swift
//  LikeTok
//
//  Created by Artem Holod on 26/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

final class AuthCodePresenter {
    private unowned let view: AuthCodePresenterOutput
    private var timer: BaseTimerInput?
    private let apiWorker = AuthApiWorker()
    private let signUpModel: SignUpUserModel
    var finishFlow: EmptyClosure? = nil

    init(_ view: AuthCodePresenterOutput,
         signUpModel: SignUpUserModel) {
        self.view = view
        self.signUpModel = signUpModel
        timer = BaseTimer(output: self)
    }

    func viewDidLoad() {
        view.setupView()
        setupTimer()
    }
    
    func setupTimer() {
        timer?.startTimer(counter: 60)
    }

    func setupTimer(timer: BaseTimerInput) {
        self.timer = timer
    }

}

extension AuthCodePresenter: BaseTimerOutput {
    func currentTimeValue(counter: Int) {
        var stringValue = String(counter)
        if counter < 10 {
            stringValue = "0\(counter)"
        }
        let text = "00:\(stringValue)"
        view.setTimerTitle(text: text)
    }
    
    func end() {
        let text = "00:00"
        view.setTimerTitle(text: text)
        view.enableResendButton(isEnebled: true)
    }
}

extension AuthCodePresenter: AuthCodePresenterInput {
    func codeReceived(code: String) {
        apiWorker.confirmMail(code: code, mail: signUpModel.email) { result in
            switch result {
            case .success(let response):
                if response?.result.status == true {
                    self.apiWorker.signIn(username: self.signUpModel.name, password: self.signUpModel.pass) { result in
                        switch result {
                        case .success(let response):
                            if let token = response?.data.token,
                               let userId = response?.data.uuid {
                                AccountManager.saveUserId(userId: userId)
                                AccountManager.saveAccount(token: token)
                                // open more data VC
                            } else {
                                // something went wrong
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            case .failure(let error):
                print("error code")
            }
        }
    }
    
    func getNewCode() {
        apiWorker.repeatCode(mail: signUpModel.email) { result in
            switch result {
            case .success(let response):
                if response?.result.status == true {
                    self.timer?.startTimer(counter: 60)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
