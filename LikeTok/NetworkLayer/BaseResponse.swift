//
//  BaseResponse.swift
//  LikeTok
//
//  Created by Daniel on 9.12.21.
//

import Foundation

class FatherOfBaseResponse {
    var headers: [AnyHashable: Any]? = [:]
}

class BaseResponse: FatherOfBaseResponse, Decodable {}
