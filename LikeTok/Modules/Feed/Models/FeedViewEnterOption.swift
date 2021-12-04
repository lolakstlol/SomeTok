//
//  FeedViewEnterOption.swift
//  Marketplace
//
//  Created by  Daniil Kabachuk on 1/29/21.
//  Copyright © 2021 BSL. All rights reserved.
//

enum FeedViewEnterOption {
    case main
    case profilePosts((String, Int))
    case singlePost(String, Bool)
}
