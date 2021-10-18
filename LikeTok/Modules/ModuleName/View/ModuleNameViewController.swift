//
//  ModuleNameModuleNameViewController.swift
//  LikeTok
//
//  Created by Artem Holod on 18/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class ModuleNameViewController: BaseViewController {
	var presenter: ModuleNamePresenterInput!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

}

extension ModuleNameViewController: ModuleNamePresenterOutput {

}
