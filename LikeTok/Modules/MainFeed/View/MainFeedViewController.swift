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
        self.tabBarItem.title = Strings.Tabbar.feed
        self.tabBarItem.image = Assets.feedUnselected.image
        self.tabBarItem.selectedImage = Assets.feedSelected.image
        self.view.backgroundColor = .gray
        // https://www.theartnewspaper.ru/media/images/ac5b3fc4-5105-4e09-a3cf-c9a2e0cfb359.width-1290.jpg
        
    }

}

extension MainFeedViewController: MainFeedPresenterOutput {

}
