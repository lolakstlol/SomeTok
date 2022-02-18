//
//  MyProfilePresenter.swift
//  LikeTok
//
//  Created by Daniel on 17.02.22.
//

import Foundation
import UIKit

final class MyProfilePresenter {
    private unowned let view: MyProfilePresenterOutput
    
    init(_ view: MyProfilePresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
//        view.onFetchOnboardingData(data)
    }

}

extension MyProfilePresenter: MyProfilePresenterInput {

}
