//
//  TabBarTabBarViewController.swift
//  LikeTok
//
//  Created by Artem Holod on 01/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {
	var presenter: TabBarPresenterInput!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        presenter.attachInstanse(tabbar: self)
    }

}

extension TabBarViewController: TabBarPresenterOutput {
    func updateViews(vc: [UIViewController], selected: Int) {
        self.viewControllers = vc
        self.selectedIndex = selected
    }
}
