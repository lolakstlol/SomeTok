//
//  EditProfilePresenter.swift
//  LikeTok
//
//  Created by Daniel on 19.02.22.
//

import UIKit

final class EditProfilePresenter {
    
    private unowned let view: EditProfilePresenterOutput
    private var networkService: ProfileNetworkServiceProtocol
    private var model: EditProfileModel
    
    var onEditFinished: ((EditProfileModel) -> ())?
    
    private var isKeyboardAppears: Bool = false
    
    init(_ view: EditProfilePresenterOutput, _ networkService: ProfileNetworkServiceProtocol, _ model: EditProfileModel, _ completion: ((EditProfileModel) -> ())?) {
        self.view = view
        self.networkService = networkService
        self.model = model
        self.onEditFinished = completion
    }

    func viewDidLoad() {
        view.setupUI()
        view.setupUserData(model)
    }
    
    func viewWillAppear() {
        view.setupNavigationBar()
    }

}

private extension EditProfilePresenter {

    func checkedEditedModel(_ updatedModel: EditProfileModel) -> EditedProfileModel {
        let username = updatedModel.username != model.username ? updatedModel.username : nil
        let email = updatedModel.email != model.email ? updatedModel.email : nil
        let phone = updatedModel.phone != model.phone ? updatedModel.phone : nil
        
        return EditedProfileModel(name: updatedModel.name,
                                  username: username,
                                  email: email,
                                  phone: phone,
                                  country: updatedModel.country,
                                  city: updatedModel.city,
                                  description: updatedModel.description)
        
    }
}

extension EditProfilePresenter: EditProfilePresenterInput {
    func uploadAvatar(image: UIImage) {
        Api.upload(image.jpegData(compressionQuality: 0.3)!, with: "file", fileExtension: "jpg", to: "\(API.server)/user/photo/upload", self)
    }
    
    func avatarDidTap() {
        view.openPickerView()
    }
    
    func showKeyboard(_ info: KeyboardObserver.KeyboardInfo) {
        if !isKeyboardAppears {
            let kbSize = info.keyboardBounds
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
            isKeyboardAppears = true
            view.onShowKeyboard(insets)
        }
    }
    
    func hideKeyboard() {
        if isKeyboardAppears {
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            isKeyboardAppears = false
            view.onHideKeyboard(insets)
        }
    }
    
    
    func onDoneButtonTap(_ editedModel: EditProfileModel) {
        networkService.updateSettings(checkedEditedModel(editedModel)) { [weak self] result in
            switch result {
            case .success(_):
                self?.onEditFinished?(editedModel)
                self?.view.onUpdateSuccess()
            case .failure(let error):
                self?.view.onUpdateFailure(error)
            }
        }
    }

}

extension EditProfilePresenter: UploadCallback {
    
    func onSuccess(model: UploadResponse) {
        view.onUploadPhotoSuccess(model.data.preview)
    }
    
    func onFailure(_ error: Error) {
        view.onUploadPhotoFailure(error)
    }
}
