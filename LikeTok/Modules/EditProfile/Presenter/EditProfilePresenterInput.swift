//
//  EditProfilePresenterInput.swift
//  LikeTok
//
//  Created by Daniel on 19.02.22.
//

import UIKit

protocol EditProfilePresenterInput: BasePresenting {
    func avatarDidTap()
    func uploadAvatar(image: UIImage)
    func showKeyboard(_ info: KeyboardObserver.KeyboardInfo)
    func hideKeyboard()
    func onDoneButtonTap(_ editedModel: EditProfileModel)
}
