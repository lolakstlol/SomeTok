//
//  BaseViewControllerInput.swift
//  magnit-ios
//
//  Created by Max Lahmakov on 10/16/20.
//  Copyright © 2020 BSL.dev. All rights reserved.
//

import Foundation

protocol BaseViewControllerInput: AnyObject {
    func showLoader()
    func hideLoader()
}
