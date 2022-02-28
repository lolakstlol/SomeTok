import Foundation
import UIKit

final class AuthPersonalDataPresenter {
    
    private let apiWorker = AuthApiWorker()
    private unowned let view: AuthPersonalDataPresenterOutput
    var finishFlow: EmptyClosure?

    init(_ view: AuthPersonalDataPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
        view.setupView()
    }

}

extension AuthPersonalDataPresenter: UploadCallback {
    func onSuccess(model: UploadResponse) {
        print(model)
    }
    
    func onFailure(_ error: Error) {
        view.onUploadFailure(error)
    }
}

extension AuthPersonalDataPresenter: AuthPersonalDataPresenterInput {
    func uploadAvatar(image: UIImage) {
        Api.upload(image.jpegData(compressionQuality: 0.3)!, with: "file", fileExtension: "jpg", to: "\(API.server)/user/photo/upload", self)
    }
    
    func avatarDidTap() {
        view.openPickerView()
    }
    
    func continueButtonDidTap(name: String?, phone: String?) {
        apiWorker.updateSettings(name: name, phone: phone) { result in
            switch result {
            case .success(_):
                self.finishFlow?()
            case .failure(_):
                print("error")
            }
        }
    }
}
