import UIKit

protocol CreatePrivatePostPresenterOutput: AnyObject {
    func setupPreview(preview: Data)
    func onShowKeyboard(_ insets: UIEdgeInsets)
    func onHideKeyboard(_ insets: UIEdgeInsets)
    func setupView()
    func didPublishPost()
}
