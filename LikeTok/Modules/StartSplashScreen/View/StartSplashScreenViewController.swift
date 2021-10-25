//
//  StartSplashScreenStartSplashScreenViewController.swift
//  LikeTok
//
//  Created by Artem Holod on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class StartSplashScreenViewController: BaseViewController {
    @IBOutlet private var beginButton: UIButton!
    var presenter: StartSplashScreenPresenterInput!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction func beginButtonDidTap(_ sender: Any) {
        presenter.didTapBeginButton()
    }
}

extension StartSplashScreenViewController: StartSplashScreenPresenterOutput {
    func showAuthModule() {
        // show Registration VC
    }
    
    func setupView() {
        beginButton.layer.cornerRadius = 10
        beginButton.setTitle(Strings.SplashScreen.begin, for: .normal)
    }
}
