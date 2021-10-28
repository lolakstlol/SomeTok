//
//  BaseTimerInput.swift
//  magnit-ios
//
//  Created by Артем Холодок on 11.09.2020.
//  Copyright © 2020 BSL.dev. All rights reserved.
//

import Foundation

protocol BaseTimerInput: AnyObject {
    func startTimer(counter: Int, _ repeats: Bool, _ step: Int, _ userInfo: [String: AnyObject])
}

extension BaseTimerInput {
    func startTimer(counter: Int, _ repeats: Bool = true, _ step: Int = 1, _ userInfo: [String: AnyObject] = [:]) {
        startTimer(counter: counter, repeats, step, userInfo)
    }
}
