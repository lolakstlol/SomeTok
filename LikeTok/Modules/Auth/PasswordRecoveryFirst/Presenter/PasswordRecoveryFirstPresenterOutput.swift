//
//  ResetPasswordResetPasswordPresenterOutput.swift
//  LikeTok
//
//  Created by Danik on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation
import UIKit

protocol PasswordRecoveryFirstPresenterOutput: AnyObject {
    func onViewDidLoad()
    func onResetPasswordSucess(completion: @escaping EmptyClosure)
    func onResetPasswordFailure(_ error: NetworkError)
    func onShowAlert(_ alert: UIAlertController)
    func onShowKeyboard(_ insets: UIEdgeInsets)
    func onHideKeyboard(_ insets: UIEdgeInsets)
}
