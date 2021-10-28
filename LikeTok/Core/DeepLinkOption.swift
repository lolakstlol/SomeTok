import Foundation

enum DeepLinkOption {
    case navigateToTracking(courierCode: String, trackingNumber: String)
    case updateTracking(courierCode: String, trackingNumber: String)
    case widgetTracking(courierCode: String, trackingNumber: String)
    case localPush(identifier: String)
    case addPackage
    case widgetGetPremium
    case widgetDefault
    
    static func buildNavigateLink(with pushPayload: [AnyHashable: Any]?) -> DeepLinkOption? {
        let courierCodeKey = "slug"
        let trackingNumberKey = "trackNumber"
        
        guard let courierCode = pushPayload?[courierCodeKey] as? String,
              let trackingNumber = pushPayload?[trackingNumberKey] as? String else {
            return nil
        }

        return .navigateToTracking(courierCode: courierCode, trackingNumber: trackingNumber)
    }

    static func buildUpdateLink(with pushPayload: [AnyHashable: Any]?) -> DeepLinkOption? {
        let courierCodeKey = "slug"
        let trackingNumberKey = "trackNumber"
        
        guard let courierCode = pushPayload?[courierCodeKey] as? String,
              let trackingNumber = pushPayload?[trackingNumberKey] as? String else {
            return nil
        }

        return .updateTracking(courierCode: courierCode, trackingNumber: trackingNumber)
    }
    
    static func build(with localPushIdentifier: String?) -> DeepLinkOption? {
        guard let identifier = localPushIdentifier else {
            return nil
        }
        return .localPush(identifier: identifier)
    }
    
    static func build(with url: URL) -> DeepLinkOption? {
        let string = url.absoluteString
        if string == "pt://package-tracker.com/addPackage" {
            return .addPackage
        }
        if string == "pt://package-tracker.com/getPremium" {
            return .widgetGetPremium
        }
        if string == "pt://package-tracker.com/default" {
            return .widgetDefault
        }
        var dict: [String: String] = [:]
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        if let queryItems = components.queryItems {
            for item in queryItems {
                dict[item.name] = item.value!
            }
        }
        let courierCodeKey = "slug"
        let trackingNumberKey = "trackNumber"
        
        guard let courierCode = dict[courierCodeKey],
              let trackingNumber = dict[trackingNumberKey] else {
            return nil
        }

        return .widgetTracking(courierCode: courierCode, trackingNumber: trackingNumber)
    }
}
