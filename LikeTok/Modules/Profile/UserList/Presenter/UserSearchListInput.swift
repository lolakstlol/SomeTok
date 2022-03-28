//
//  UserSearchListInput.swift
//  LikeTok
//
//  Created by Daniel on 20.03.22.
//

import Foundation

protocol UserSearchListInput: BasePresenting {
    func load(_ type: UserSearchTypes)
    func load(_ predicate: String, type: UserSearchTypes)
    func loadMore(_ type: UserSearchTypes)
    func followButtonTap(_ uuid: String)
    func updateSelectedType(_ type: UserSearchTypes)
}
