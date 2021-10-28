//
//  AuthCodeAuthCodePresenterInput.swift
//  LikeTok
//
//  Created by Artem Holod on 26/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

protocol AuthCodePresenterInput: BasePresenting {
    func getNewCode()
    func codeReceived(code: String)
}
