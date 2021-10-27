//
//  TabBarTabBarPresenter.swift
//  LikeTok
//
//  Created by Danik on 26/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation
import UIKit

final class TabBarPresenter {
    
    private unowned let view: TabBarPresenterOutput
    private var selectedViewController: UIViewController?

    init(_ view: TabBarPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
     
    }

}

extension TabBarPresenter: TabBarPresenterInput {
    
    func attachInstanse(tabbar: CustomTabBarView) {
        tabbar.delegate = self
    }
    
}

extension TabBarPresenter: CustomTabBarDelegate {
    func cardTabBar(_ sender: CustomTabBarView, didSelectItemAt index: Int, previousItemAt previousIndex: Int) {
//        detectTaps(sender)
        selectedViewController = view.getViewControllers()[index]
        switch index {
        case 2:
            view.hideTabBar(completion: nil)
        default:
            view.showTabBar(completion: nil)
        }
//        interactor.itemWasSelected(with: previousIndex)
        view.setViewController(index: index)
    }
    
    func shouldSelect(_ sender: CustomTabBarView, shouldSelectItemAt index: Int) -> Bool {
//        if index == 1 {
////            NotificationCenter.default.post(name: .shouldUpdateBusinessesList, object: nil)
//        }
//
//        if !interactor.isAuthorized() {
//            if index == 0 || index == 1 {
//                return true
//            }
//            router.showAuthScreen { [weak self] in
//                if index == 2, UserInfoService.shared.userInfo?.profileType == Constants.Profile.client {
//                    self?.router.showSoonInPerimetrPlugScreen()
//                    return
//                } else {
//                    self?.view.setViewController(index: index)
//                }
//            }
//            return false
//        } else {
//            if index == 2, UserInfoService.shared.userInfo?.profileType == Constants.Profile.client {
//                router.showSoonInPerimetrPlugScreen()
//                return false
//            }
//            return true
//        }
        return false
    }
}
