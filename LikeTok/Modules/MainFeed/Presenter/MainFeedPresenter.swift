//
//  MainFeedMainFeedPresenter.swift
//  LikeTok
//
//  Created by Artem Holod on 01/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

final class MainFeedPresenter {
    private unowned let view: MainFeedPresenterOutput

    init(_ view: MainFeedPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
     
    }

}

extension MainFeedPresenter: MainFeedPresenterInput {

}
