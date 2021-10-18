//
//  BaseViewController.swift
//  magnit-ios
//
//  Created by Dmitry Kosyakov on 24.08.2020.
//  Copyright © 2020 BSL.dev. All rights reserved.
//

import UIKit.UIViewController

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SentryManager.breadcrumbCapture(message: "Load Screen: \(String(describing: self))")
    }
    private lazy var spinner = LoaderViewController()
    
    func showLoader() {
        addChild(spinner)
        spinner.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner.view)
        spinner.spinner.startAnimation()
        spinner.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        spinner.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        spinner.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        spinner.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        spinner.didMove(toParent: self)
    }
    
    func hideLoader() {
        spinner.spinner.stopAnimation()
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
}
