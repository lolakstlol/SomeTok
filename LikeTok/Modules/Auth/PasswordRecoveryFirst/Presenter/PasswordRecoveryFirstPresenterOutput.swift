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
    typealias T = Error
    
    func onViewDidLoad()
    func onViewWillAppear()
    func onResetPasswordSucess(_ userEmail: String)
    func onResetPasswordFailure(_ error: T)
    func onShowAlert(_ alert: UIAlertController)
    func onShowKeyboard(_ insets: UIEdgeInsets)
    func onHideKeyboard(_ insets: UIEdgeInsets)
}
