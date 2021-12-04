//
//  FeedRequest.swift
//  LikeTok
//
//  Created by Daniel on 22.11.21.
//

import Foundation

//final class FeedRequest: BaseRequest<[FeedResponse]> {
//    private let userId: String?
//    private let offset: Int
//
//    init(_ userId: String?, _ offset: Int) {
//        self.userId = userId
//        self.offset = offset
//    }
//
//    override var httpMethod: HTTPMethod {
//        return .get
//    }
//
//    override var path: String {
//        return HTTPNetworkRoute.FeedV2.posts.path
//    }
//
//    override var parameters: StringDict {
//        let defaultsService = UserDefaultsManager.shared
//
//        guard let userId = userId else {
//            return ["offset": "\(offset)",
//                    "longitude": "\(point.1)",
//                    "latitude": "\(point.0)"]
//        }
//
//        return ["user_id": userId,
//                "longitude": "\(point.1)",
//                "latitude": "\(point.0)"]
//    }
//}
