//
//  FeedViewFeedViewInteractorInput.swift
//  marketplace
//
//  Created by Mikhail Lutskii on 20/11/2020.
//  Copyright © 2020 BSL. All rights reserved.
//

protocol FeedViewInteractorInput: AnyObject {
    func attach(_ output: FeedViewInteractorOutput)
    func updateType(_ type: FeedViewEnterOption)
    func getInitialFeed(with offset: Int)
    func getFeed(with offset: Int, cursor: String)
    func getUser()
    func sendMessage(_ message: String)
    func createLike()
    func deleteLike()
    func setCurrentPost(_ post: FeedResponse)
    func createShareLink(postUUID: String)
    func isAuthorized() -> Bool
    func subscribe(userId: String)
    func unsubscribe(userId: String)
    func stopVideo()
    func playVideo()
    func screenTapAction()

    var configurators: [FeedCellConfigurator]? { get set }
    var isUserFeed: Bool { get set }
    var type: FeedViewEnterOption { get }
}
