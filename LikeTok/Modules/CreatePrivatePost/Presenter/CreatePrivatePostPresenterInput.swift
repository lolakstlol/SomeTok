import Foundation

protocol CreatePrivatePostPresenterInput: BasePresenting {
    func uploadVideo(with description: String)
    func showKeyboard(_ info: KeyboardObserver.KeyboardInfo)
    func hideKeyboard()
}
