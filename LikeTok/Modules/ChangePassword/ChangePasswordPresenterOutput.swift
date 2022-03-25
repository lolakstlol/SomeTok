//
//  ChangePasswordPresenterOutput.swift
//  LikeTok
//
//  Created by Daniel on 24.03.22.
//

import Foundation
import UIKit

protocol ChangePasswordPresenterOutput: AnyObject {
    typealias T = Error
    
    func onViewDidLoad()
    func onViewWillAppear()
    func onResetPasswordSucess()
    func onResetPasswordFailure(_ error: T)
    func onShowAlert(_ alert: UIAlertController)
    func onShowKeyboard(_ insets: UIEdgeInsets)
    func onHideKeyboard(_ insets: UIEdgeInsets)
}
