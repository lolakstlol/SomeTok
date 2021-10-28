import Foundation

class DeepLinkService {
    public static let shared = DeepLinkService()
    
    private var deepLinkOption: DeepLinkOption?
    
    var coordinator: Coordinator?
    
    func handleRemoteNotification(_ pushPayload: [AnyHashable: Any]?) {
        deepLinkOption = DeepLinkOption.buildNavigateLink(with: pushPayload)
    }

    func handleRemoteNotificationInForeground(_ pushPayload: [AnyHashable: Any]?) {
        deepLinkOption = DeepLinkOption.buildUpdateLink(with: pushPayload)
    }
    
    func handleLocalNotification(_ identifier: String?) {
        deepLinkOption = DeepLinkOption.build(with: identifier)
    }
    
    func handleWidgetTap(_ url: URL) {
        deepLinkOption = DeepLinkOption.build(with: url)
    }
    
    func checkDeepLink() {
        guard let deepLinkOption = deepLinkOption else {
            return
        }
        
        guard let coordinator = coordinator else {
            print("\(#function): coordinator is empty")
            return
        }
        
        coordinator.start(with: deepLinkOption)
        
        // reset deeplink option after handling
        self.deepLinkOption = nil
    }
}
