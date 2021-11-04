//
//  TabBarTabBarPresenterOutput.swift
//  LikeTok
//
//  Created by Artem Holod on 01/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarPresenterOutput: AnyObject {
    func updateViews(vc: [UIViewController], selected: Int)
    func updateAppearance(appearance: TabBarAppearance)
}
