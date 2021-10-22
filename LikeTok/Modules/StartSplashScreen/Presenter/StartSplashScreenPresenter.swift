//
//  StartSplashScreenStartSplashScreenPresenter.swift
//  LikeTok
//
//  Created by Artem Holod on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

final class StartSplashScreenPresenter {
    private unowned let view: StartSplashScreenPresenterOutput

    init(_ view: StartSplashScreenPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
        view.setupView()
    }

}

extension StartSplashScreenPresenter: StartSplashScreenPresenterInput {
    func didTapBeginButton() {
        view.showAuthModule()
    }
}
