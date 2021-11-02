//
//  AuthCodeAuthCodePresenterOutput.swift
//  LikeTok
//
//  Created by Artem Holod on 26/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

protocol AuthCodePresenterOutput: AnyObject {
    func setupView()
    func setTimerTitle(text: String)
    func enableResendButton(isEnebled: Bool)
    func showPersonalData(completion: @escaping EmptyClosure)
}
