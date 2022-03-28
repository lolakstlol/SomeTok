//
//  OtherProfilePresenterInput.swift
//  LikeTok
//
//  Created by Daniel on 20.02.22.
//

import Foundation

protocol OtherProfilePresenterInput: BasePresenting {
    func followButtonTap()
    func openSubscibersList()
    func openSubsciptionsList()
    func loadMore(_ type: FeedViewEnterOption)
    func didTapVideo(_ collectionType: FeedViewEnterOption,_ dataSourse: [FeedPost], index: Int)
//    func completeOnboarding()
}
