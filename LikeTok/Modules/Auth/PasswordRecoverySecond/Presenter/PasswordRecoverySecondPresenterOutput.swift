//
//  ResetPasswordNewPasswordResetPasswordNewPasswordPresenterOutput.swift
//  LikeTok
//
//  Created by Danik on 24/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation
import UIKit

protocol PasswordRecoverySecondPresenterOutput: AnyObject {
    func onViewDidLoad()
    func onViewWillAppear()
    func onResetPasswordSucess()
    func onResetPasswordFailure()
    func onShowAlert(_ alert: UIAlertController)
    func onShowKeyboard(_ insets: UIEdgeInsets)
    func onHideKeyboard(_ insets: UIEdgeInsets)
}
