//
//  FeedFeedPresenter.swift
//  LikeTok
//
//  Created by Danik on 06/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

final class FeedPresenter {
    private unowned let view: FeedPresenterOutput

    init(_ view: FeedPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
     
    }

}

extension FeedPresenter: FeedPresenterInput {

}
