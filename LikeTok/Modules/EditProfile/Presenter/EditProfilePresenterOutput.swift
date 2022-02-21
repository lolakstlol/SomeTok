//
//  EditProfilePresenterOutput.swift
//  LikeTok
//
//  Created by Daniel on 19.02.22.
//

import UIKit

protocol EditProfilePresenterOutput: AnyObject {
    func setupUI()
    func setupUserData(_ model: EditProfileModel)
    func onShowKeyboard(_ insets: UIEdgeInsets)
    func onHideKeyboard(_ insets: UIEdgeInsets)
    func onUpdateSuccess()
    func onUpdateFailure(_ error: NetworkError)
    func onUploadPhotoSuccess(_ preview: String)
    func onUploadPhotoFailure(_ error: Error)
    func openPickerView()
}
