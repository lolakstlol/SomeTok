import StoreKit

enum AppReviewFlow {
    case viewThreeQuotes
    case firstLikeQuote
    case settingsReviewRequest
}

final class AppReviewService {
    
    static let shared = AppReviewService()
    
    var settings: SettingsProtocol
    
    init(settings: SettingsProtocol = ApplicationSettings.shared) {
        self.settings = settings
    }
    
    private func showRequest() {
        if settings.lastReviewVersion == Bundle.main.fullVersion {
            return
        }
        settings.lastReviewVersion = Bundle.main.fullVersion
        if #available(iOS 14.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        }
    }
    
    private func showAppReview() {
        guard let rateUrl = URL.init(string:
          "https://itunes.apple.com/us/app/id1558870609?action=write-review") else {
            return
        }
        if UIApplication.shared.canOpenURL(rateUrl) {
            UIApplication.shared.open(rateUrl, options: [:], completionHandler: nil)
        }
    }
    
    func requestReview(from flow: AppReviewFlow, delay: Double = 0) {
       showRequest()
    }
}
