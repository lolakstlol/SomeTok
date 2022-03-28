//
//  SceneDelegate.swift
//  LikeTok
//
//  Created by Artem Holod on 18.10.21.
//

import UIKit
import AVKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private var applicationCoordinator: Coordinator?
    
    private var deepLinkService = DeepLinkService.shared
    
    private var navigationController: UINavigationController?

    
    override init() {
        super.init()
        subscribeNotifications()
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        initializeRootView(windowScene: windowScene)
        applicationCoordinator = makeCoordinator(window: window)
        deepLinkService.coordinator = applicationCoordinator
        applicationCoordinator?.start()
        setupAVSession()
//        
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        let window = UIWindow(windowScene: windowScene)
//        let vc = FeedViewAssembler.createModule(type: .main, feedService: FeedService(), collectionManager: FeedCollectionManager())
//        let navigation = UINavigationController(rootViewController: vc)
//        window.rootViewController = navigation
//        self.window = window
//        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

private extension SceneDelegate {
    
    func initializeRootView(windowScene: UIWindowScene) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
    }
    
    func makeCoordinator(window: UIWindow?) -> Coordinator {
        let coordinatorFactory = CoordinatorFactory()
        let router = MainRouter(window: window)
        return ApplicationCoordinator(coordinatorFactory: coordinatorFactory, router: router)
    }
    
    private func subscribeNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(forceLogOut), name: .userLoggedOut, object: nil)
    }
    
    private func setupAVSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
         } catch {
             debugPrint(error.localizedDescription)
         }
    }
    
    @objc private func forceLogOut() {
        AccountManager.logout()
        applicationCoordinator = makeCoordinator(window: window)
        deepLinkService.coordinator = applicationCoordinator
        applicationCoordinator?.start()
    }
}
