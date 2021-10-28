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

    init(_ view: AuthCodePresenterOutput) {
        self.view = view
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
        // HANDLE CODE
    }
    
    func getNewCode() {
        timer?.startTimer(counter: 60)
        // SEND NEW CODE
    }
}
