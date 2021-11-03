//
//  MainFeedMainFeedViewController.swift
//  LikeTok
//
//  Created by Artem Holod on 01/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class MainFeedViewController: BaseViewController {
	var presenter: MainFeedPresenterInput!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        self.tabBarItem.title = "Главная"
        self.tabBarItem.image = Assets.password.image
    }

}

extension MainFeedViewController: MainFeedPresenterOutput {

}
