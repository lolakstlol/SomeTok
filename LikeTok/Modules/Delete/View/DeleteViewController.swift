//
//  DeleteDeleteViewController.swift
//  LikeTok
//
//  Created by Artem Holod on 28/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class DeleteViewController: BaseViewController {
	var presenter: DeletePresenterInput!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

}

extension DeleteViewController: DeletePresenterOutput {

}
