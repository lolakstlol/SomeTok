//
//  FeedFeedViewController.swift
//  LikeTok
//
//  Created by Danik on 06/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class FeedViewController: BaseViewController {
	var presenter: FeedPresenterInput!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

}

extension FeedViewController: FeedPresenterOutput {

}
