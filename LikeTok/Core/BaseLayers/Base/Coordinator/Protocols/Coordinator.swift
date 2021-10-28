import Foundation

protocol Coordinator: AnyObject {
        
    // notify coordinator that it can start
    func start()
    
    /// Notifies coordinator that it should start with deeplink option
    /// - Parameter deepLinkOption: deep link option such as Push Notification
    func start(with deepLinkOption: DeepLinkOption?)
    
    // Notify coordinator that it should remove all child coordinators
    func removeAllChilds()
}
