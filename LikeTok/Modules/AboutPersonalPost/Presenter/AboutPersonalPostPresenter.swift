//
//  AboutPersonalPostPresenter.swift
//  LikeTok
//
//  Created by Daniel on 26.02.22.
//

import Foundation
import UIKit

final class AboutPersonalPostPresenter {
    
    private unowned let view: AboutPersonalPostPresenterOutput
    private var isFinal: Bool = false
    
    
    init(_ view: AboutPersonalPostPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
        view.setupUI()
    }
    
    func viewDidAppear() {
        view.animatedPresent()
    }

}

extension AboutPersonalPostPresenter: AboutPersonalPostPresenterInput {
    func closeButtonTap() {
        view.animatedDismiss()
    }

    func nextButtonTap() {
        if !isFinal {
            isFinal = true
            view.onNextButtonTap()
        } else {
            view.animatedDismiss()
        }
    }
}
