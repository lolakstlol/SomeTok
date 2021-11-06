//
//  FeedViewFeedViewInteractorInput.swift
//  marketplace
//
//  Created by Mikhail Lutskii on 20/11/2020.
//  Copyright © 2020 BSL. All rights reserved.
//

protocol FeedViewInteractorInput: class {
    func attach(_ output: FeedViewInteractorOutput)
    func getFeed(with offset: Int)
    func getUser()
    func sendMessage(_ message: String)
    func createLike()
    func deleteLike()
    func setCurrentPost(_ post: FeedResponse)
    func isAuthorized() -> Bool
    func subscribe(userId: String)
    func unsubscribe(userId: String)

    var configurators: [FeedCellConfigurator]? { get set }
    var isUserFeed: Bool { get set }
    var type: FeedViewEnterOption { get }
}
