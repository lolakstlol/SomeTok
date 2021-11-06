////
////  FeedViewFeedViewRouter.swift
////  marketplace
////
////  Created by Mikhail Lutskii on 20/11/2020.
////  Copyright © 2020 BSL. All rights reserved.
////
//
//import UIKit.UIViewController
//import FloatingPanel
//
//final class FeedViewRouter: BaseRouter {
//    private var fpc: FloatingPanelController!
//    
//    @objc private func closeFloatingPanel() {
//        fpc.dismiss(animated: true)
//    }
//}
//
//// MARK: - Panel setup
//
//extension FeedViewRouter {
//    private func appUpdateOfferPanelSetup(_ controller: AppUpdateOfferViewController) -> FloatingPanelController {
//        fpc = FloatingPanelController()
//        fpc.delegate = controller
//        fpc.layout = AppUpdateOfferPanelLayout()
//        fpc.isRemovalInteractionEnabled = true
//        fpc.surfaceView.grabberHandle.isHidden = false
//        fpc.surfaceView.grabberHandleSize = CGSize(width: 41, height: 3)
//        fpc.surfaceView.grabberHandle.backgroundColor = Asset.Colors.PurchasesCheckout.grabberHandle.color
//        fpc.surfaceView.appearance.cornerRadius = 20
//        
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(closeFloatingPanel))
//        fpc.backdropView.isUserInteractionEnabled = true
//        fpc.backdropView.addGestureRecognizer(recognizer)
//        return fpc
//    }
//    
//    private func commentsPanelSetup(_ controller: CommentsViewController) -> FloatingPanelController {
//        fpc = FloatingPanelController()
//        fpc.delegate = controller
//        fpc.layout = CommentsPanelLayout()
//        fpc.isRemovalInteractionEnabled = true
//        fpc.surfaceView.grabberHandle.isHidden = true
//        fpc.surfaceView.appearance.cornerRadius = 20
//        
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(closeFloatingPanel))
//        fpc.backdropView.isUserInteractionEnabled = true
//        fpc.backdropView.addGestureRecognizer(recognizer)
//        return fpc
//    }
//    
//    private func basketPanelSetup(_ controller: PurchasesCheckoutViewController) -> FloatingPanelController {
//        fpc = FloatingPanelController()
//        fpc.delegate = controller
//        fpc.layout = PurchasesCheckoutPanelLayout()
//        fpc.isRemovalInteractionEnabled = true
//        fpc.surfaceView.grabberHandle.isHidden = false
//        fpc.surfaceView.grabberHandleSize = CGSize(width: 41, height: 3)
//        fpc.surfaceView.grabberHandle.backgroundColor = Asset.Colors.PurchasesCheckout.grabberHandle.color
//        fpc.surfaceView.appearance.cornerRadius = 20
//        
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(closeFloatingPanel))
//        fpc.backdropView.isUserInteractionEnabled = true
//        fpc.backdropView.addGestureRecognizer(recognizer)
//        return fpc
//    }
//    
//    private func floatingMenuPanelSetup(_ controller: FloatingMenuViewController) -> FloatingPanelController {
//        fpc = FloatingPanelController()
//        fpc.delegate = controller
//        fpc.layout = FloatingMenuPanelLayout()
//        fpc.isRemovalInteractionEnabled = true
//        fpc.surfaceView.grabberHandle.isHidden = true
//        fpc.surfaceView.appearance.cornerRadius = 20
//        
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(closeFloatingPanel))
//        fpc.backdropView.isUserInteractionEnabled = true
//        fpc.backdropView.addGestureRecognizer(recognizer)
//        return fpc
//    }
//}
//
//// MARK: - FeedViewRouting
//
//extension FeedViewRouter: FeedViewRouting {
//    func presentAppUpdateOfferScreen() {
//        let appUpdateOffer = AppUpdateOfferAssembler.createModule { [weak self] in
//            self?.fpc = nil
//            self?.dismiss()
//        }
//        fpc = appUpdateOfferPanelSetup(appUpdateOffer)
//        fpc.set(contentViewController: appUpdateOffer)
//        viewController.present(fpc, animated: true)
//    }
//    
//    func presentBussniesUserProfile(profileId: String) {
//        guard let tabBar = viewController.tabBarController as? TabBarViewController else { return }
//        tabBar.hideTabBar {
//            let BPController = BusinessProfilePageAssembler.createModule(for: profileId)
//            self.viewController.navigationController?.pushViewController(BPController, animated: true)
//        }
//    }
//    
//    func presentPurchasesCheckoutScreen() {
//        let contentVC = PurchasesCheckoutAssembler.createModule(type: .mainCheckout) { [weak self] in
//            self?.fpc = nil
//            self?.dismiss()
//        } _: { _, _ in }
//        
//        fpc = basketPanelSetup(contentVC)
//        fpc.set(contentViewController: contentVC)
//        viewController.present(fpc, animated: true)
//        guard let tableView = contentVC.purchasesBasket?.tableView else { return }
//        fpc.track(scrollView: tableView)
//    }
//    
//    func presentShareModule(_ image: UIImage) {
//        let controller = UIActivityViewController(activityItems: [image, Constants.General.appStoreUrl],
//                                                  applicationActivities: nil)
//        controller.excludedActivityTypes = [
//            UIActivity.ActivityType(rawValue: "com.apple.mobilenotes.SharingExtension"),
//            .print,
//            .assignToContact,
//            .copyToPasteboard,
//            .addToReadingList,
//            .postToFacebook,
//            .postToTwitter,
//            .airDrop,
//            .message
//        ]
//        present(newVC: controller, animated: true)
//    }
//    
//    func presentLocationModule() {
//        let okAction = UIAlertAction(title: L10n.BaseRouting.alertYes, style: .default) { _ in
//            let locationModule = ChooseLocationAssembler.createModule(locationService: SceneDelegate.locationService, completion: {})
//            self.viewController.presentFullScreen(locationModule)
//        }
//        let cancelAction = UIAlertAction(title: L10n.BaseRouting.alertNo, style: .cancel)
//        showAlert(message: L10n.FeedView.askToChangeLocation, actions: [okAction, cancelAction])
//    }
//    
//    func presentDeleteModule(postId: String?, userId: String?, completion: @escaping VoidHandler) {
//        guard let postId = postId else { return }
//        let deleteModule = FloatingMenuAssembler.createModule(.deletePost(postId: postId, userId: userId)) { [weak self] in
//            self?.fpc = nil
//            completion()
//        }
//        fpc = floatingMenuPanelSetup(deleteModule)
//        fpc.set(contentViewController: deleteModule)
//        viewController.present(fpc, animated: true)
//    }
//
//    func presentAuthModule(completion: @escaping VoidHandler) {
//        let authVC = AuthorizationAssembler.createModule {
//            completion()
//        }
//        viewController.present(authVC, animated: true)
//    }
//    
//    func openComments(postId: String, userId: String) {
//        let contentVC = CommentsAssembler.createModule(postId: postId, userId: userId, closeAction: { [weak self] commentsCount in
//            if let count = commentsCount {
//                (self?.viewController as? FeedViewViewController)?.presenter.setCommentsCount(with: count)
//            }
//            self?.fpc = nil
//            self?.dismiss()
//        })
//        fpc = commentsPanelSetup(contentVC)
//        fpc.set(contentViewController: contentVC)
//        fpc.track(scrollView: contentVC.tableView)
//        
//        viewController.present(fpc, animated: true, completion: nil)
//    }
//    
//    func presentUserProfile(userId: String) {
//        let profileVC = ProfileAssembler.createModule(.someoneProfile(userId))
//        viewController.navigationController?.pushViewController(profileVC, animated: true)
//    }
//}
//
//// MARK: - FloatingPanelControllerDelegate
//
//extension CommentsViewController: FloatingPanelControllerDelegate {
//    func floatingPanel(_ fpc: FloatingPanelController, layoutFor size: CGSize) -> FloatingPanelLayout {
//        return CommentsPanelLayout()
//    }
//    
//    func floatingPanel(_ fpc: FloatingPanelController, shouldRemoveAt location: CGPoint, with velocity: CGVector) -> Bool {
//        switch fpc.layout.position {
//        case .bottom:
//            return velocity.dy >= Constants.FloatingPanel.floatingPanelVelocity
//        default:
//            return true
//        }
//    }
//}
//
//// MARK: - FloatingPanelControllerDelegate
//
//extension FloatingMenuViewController: FloatingPanelControllerDelegate {
//    func floatingPanel(_ fpc: FloatingPanelController, layoutFor size: CGSize) -> FloatingPanelLayout {
//        return FloatingMenuPanelLayout()
//    }
//    
//    func floatingPanel(_ fpc: FloatingPanelController, shouldRemoveAt location: CGPoint, with velocity: CGVector) -> Bool {
//        switch fpc.layout.position {
//        case .bottom:
//            return velocity.dy >= Constants.FloatingPanel.floatingPanelVelocity
//        default:
//            return true
//        }
//    }
//}
//
//// MARK: - FloatingPanelControllerDelegate
//
//extension AppUpdateOfferViewController: FloatingPanelControllerDelegate {
//    func floatingPanel(_ fpc: FloatingPanelController, layoutFor size: CGSize) -> FloatingPanelLayout {
//        return AppUpdateOfferPanelLayout()
//    }
//}
