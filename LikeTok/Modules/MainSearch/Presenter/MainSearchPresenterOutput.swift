//
//  MainSearchMainSearchPresenterOutput.swift
//  LikeTok
//
//  Created by Artem Holod on 27/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import Foundation

protocol MainSearchPresenterOutput: AnyObject {
    func setAccounts(models: [SearchAccountsDatum])
    func setCategories(models: [CategoriesDatum])
    func setVideos(models: [CategoriesPost])
}
