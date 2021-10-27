//
//  TabBarTabBarPresenterOutput.swift
//  LikeTok
//
//  Created by Danik on 26/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarPresenterOutput: AnyObject {
    func setViewControllers(_ items: [UIViewController], with startViewController: Int)
    func setViewController(index: Int)
    func getViewControllers() -> [UIViewController]
    func showTabBar(completion: (() -> ())?)
    func hideTabBar(completion: (() -> ())?)
}
