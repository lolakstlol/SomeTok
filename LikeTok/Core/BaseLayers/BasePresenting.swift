//
//  BasePresenting.swift
//  magnit-ios
//
//  Created by Dmitry Kosyakov on 24.08.2020.
//  Copyright © 2020 BSL.dev. All rights reserved.
//

import Foundation

protocol BasePresenting: AnyObject {
    func viewDidLoad()
    func viewDidLayoutSubviews()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
    func showLoader()
    func hideLoader()
}

extension BasePresenting {
    func viewDidLoad() {}
    func viewDidLayoutSubviews() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
    func showLoader() {}
    func hideLoader() {}
}
