//
//  MyProfilePresenterInput.swift
//  LikeTok
//
//  Created by Daniel on 17.02.22.
//

import Foundation

protocol MyProfilePresenterInput: BasePresenting {
//    func completeOnboarding()
    func editButtonTap()
    func didTapVideo(_ collectionType: FeedViewEnterOption,_ dataSourse: [FeedPost], index: Int)
    func loadMore(_ type: FeedViewEnterOption)
}
