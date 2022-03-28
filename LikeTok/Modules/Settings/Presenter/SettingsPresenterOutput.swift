//
//  SettingsPresenterOutput.swift
//  LikeTok
//
//  Created by Daniel on 23.03.22.
//

import Foundation
import UIKit

protocol SettingsPresenterOutput: AnyObject {
    func setupUI(_ dataSourse: [(String, action: () -> ())])
    func showConfrimationScreen(_ view: ConfrimationViewController)
    func showPasswordRecovery(_ view: UIViewController)
}
