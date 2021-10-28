//
//  BaseTimerOutput.swift
//  magnit-ios
//
//  Created by Артем Холодок on 11.09.2020.
//  Copyright © 2020 BSL.dev. All rights reserved.
//

import Foundation

protocol BaseTimerOutput: AnyObject {
    func currentTimeValue(counter: Int)
    func end()
}
