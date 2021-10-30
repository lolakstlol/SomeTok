////
////  ResetPasswordCoordinator.swift
////  LikeTok
////
////  Created by Daniil Stelchenko on 29.10.21.
////
//
//import Foundation
//import UIKit
//
//class PasswordRecoveryCoordinator: BaseCoordinator {
//    
//    // MARK: - Public properties
//    
//    var finishFlow: EmptyClosure?
//    
//    // MARK: - Private properties
//    
//    private let router: Router
//    
//    private let settings: ApplicationSettings
//    
//    // MARK: - Initialization
//    
//    init(router: Router,
//         settings: ApplicationSettings = ApplicationSettings.shared) {
//        self.router = router
//        self.settings = settings
//    }
//    
//    // MARK: - BaseCoordinator
//    
//    override func start() {
//        super.start()
//        showPasswordRecovery()
//    }
//}
//
//extension PasswordRecoveryCoordinator {
//    
//    func showPasswordRecovery() {
//        let vc = PasswordRecoveryFirstAssembler.createModule { [weak self] in
//            let vc = PasswordRecoverySecondAssembler.createModule {
//                self?.finishFlow?()
//            }
//            let nav = UINavigationController(rootViewController: vc)
//            self?.router.setRootModule(nav, windowBackgroundColor: .white)
//        }
//        router.setRootModule(vc, windowBackgroundColor: .white)
//    }
//    
//}
