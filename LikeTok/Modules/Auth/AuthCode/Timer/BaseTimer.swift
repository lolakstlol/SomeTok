//
//  TimerManager.swift
//  magnit-ios
//
//  Created by Артем Холодок on 11.09.2020.
//  Copyright © 2020 BSL.dev. All rights reserved.
//

import Foundation

class BaseTimer: BaseTimerInput {
    private weak var output: BaseTimerOutput?
    private weak var timer: Timer?
    private var counter: Int = 0
    private var step: Int = 1
    init(output: BaseTimerOutput) {
        self.output = output
    }
    
    func startTimer(counter: Int, _ repeats: Bool = true, _ step: Int = 1, _ userInfo: [String: AnyObject] = [:]) {
        self.counter = counter
        self.step = step
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: userInfo, repeats: repeats)
    }
    
    @objc private func fireTimer() {
        counter -= step
        if counter > 0 {
            output?.currentTimeValue(counter: counter)
        } else {
            output?.end()
            timer?.invalidate()
        }
    }
}
