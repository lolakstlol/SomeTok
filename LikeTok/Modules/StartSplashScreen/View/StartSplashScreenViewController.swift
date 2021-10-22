//
//  StartSplashScreenStartSplashScreenViewController.swift
//  LikeTok
//
//  Created by Artem Holod on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class StartSplashScreenViewController: BaseViewController {
	var presenter: StartSplashScreenPresenterInput!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

}

extension StartSplashScreenViewController: StartSplashScreenPresenterOutput {

}
