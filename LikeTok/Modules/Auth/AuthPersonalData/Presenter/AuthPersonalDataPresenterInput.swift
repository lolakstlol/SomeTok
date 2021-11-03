//
//  AuthPersonalDataAuthPersonalDataPresenterInput.swift
//  LikeTok
//
//  Created by Artem Holod on 31/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

protocol AuthPersonalDataPresenterInput: BasePresenting {
    func avatarDidTap()
    func continueButtonDidTap(name: String?, phone: String?)
    func uploadAvatar(image: UIImage) 
}
