//
//  MainSearchMainSearchPresenterInput.swift
//  LikeTok
//
//  Created by Artem Holod on 27/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

protocol MainSearchPresenterInput: BasePresenting {
    func load(predict: String, type: MainSearchTypes)
    func didTapVideo(_ dataSourse: [FeedPost], index: Int)
    func followButtonTap(_ uuid: String)
}
